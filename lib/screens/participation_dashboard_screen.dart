import 'package:flutter/material.dart';
import '../store/event_store.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class ParticipationDashboardScreen extends StatelessWidget {
  const ParticipationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: EventStore.instance,
      builder: (context, _) {
        final store = EventStore.instance;
        final attended = store.attendedEvents.length;
        final joined = store.joinedEvents.length;
        final double rate = joined == 0 ? 0.0 : (attended / joined * 100);

        return Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(
            "Your Impact",
            style: AppTypography.headlineLarge.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 20),
          _StatCard(
            title: "Events Joined",
            value: joined.toString(),
            color: AppColors.primary,
          ),
          _StatCard(
            title: "Events Attended",
            value: attended.toString(),
            color: AppColors.success,
          ),
          _StatCard(
            title: "Points",
            value: store.participationPoints.toString(),
            color: AppColors.accent,
          ),
          const SizedBox(height: 20),
          Text(
            "Attendance Rate: ${rate.toStringAsFixed(1)}%",
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ));
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.radiusMd),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary)),
          Text(
            value,
            style: AppTypography.headlineMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
