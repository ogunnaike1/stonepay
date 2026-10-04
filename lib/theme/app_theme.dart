import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radii.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      secondary: AppColors.paleBlue,
      onSecondary: AppColors.deepBlue,
      surface: AppColors.surface,
      onSurface: AppColors.primaryText,
      onSurfaceVariant: AppColors.secondaryText,
      error: AppColors.error,
      onError: AppColors.background,
      outline: AppColors.border,
    ),
    textTheme: const TextTheme(
      displaySmall: AppTextStyles.brand,
      headlineMedium: AppTextStyles.headline,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.secondary,
      labelLarge: AppTextStyles.button,
      labelMedium: AppTextStyles.label,
      bodySmall: AppTextStyles.caption,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.onAccent,
        disabledBackgroundColor: AppColors.disabledSurface,
        disabledForegroundColor: AppColors.disabledText,
        textStyle: AppTextStyles.button,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.medium),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.interactiveText,
        disabledForegroundColor: AppColors.disabledText,
        textStyle: AppTextStyles.button,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        side: const BorderSide(color: AppColors.border),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.medium),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.interactiveText,
        disabledForegroundColor: AppColors.disabledText,
        textStyle: AppTextStyles.button,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.medium),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.all(AppSpacing.md),
      labelStyle: AppTextStyles.label.copyWith(color: AppColors.secondaryText),
      floatingLabelStyle: AppTextStyles.label.copyWith(
        color: AppColors.interactiveText,
      ),
      hintStyle: AppTextStyles.secondary,
      helperStyle: AppTextStyles.caption,
      errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
      errorMaxLines: 3,
      prefixIconColor: AppColors.secondaryText,
      suffixIconColor: AppColors.secondaryText,
      border: const OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.border),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.border),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.disabledSurface),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.paleBlue, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadii.medium,
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
    ),
  );
}
