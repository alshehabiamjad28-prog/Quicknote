import 'package:flutter/material.dart';
import 'package:myproject/core/constants/theme/theme_mod.dart';

class AppTheme {

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightScheme,
      brightness: Brightness.light,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.darkScheme,
      brightness: Brightness.dark,
    );
  }
}