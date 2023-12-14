import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nibbles_ecommerce/application/blocs/meals/meals_bloc.dart';
import 'package:nibbles_ecommerce/application/blocs/packages/packages_bloc.dart';
import 'package:nibbles_ecommerce/application/cubits/search/search_cubit.dart';
import 'package:nibbles_ecommerce/repositories/categories_repos/categories_repos.dart';
import 'package:nibbles_ecommerce/repositories/meals_repos/meal_repo.dart';
import 'package:nibbles_ecommerce/repositories/packages_repos/package_repo.dart';

import '../../application/blocs/auth_bloc/auth_bloc.dart';
import '../../application/blocs/categories/categories_bloc.dart';
import '../../application/blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../application/blocs/user_bloc/user_bloc.dart';
import '../../application/cubits/navigation/navigation_cubit.dart';
import '../../repositories/auth_repos/auth_repos.dart';
import '../../repositories/user_repos/user_repos.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
              firebaseAuth: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance),
        ),
        RepositoryProvider(
          create: (context) =>
              UserRepository(firebaseFirestore: FirebaseFirestore.instance),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(InitializeAuthEvent()),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => UserBloc(
              authBloc: context.read<AuthBloc>(),
              userRepository: context.read<UserRepository>(),
            )..add(StartUserEvent()),
          ),
          BlocProvider(
            create: (context) =>
                SignUpBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CategoriesBloc(categoriesRepos: CategoriesRepos())
                  ..add(
                    LoadCategories(),
                  ),
          ),
          BlocProvider(
            create: (context) => PackagesBloc(packagesRepos: PackagesRepos())
              ..add(
                LoadPackages(),
              ),
          ),
          BlocProvider(
            create: (context) => MealsBloc(mealsRepo: MealsRepo()),
          ),
          BlocProvider(create: (context) => NavigationCubit()),
          BlocProvider(
            create: (context) => SearchCubit(
                mealsRepo: MealsRepo(), packagesRepos: PackagesRepos()),
          ),
        ],
        child: MaterialApp(
          title: 'Nibbles',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.splash,
          theme: ThemeData(
            fontFamily: AppStrings.fontFamily,
            scaffoldBackgroundColor: AppColors.scafoldBackground,
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateColor.resolveWith(
                (states) => AppColors.lightGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
