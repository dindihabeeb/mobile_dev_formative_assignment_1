import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/event_store.dart';
import '../theme/app_colors.dart';

class ParticipationDashboardScreen extends StatelessWidget {
  const ParticipationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<EventStore>();
    final attended = store.attendedEvents.length;
    final joined = store.joinedEvents.length;
    // Explicit double division — avoids integer truncation
    final double rate = joined == 0 ? 0.0 : (attended / joined * 100);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Impact",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          _StatCard(
            title: "Events Joined",
            value: joined.toString(),
            color: AppColors.orange,
          ),
          _StatCard(
            title: "Events Attended",
            value: attended.toString(),
            color: AppColors.green,
          ),
          _StatCard(
            title: "Points",
            value: store.participationPoints.toString(),
            color: AppColors.purple,
          ),
          const SizedBox(height: 20),
          Text(
            "Attendance Rate: ${rate.toStringAsFixed(1)}%",
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textPrimary)),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}