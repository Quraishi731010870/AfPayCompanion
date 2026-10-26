import 'package:flutter/material.dart';

abstract final class AppColors {
  static const navy = Color(0xFF082B3A),
      blue = Color(0xFF246BFD),
      teal = Color(0xFF087F72),
      mint = Color(0xFF47C8B5),
      saffron = Color(0xFFF3B33D),
      lightSurface = Color(0xFFF6F8F8),
      darkSurface = Color(0xFF071517);
}

abstract final class AppSpacing {
  static const xs = 4.0, sm = 8.0, md = 16.0, lg = 24.0, xl = 32.0;
}

ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.teal,
    brightness: brightness,
    surface: dark ? const Color(0xFF102225) : Colors.white,
    primary: dark ? const Color(0xFF67DDCB) : AppColors.teal,
    secondary: dark ? AppColors.saffron : AppColors.teal,
  );
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: dark
        ? AppColors.darkSurface
        : AppColors.lightSurface,
    fontFamily: 'sans-serif',
    textTheme: Typography.material2021(platform: TargetPlatform.android).black
        .apply(
          bodyColor: dark ? const Color(0xFFE7EDF5) : AppColors.navy,
          displayColor: dark ? Colors.white : AppColors.navy,
        ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: dark ? Colors.white : AppColors.navy,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: dark ? Colors.white : AppColors.navy,
        fontSize: 21,
        fontWeight: FontWeight.w800,
        letterSpacing: -.35,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surface,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: .42)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 68,
      elevation: 0,
      backgroundColor: scheme.surface,
      indicatorColor: scheme.primary.withValues(alpha: .13),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 11,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w800
              : FontWeight.w600,
          color: states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.onSurfaceVariant,
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant.withValues(alpha: .45),
    ),
  );
}
