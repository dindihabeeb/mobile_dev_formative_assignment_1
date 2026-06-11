import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // dark backgrounds
  static const Color background      = Color(0xFF080B15);
  static const Color surface         = Color(0xFF111828);
  static const Color surfaceElevated = Color(0xFF1C2438);
  static const Color border          = Color(0xFF1E2540);

  // brand
  static const Color primary     = Color(0xFF7C4DFF);
  static const Color primaryDark = Color(0xFF5C35CC);
  static const Color accent      = Color(0xFF9C6FFF);

  // semantic
  static const Color success = Color(0xFF20B958);
  static const Color error   = Color(0xFFE8334A);
  static const Color info    = Color(0xFF3D8EF0);

  // text (dark theme)
  static const Color textPrimary   = Color(0xFFF2F4FF);
  static const Color textSecondary = Color(0xFF8B90A8);
  static const Color textMuted     = Color(0xFF555C78);

  // light backgrounds
  static const Color backgroundLight      = Color(0xFFF4F6FB);
  static const Color surfaceLight         = Color(0xFFFFFFFF);
  static const Color surfaceElevatedLight = Color(0xFFEDF0F8);
  static const Color borderLight          = Color(0xFFDDE1F0);

  // text (light theme)
  static const Color textPrimaryLight   = Color(0xFF0D1128);
  static const Color textSecondaryLight = Color(0xFF5C6080);
  static const Color textMutedLight     = Color(0xFF9095B0);

  // category palette
  static const Color catCareers          = Color(0xFFF0A500);
  static const Color catSocial           = Color(0xFFE8334A);
  static const Color catSports           = Color(0xFF20B958);
  static const Color catTech             = Color(0xFF3D8EF0);
  static const Color catEntrepreneurship = Color(0xFF9747FF);

  static const Map<String, Color> categoryColors = {
    'Careers'         : catCareers,
    'Social'          : catSocial,
    'Sports'          : catSports,
    'Tech'            : catTech,
    'Entrepreneurship': catEntrepreneurship,
  };

  static Color forCategory(String category) =>
      categoryColors[category] ?? primary;

  // misc
  static const Color online  = Color(0xFF20B958);
  static const Color scrim   = Color(0x99000000);
  static const Color shimmer = Color(0xFF1E2540);

  // legacy aliases
  static const Color orange     = Color(0xFFF0A500);
  static const Color green      = success;
  static const Color purple     = accent;
  static const Color surfaceAlt = surfaceElevated;
}
