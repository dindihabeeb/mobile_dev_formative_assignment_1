import 'package:flutter/material.dart';
import '../store/event_store.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../models/event.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: EventStore.instance,
      builder: (context, _) {
        final store = EventStore.instance;
        final myEvents = store.myEvents;
        final waitlisted = store.waitlisted;

        return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          "My Events",
          style: AppTypography.headlineLarge.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.md),
        Text("Going", style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.sm),
        if (myEvents.isEmpty)
          const _EmptyState(message: "No events yet — go RSVP to something!")
        else
          for (final e in myEvents)
            _EventTile(event: e, status: "GOING", statusColor: AppColors.success),
        const SizedBox(height: 20),
        Text(
          "Waitlisted",
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (waitlisted.isEmpty)
          const _EmptyState(message: "You're not on any waitlists.")
        else
          for (final e in waitlisted)
            _EventTile(
              event: e,
              status: "WAITLISTED",
              statusColor: AppColors.accent,
            ),
      ],
        );
      },
    );
  }
}

class _EventTile extends StatelessWidget {
  final Event event;
  final String status;
  final Color statusColor;

  const _EventTile({
    required this.event,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              event.title,
              style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(status, style: AppTypography.labelLarge.copyWith(color: statusColor)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Text(
        message,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
