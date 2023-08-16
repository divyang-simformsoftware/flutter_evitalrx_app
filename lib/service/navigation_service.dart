import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evitalrx_app/cubit/login/login_cubit.dart';
import 'package:flutter_evitalrx_app/pages/dashboard_page.dart';
import 'package:flutter_evitalrx_app/pages/login_page.dart';

import '../cubit/splash/splash_cubit.dart';
import '../cubit/users/user_cubit.dart';
import '../pages/splash_page.dart';
import '../utils/app_nav_path.dart';
import '../utils/app_strings.dart';

class NavigationService {
  Route<MaterialPageRoute> onGeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppNavPath.splashPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SplashCubit>(
            create: (context) => SplashCubit(),
            child: const SplashPage(),
          ),
        );
      case AppNavPath.loginPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          ),
        );
      case AppNavPath.dashboardPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<UserCubit>(
            create: (context) => UserCubit(),
            child: const DashboardPage(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  Route<MaterialPageRoute> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text(AppStrings.pageNotFoundText),
  
          ),
        );
      },
    );
  }
}
