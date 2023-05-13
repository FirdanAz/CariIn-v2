import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightMode() {
    var color = AppColor.theme(Brightness.light);

    return ThemeData(
      useMaterial3: true,
      // primaryColor: primaryColor,
      // primarySwatch: primaryMaterialColor,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: color.primary,
        onPrimary: color.black,
        secondary: color.secondary,
        onSecondary: color.white,
        error: const Color(0xFFB3261E),
        onError: color.white,
        background: color.background,
        onBackground: color.onBackground,
        surface: color.background,
        onSurface: color.onBackground,
      ),
      fontFamily: 'Outfit',
      iconTheme: IconThemeData(color: color.black),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: color.secondary,
        backgroundColor:
            Color.alphaBlend(color.primary.withOpacity(0.08), color.white),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }

  static ThemeData getDarkMode() {
    var color = AppColor.theme(Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      // primaryColor: primaryColor,
      // primarySwatch: primaryMaterialColor,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: color.primary,
        onPrimary: color.black,
        secondary: color.secondary,
        onSecondary: color.white,
        error: const Color(0xFFB3261E),
        onError: color.white,
        background: color.background,
        onBackground: color.onBackground,
        surface: color.background,
        onSurface: color.onBackground,
      ),
      fontFamily: 'Outfit',
      iconTheme: IconThemeData(color: color.black),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: color.secondary,
        backgroundColor:
            Color.alphaBlend(color.primary.withOpacity(0.08), color.white),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }
}
