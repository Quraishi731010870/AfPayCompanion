import 'package:flutter/material.dart';

abstract final class AppColors {
  static const navy = Color(0xFF071D3B),
      blue = Color(0xFF1565C0),
      teal = Color(0xFF008F83),
      saffron = Color(0xFFF4B942),
      lightSurface = Color(0xFFF5F7FA),
      darkSurface = Color(0xFF07111F);
}

abstract final class AppSpacing {
  static const xs = 4.0, sm = 8.0, md = 16.0, lg = 24.0, xl = 32.0;
}

ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.teal,
    brightness: brightness,
    surface: dark ? const Color(0xFF101D2D) : Colors.white,
    primary: dark ? const Color(0xFF5ED6C8) : AppColors.navy,
    secondary: dark ? AppColors.saffron : AppColors.teal,
  );
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: dark
        ? AppColors.darkSurface
        : AppColors.lightSurface,
    textTheme: Typography.material2021(platform: TargetPlatform.android).black
        .apply(
          bodyColor: dark ? const Color(0xFFE7EDF5) : AppColors.navy,
          displayColor: dark ? Colors.white : AppColors.navy,
        ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surface,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: .55)),
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
      height: 72,
      indicatorColor: scheme.primaryContainer,
    ),
  );
}
