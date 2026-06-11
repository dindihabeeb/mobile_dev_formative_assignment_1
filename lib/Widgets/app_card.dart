import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Base card container used across the app.
/// Wrap any content in [AppCard] to get the consistent surface, border, and radius.
class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final String? semanticLabel;
  final double borderRadius;
  final bool hasBorder;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.semanticLabel,
    this.borderRadius = AppSpacing.radiusLg,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color ?? AppColors.surface;

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: hasBorder
            ? Border.all(color: AppColors.border, width: 1)
            : null,
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.cardPaddingH,
              vertical: AppSpacing.cardPaddingV,
            ),
        child: child,
      ),
    );

    if (onTap == null) return card;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: AppColors.primary.withValues(alpha: 0.08),
          highlightColor: AppColors.primary.withValues(alpha: 0.04),
          child: card,
        ),
      ),
    );
  }
}
