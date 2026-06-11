import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// category chip

class CategoryChip extends StatelessWidget {
  final String label;
  final Color? color;
  final bool compact;

  const CategoryChip({
    super.key,
    required this.label,
    this.color,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.forCategory(label);
    return Semantics(
      label: '$label category',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.sm : 10,
          vertical: compact ? 3 : AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(color: c.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: c,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// interest chip

class InterestChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? color;

  const InterestChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.accent;
    return Semantics(
      button: onTap != null,
      selected: isSelected,
      label: '$label interest${isSelected ? ", selected" : ""}',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          constraints: const BoxConstraints(minHeight: AppSpacing.minTouchTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? c.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(
              color: isSelected ? c : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isSelected ? c : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

// status chip

enum StatusVariant { going, rsvp, joined, join, finished, level }

class StatusChip extends StatelessWidget {
  final String label;
  final StatusVariant variant;
  final VoidCallback? onTap;

  const StatusChip({
    super.key,
    required this.label,
    required this.variant,
    this.onTap,
  });

  factory StatusChip.going()    => const StatusChip(label: '✓  Going',   variant: StatusVariant.going);
  factory StatusChip.rsvp({VoidCallback? onTap}) =>
      StatusChip(label: 'RSVP', variant: StatusVariant.rsvp, onTap: onTap);
  factory StatusChip.joined()   => const StatusChip(label: 'Joined',    variant: StatusVariant.joined);
  factory StatusChip.join({VoidCallback? onTap}) =>
      StatusChip(label: 'Join', variant: StatusVariant.join, onTap: onTap);
  factory StatusChip.finished() => const StatusChip(label: 'Finished',  variant: StatusVariant.finished);
  factory StatusChip.level(int n) =>
      StatusChip(label: 'Level $n', variant: StatusVariant.level);

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (variant) {
      case StatusVariant.going:
        bg = AppColors.success;
        fg = Colors.black;
        break;
      case StatusVariant.rsvp:
        bg = AppColors.primary;
        fg = Colors.black;
        break;
      case StatusVariant.joined:
        bg = Colors.transparent;
        fg = AppColors.textSecondary;
        break;
      case StatusVariant.join:
        bg = AppColors.accent;
        fg = Colors.white;
        break;
      case StatusVariant.finished:
        bg = AppColors.border;
        fg = AppColors.textMuted;
        break;
      case StatusVariant.level:
        bg = AppColors.primary.withValues(alpha: 0.15);
        fg = AppColors.primary;
        break;
    }

    final isOutlined = variant == StatusVariant.joined;

    return Semantics(
      button: onTap != null,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 32),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: isOutlined
                ? Border.all(color: AppColors.border, width: 1)
                : null,
          ),
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// filter chip

class FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: '$label filter${isSelected ? ", active" : ""}',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          constraints: const BoxConstraints(minHeight: AppSpacing.minTouchTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isSelected ? Colors.black : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
