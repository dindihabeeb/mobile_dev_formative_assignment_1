class AppSpacing {
  AppSpacing._();

  // base scale
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 16;
  static const double lg  = 24;
  static const double xl  = 32;
  static const double xxl = 48;

  // screen padding
  static const double screenH = md;   // horizontal page margin
  static const double screenV = lg;   // vertical page margin

  // border radius
  static const double radiusSm   = 8;
  static const double radiusMd   = 12;
  static const double radiusLg   = 16;
  static const double radiusXl   = 24;
  static const double radiusFull = 999;

  // touch targets
  /// Minimum interactive area — WCAG 2.5.5 recommends 44pt; we use 48.
  static const double minTouchTarget = 48;

  // card internals
  static const double cardPaddingH = md;
  static const double cardPaddingV = md;
}
