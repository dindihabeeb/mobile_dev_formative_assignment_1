import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  // dark
  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        bg: AppColors.background,
        surface: AppColors.surface,
        surfaceElevated: AppColors.surfaceElevated,
        border: AppColors.border,
        textPrimary: AppColors.textPrimary,
        textSecondary: AppColors.textSecondary,
      );

  // light
  static ThemeData get light => _build(
        brightness: Brightness.light,
        bg: AppColors.backgroundLight,
        surface: AppColors.surfaceLight,
        surfaceElevated: AppColors.surfaceElevatedLight,
        border: AppColors.borderLight,
        textPrimary: AppColors.textPrimaryLight,
        textSecondary: AppColors.textSecondaryLight,
      );

  // builder
  static ThemeData _build({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color surfaceElevated,
    required Color border,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: bg,

      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: Colors.black,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        surface: surface,
        onSurface: textPrimary,
        error: AppColors.error,
        onError: Colors.white,
      ),

      // text
      textTheme: TextTheme(
        displayLarge:  AppTypography.displayLarge.copyWith(color: textPrimary),
        headlineLarge: AppTypography.headlineLarge.copyWith(color: textPrimary),
        headlineMedium:AppTypography.headlineMedium.copyWith(color: textPrimary),
        titleLarge:    AppTypography.titleLarge.copyWith(color: textPrimary),
        titleMedium:   AppTypography.titleMedium.copyWith(color: textPrimary),
        bodyLarge:     AppTypography.bodyLarge.copyWith(color: textPrimary),
        bodyMedium:    AppTypography.bodyMedium.copyWith(color: textSecondary),
        labelLarge:    AppTypography.labelLarge.copyWith(color: textPrimary),
        labelMedium:   AppTypography.labelMedium.copyWith(color: textSecondary),
        labelSmall:    AppTypography.labelSmall.copyWith(color: textSecondary),
      ),

      // elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, AppSpacing.minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          textStyle: AppTypography.labelLarge,
          elevation: 0,
        ),
      ),

      // outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, AppSpacing.minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      // text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(AppSpacing.minTouchTarget, AppSpacing.minTouchTarget),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      // input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceElevated,
        hintStyle: AppTypography.bodyMedium.copyWith(color: textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      // divider
      dividerTheme: DividerThemeData(
        color: border,
        thickness: 1,
        space: 1,
      ),

      // app bar
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: AppTypography.titleLarge.copyWith(color: textPrimary),
      ),

      // bottom nav
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? AppColors.surface : AppColors.surfaceLight,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // icon
      iconTheme: IconThemeData(color: textSecondary, size: 22),
    );
  }
}
