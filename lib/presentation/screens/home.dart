import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nibbles_ecommerce/configs/app.dart';
import 'package:nibbles_ecommerce/configs/configs.dart';
import 'package:nibbles_ecommerce/core/constants/assets.dart';
import 'package:nibbles_ecommerce/core/constants/colors.dart';
import 'package:nibbles_ecommerce/core/constants/strings.dart';
import 'package:nibbles_ecommerce/presentation/widgets/meals_horizontal_listview.dart';
import 'package:nibbles_ecommerce/presentation/widgets/package_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 1;
  int packagesCurrentPage = 0;

  PageController _nibblesPageController = PageController();
  PageController _packagesPageController = PageController();

  @override
  void initState() {
    _nibblesPageController = PageController(initialPage: currentPage);
    _packagesPageController =
        PageController(initialPage: packagesCurrentPage, viewportFraction: .8);
    super.initState();
  }

  List<Tab> tabBarItems = List.generate(
    AppStrings.tabStrings.length,
    (index) => Tab(
      text: AppStrings.tabStrings[index].toUpperCase(),
    ),
  );

  List<Widget> tabViews = List.generate(
      AppStrings.tabStrings.length, (index) => const MealsHorizontalListview());

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppDimensions.normalize(255),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          AppAssets.curvedRec,
                          colorFilter: const ColorFilter.mode(
                              AppColors.antiqueRuby, BlendMode.srcIn),
                          height: AppDimensions.normalize(145),
                          width: AppDimensions.normalize(170),
                        ),
                        Positioned(
                          top: AppDimensions.normalize(20),
                          left: AppDimensions.normalize(60),
                          child: SvgPicture.asset(
                            AppAssets.nibblesLogo,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        Positioned(
                          top: AppDimensions.normalize(45),
                          left: AppDimensions.normalize(14),
                          child: Text(
                            "Good food for\nYour Loved ones".toUpperCase(),
                            style: AppText.h2
                                ?.copyWith(color: Colors.white, height: 1.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: AppDimensions.normalize(20),
                    right: AppDimensions.normalize(10),
                    child: SvgPicture.asset(
                      AppAssets.bell,
                      colorFilter: const ColorFilter.mode(
                          AppColors.deepTeal, BlendMode.srcIn),
                    ),
                  ),
                  Positioned(
                    top: AppDimensions.normalize(80),
                    child: Padding(
                      padding: Space.hf(),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.normalize(7),
                        ),
                        child: Container(
                          height: AppDimensions.normalize(22),
                          width: AppDimensions.normalize(130),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.normalize(7),
                            ),
                          ),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Search Here",
                                  labelStyle: AppText.b2
                                      ?.copyWith(color: AppColors.greyText),
                                  prefixIcon: Padding(
                                    padding: Space.all(.5, .8),
                                    child: SvgPicture.asset(AppAssets.search),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppDimensions.normalize(107),
                    right: 0,
                    left: 0,
                    child: SizedBox(
                      height: AppDimensions.normalize(140),
                      // width: AppDimensions.normalize(150),
                      child: PageView.builder(
                          controller: _nibblesPageController,
                          onPageChanged: (pos) {
                            setState(() {
                              currentPage = pos;
                            });
                          },
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: AppDimensions.normalize(5)),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    AppAssets.nibblesPng,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    top: AppDimensions.normalize(239),
                    left: AppDimensions.normalize(60),
                    child: SmoothPageIndicator(
                      controller: _nibblesPageController,
                      count: 4,
                      effect: ExpandingDotsEffect(
                          activeDotColor: AppColors.deepTeal,
                          dotColor: AppColors.lightGrey,
                          dotHeight: AppDimensions.normalize(3),
                          dotWidth: AppDimensions.normalize(3)),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: Space.hf(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Packages".toUpperCase(),
                        style: AppText.h2b,
                      ),
                      const TextButton(onPressed: null, child: Text("View All"))
                    ],
                  ),
                ),
                Space.yf(),
                SizedBox(
                  height: AppDimensions.normalize(135),
                  // width: AppDimensions.normalize(150),
                  child: PageView.builder(
                      controller: _packagesPageController,
                      onPageChanged: (pos) {
                        setState(() {
                          packagesCurrentPage = pos;
                        });
                      },
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return PackageItem();
                      }),
                ),
                // Space.yf(2),
                SmoothPageIndicator(
                  controller: _packagesPageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.deepTeal,
                      dotColor: AppColors.lightGrey,
                      dotHeight: AppDimensions.normalize(3),
                      dotWidth: AppDimensions.normalize(3)),
                ),
                Space.yf(1.4),
                Padding(
                  padding: Space.hf(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Meals".toUpperCase(),
                        style: AppText.h2b,
                      ),
                      const TextButton(onPressed: null, child: Text("View All"))
                    ],
                  ),
                ),
                Space.yf(.15),
                DefaultTabController(
                  length: 6,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: AppDimensions.normalize(15),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: ButtonsTabBar(
                              buttonMargin: EdgeInsets.only(
                                  right: AppDimensions.normalize(6),
                                  left: AppDimensions.normalize(4)),
                              contentPadding: Space.hf(.5),
                              backgroundColor: AppColors.tabColor,
                              labelStyle:
                                  AppText.b1?.copyWith(color: Colors.white),
                              unselectedBackgroundColor: Colors.transparent,
                              unselectedLabelStyle: AppText.b2
                                  ?.copyWith(color: AppColors.greyText),
                              tabs: tabBarItems),
                        ),
                      ),
                      Space.y1!,
                      SizedBox(
                        height: AppDimensions.normalize(70),
                        child: TabBarView(children: tabViews),
                      ),
                    ],
                  ),
                ),
                Space.yf(6),
              ],
            )
          ],
        ),
      ),
    );
  }
}
