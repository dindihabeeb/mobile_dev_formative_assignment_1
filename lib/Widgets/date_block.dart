import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';

/// Calendar-style date block — large day number, month label below.
/// Seen in the event list view.
class DateBlock extends StatelessWidget {
  final int day;
  final String month;
  final Color? color;
  final double size;

  const DateBlock({
    super.key,
    required this.day,
    required this.month,
    this.color,
    this.size = 52,
  });

  factory DateBlock.fromDateTime(DateTime dt, {Color? color, double size = 52}) {
    const months = [
      'JAN','FEB','MAR','APR','MAY','JUN',
      'JUL','AUG','SEP','OCT','NOV','DEC',
    ];
    return DateBlock(
      day: dt.day,
      month: months[dt.month - 1],
      color: color,
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.accent;

    return Semantics(
      label: '$day $month',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: c.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: AppTypography.titleLarge.copyWith(
                color: c,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              month,
              style: AppTypography.labelSmall.copyWith(
                color: c,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
