import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const String _font = 'Inter';

  // display
  /// Hero text — app name, onboarding headline
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _font,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // headlines
  /// Screen titles — "Explore", "Communities", "Hey, Aline"
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _font,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.25,
  );

  /// Section titles — "Happening on campus"
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _font,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.3,
  );

  // titles
  /// Sub-section labels — "For you", "Browse by category"
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Card titles, list item names
  static const TextStyle titleMedium = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // body
  /// Descriptions, about text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _font,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  /// Secondary body, supporting text
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _font,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // labels
  /// Button text, chip labels
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  /// Small UI labels — counts, metadata
  static const TextStyle labelMedium = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// Timestamps, captions, uppercase tags
  static const TextStyle labelSmall = TextStyle(
    fontFamily: _font,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.6,
  );
}
