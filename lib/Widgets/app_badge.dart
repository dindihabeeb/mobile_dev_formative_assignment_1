import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// for-you badge
class ForYouBadge extends StatelessWidget {
  const ForYouBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Recommended for you',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.black, size: 10),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'For you',
              style: AppTypography.labelSmall.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// role badge
class RoleBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const RoleBadge({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.accent;
    return Semantics(
      label: '$label role',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(color: c.withValues(alpha: 0.4)),
        ),
        child: Text(
          label.toUpperCase(),
          style: AppTypography.labelSmall.copyWith(
            color: c,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}

// online dot
class OnlineDot extends StatelessWidget {
  final double size;

  const OnlineDot({super.key, this.size = 8});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Online',
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.online,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// count badge
class CountBadge extends StatelessWidget {
  final int count;

  const CountBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();
    return Semantics(
      label: '$count notification${count == 1 ? "" : "s"}',
      child: Container(
        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Text(
          count > 99 ? '99+' : '$count',
          style: AppTypography.labelSmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
