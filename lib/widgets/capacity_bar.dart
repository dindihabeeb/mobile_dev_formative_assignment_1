import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CapacityBar extends StatelessWidget {
  final int current;
  final int max;

  const CapacityBar({
    super.key,
    required this.current,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    // Guard against divide-by-zero
    final double ratio = max == 0 ? 0.0 : (current / max).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio,
            backgroundColor: AppColors.surfaceAlt,
            color: ratio >= 1.0 ? Colors.redAccent : AppColors.orange,
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          max == 0 ? "Capacity unknown" : "$current / $max spots",
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}