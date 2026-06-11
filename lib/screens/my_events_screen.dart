import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/event_store.dart';
import '../theme/app_colors.dart';
import '../models/event.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch ensures this screen rebuilds when store changes
    final store = context.watch<EventStore>();
    final myEvents = store.myEvents;
    final waitlisted = store.waitlisted;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "My Events",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        const Text("Going", style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        if (myEvents.isEmpty)
          const _EmptyState(message: "No events yet — go RSVP to something!")
        else
          for (final e in myEvents)
            _EventTile(event: e, status: "GOING", statusColor: AppColors.green),
        const SizedBox(height: 20),
        const Text(
          "Waitlisted",
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        if (waitlisted.isEmpty)
          const _EmptyState(message: "You're not on any waitlists.")
        else
          for (final e in waitlisted)
            _EventTile(
              event: e,
              status: "WAITLISTED",
              statusColor: AppColors.purple,
            ),
      ],
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
              style: const TextStyle(color: AppColors.textPrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(status, style: TextStyle(color: statusColor)),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        message,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
    );
  }
}