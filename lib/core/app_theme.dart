import 'package:flutter/material.dart';
import 'package:task_manager_apps/core/app_colors.dart';
import 'package:task_manager_apps/core/app_text_styles.dart';

class AppTheme {
  /// LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.lightBackground,

    // loginAndSignupBackground: AppColors.
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),

    textTheme: TextTheme(
      titleLarge: AppTextStyles.titleLarge.copyWith(color: Colors.black),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: Colors.white),
      bodyMedium: AppTextStyles.buttonText.copyWith(color: Colors.black),
      displayLarge: AppTextStyles.displayLarge.copyWith(color: Colors.black),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: Colors.grey),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightButton,
        foregroundColor: AppColors.lightText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    iconTheme: const IconThemeData(color: Colors.black),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.green,
        fixedSize: Size.fromWidth(double.maxFinite),
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
  );

  /// DARK THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
    ),

    textTheme: TextTheme(
      titleLarge: AppTextStyles.titleLarge.copyWith(color: Colors.black),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: Colors.white),
      bodyMedium: AppTextStyles.buttonText.copyWith(color: Colors.black),
      displayLarge: AppTextStyles.displayLarge.copyWith(color: Colors.black),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: Colors.grey),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkButton,
        foregroundColor: AppColors.darkText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        fixedSize: Size.fromWidth(double.maxFinite),
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
    ),
  );
}
