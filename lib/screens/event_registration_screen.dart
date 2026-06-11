import 'package:flutter/material.dart';
import '../store/event_store.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/diagonal_banner.dart';
import '../widgets/capacity_bar.dart';
import '../widgets/rsvp_button.dart';
import '../widgets/status_chip.dart';

class EventRegistrationScreen extends StatelessWidget {
  const EventRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: EventStore.instance,
      builder: (context, _) {
        final store = EventStore.instance;

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
        Text(
          "Events",
          style: AppTypography.headlineLarge.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final event in store.events)
          Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DiagonalBanner(
                  color: _categoryColor(event.category),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: AppTypography.headlineMedium.copyWith(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        event.location,
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      CapacityBar(
                        current: event.attendees,
                        max: event.capacity,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      if (store.waitlistedEvents.contains(event.id))
                        const StatusChip(
                          label: "WAITLISTED",
                          color: AppColors.accent,
                        ),
                      if (store.joinedEvents.contains(event.id))
                        const StatusChip(
                          label: "GOING",
                          color: AppColors.success,
                        ),
                      const SizedBox(height: 12),
                      RSVPButton(
                        label: store.joinedEvents.contains(event.id)
                            ? "Cancel RSVP"
                            : event.isFull
                                ? "Join Waitlist"
                                : "RSVP",
                        isPrimary: !store.joinedEvents.contains(event.id),
                        onTap: () {
                          if (store.joinedEvents.contains(event.id)) {
                            store.cancelRSVP(event);
                          } else {
                            store.rsvp(event);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
        );
      },
    );
  }

  Color _categoryColor(String category) {
    switch (category) {
      case "Leadership":
        return AppColors.primary;
      case "Entrepreneurship":
        return AppColors.success;
      case "Hackathon":
        return AppColors.accent;
      default:
        return AppColors.surfaceElevated;
    }
  }
}