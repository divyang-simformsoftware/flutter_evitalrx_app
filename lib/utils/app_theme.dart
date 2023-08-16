import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final AppTheme _appTheme = AppTheme._();
  factory AppTheme() => _appTheme;

  ThemeData appTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.indigo,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      toolbarHeight: 0,
      scrolledUnderElevation: 0,
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    ),
  );
}
