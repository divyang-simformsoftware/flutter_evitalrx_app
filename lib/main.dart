import 'package:flutter/material.dart';
import 'service/navigation_service.dart';
import 'utils/app_nav_path.dart';
import 'utils/app_theme.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appTheme,
    initialRoute: AppNavPath.splashPage,
    onGenerateRoute: NavigationService().onGeneratedRoutes,
    );
  }
}
