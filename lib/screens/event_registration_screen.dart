import 'package:flutter/material.dart';
import '../mock_data/mock_data.dart';
import '../widgets/diagonal_banner.dart';
import '../widgets/capacity_bar.dart';
import '../widgets/rsvp_button.dart';
import '../widgets/status_chip.dart';

class EventRegistrationScreen extends StatefulWidget {
  const EventRegistrationScreen({super.key});

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState
    extends State<EventRegistrationScreen> {

  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Events",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),

        for (final event in events)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1D2E),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DiagonalBanner(color: Color(0xFF8B5CF6)),

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
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        event.location,
                        style: const TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 10),

                      CapacityBar(
                        current: event.attendees,
                        max: event.capacity,
                      ),

                      const SizedBox(height: 10),

                      if (waitlistedEvents.contains(event.id))
                        const StatusChip(
                          label: "WAITLISTED",
                          color: Color(0xFF8B5CF6),
                        ),

                      if (joinedEvents.contains(event.id))
                        const StatusChip(
                          label: "GOING",
                          color: Color(0xFF22C55E),
                        ),

                      const SizedBox(height: 12),

                      RSVPButton(
                        label: joinedEvents.contains(event.id)
                            ? "Cancel RSVP"
                            : event.isFull
                                ? "Join Waitlist"
                                : "RSVP",
                        onTap: () {
                          setState(() {
                            if (joinedEvents.contains(event.id)) {
                              cancelRSVP(event);
                            } else {
                              rsvp(event);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}