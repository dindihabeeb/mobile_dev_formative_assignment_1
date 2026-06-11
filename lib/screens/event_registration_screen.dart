import 'package:flutter/material.dart';
import '../store/event_store.dart';
import '../theme/app_colors.dart';
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
          padding: const EdgeInsets.all(16),
          children: [
        const Text(
          "Events",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        for (final event in store.events)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DiagonalBanner(
                  color: _categoryColor(event.category),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        event.location,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 10),
                      CapacityBar(
                        current: event.attendees,
                        max: event.capacity,
                      ),
                      const SizedBox(height: 10),
                      if (store.waitlistedEvents.contains(event.id))
                        const StatusChip(
                          label: "WAITLISTED",
                          color: AppColors.purple,
                        ),
                      if (store.joinedEvents.contains(event.id))
                        const StatusChip(
                          label: "GOING",
                          color: AppColors.green,
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
        return AppColors.orange;
      case "Entrepreneurship":
        return AppColors.green;
      case "Hackathon":
        return AppColors.purple;
      default:
        return AppColors.surfaceAlt;
    }
  }
}