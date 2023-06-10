import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightMode(BuildContext context) {
    var color = AppColor.theme(Brightness.light);

    return ThemeData(
      useMaterial3: true,
      // primaryColor: primaryColor,
      // primarySwatch: primaryMaterialColor,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: color.primary,
        onPrimary: color.onPrimary,
        primaryContainer: color.primaryContainer,
        onPrimaryContainer: color.onPrimaryContainer,
        secondary: color.secondary,
        onSecondary: color.onSecondary,
        secondaryContainer: color.secondaryContainer,
        onSecondaryContainer: color.onSecondaryContainer,
        tertiary: color.tertiary,
        onTertiary: color.onTertiary,
        tertiaryContainer: color.tertiaryContainer,
        onTertiaryContainer: color.onTertiaryContainer,
        error: color.error,
        errorContainer: color.errorContainer,
        onError: color.onError,
        onErrorContainer: color.onErrorContainer,
        background: color.background,
        onBackground: color.onBackground,
        outline: color.outline,
        onInverseSurface: color.onInverseSurface,
        inverseSurface: color.inverseSurface,
        inversePrimary: color.inverseSurface,
        shadow: color.shadow,
        surfaceTint: color.surfaceTint,
        outlineVariant: color.outlineVariant,
        scrim: color.scrim,
        surface: color.surface,
        onSurface: color.onSurface,
        surfaceVariant: color.surfaceVariant,
        onSurfaceVariant: color.onSurfaceVariant,
      ),
      fontFamily: 'Outfit',
      iconTheme: IconThemeData(color: color.black),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: color.primary,
        backgroundColor: color.surfaceContainer.withOpacity(0.9),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }

  static ThemeData getDarkMode(BuildContext context) {
    var color = AppColor.theme(Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      // primaryColor: primaryColor,
      // primarySwatch: primaryMaterialColor,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: color.primary,
        onPrimary: color.onPrimary,
        primaryContainer: color.primaryContainer,
        onPrimaryContainer: color.onPrimaryContainer,
        secondary: color.secondary,
        onSecondary: color.onSecondary,
        secondaryContainer: color.secondaryContainer,
        onSecondaryContainer: color.onSecondaryContainer,
        tertiary: color.tertiary,
        onTertiary: color.onTertiary,
        tertiaryContainer: color.tertiaryContainer,
        onTertiaryContainer: color.onTertiaryContainer,
        error: color.error,
        errorContainer: color.errorContainer,
        onError: color.onError,
        onErrorContainer: color.onErrorContainer,
        background: color.background,
        onBackground: color.onBackground,
        outline: color.outline,
        onInverseSurface: color.onInverseSurface,
        inverseSurface: color.inverseSurface,
        inversePrimary: color.inverseSurface,
        shadow: color.shadow,
        surfaceTint: color.surfaceTint,
        outlineVariant: color.outlineVariant,
        scrim: color.scrim,
        surface: color.surface,
        onSurface: color.onSurface,
        surfaceVariant: color.surfaceVariant,
        onSurfaceVariant: color.onSurfaceVariant,
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
