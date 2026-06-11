import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

enum AppButtonVariant { primary, secondary, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool fullWidth;
  final bool loading;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.fullWidth = true,
    this.loading = false,
  });

  const AppButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.loading = false,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.loading = false,
  }) : variant = AppButtonVariant.ghost;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Border? border;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = AppColors.primary;
        fg = Colors.black;
        break;
      case AppButtonVariant.secondary:
        bg = Colors.transparent;
        fg = AppColors.primary;
        border = Border.all(color: AppColors.primary, width: 1.5);
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = AppColors.primary;
        break;
    }

    final content = loading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: fg,
            ),
          )
        : Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: fg, size: 18),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(label, style: AppTypography.labelLarge.copyWith(color: fg)),
            ],
          );

    return Semantics(
      button: true,
      label: label,
      enabled: onPressed != null,
      child: GestureDetector(
        onTap: loading ? null : onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: fullWidth ? double.infinity : null,
          height: AppSpacing.minTouchTarget,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: onPressed == null ? bg.withValues(alpha: 0.4) : bg,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: border,
          ),
          alignment: Alignment.center,
          child: content,
        ),
      ),
    );
  }
}
