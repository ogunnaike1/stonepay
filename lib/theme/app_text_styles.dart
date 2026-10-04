import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const brand = TextStyle(
    fontSize: 40,
    height: 1.2,
    fontWeight: FontWeight.w600,
    letterSpacing: -1.2,
    color: AppColors.primaryText,
  );
  static const headline = TextStyle(
    fontSize: 28,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );
  static const body = TextStyle(
    fontSize: 16,
    height: 1.6,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );
  static const secondary = TextStyle(
    fontSize: 15,
    height: 1.6,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    color: AppColors.secondaryText,
  );
  static const button = TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w600,
    color: AppColors.onAccent,
  );

  static const label = TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  static const caption = TextStyle(
    fontSize: 12,
    height: 1.5,
    color: AppColors.secondaryText,
  );
  static const logo = TextStyle(
    fontSize: 48,
    height: 1,
    fontWeight: FontWeight.w600,
    color: AppColors.onAccent,
  );
}
