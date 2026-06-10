import 'package:flutter/material.dart';
import '../mock_data/mock_data.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myEvents = events
        .where((e) => joinedEvents.contains(e.id))
        .toList();

    final waitlisted = events
        .where((e) => waitlistedEvents.contains(e.id))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "My Events",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 16),

        const Text("Going", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),

        for (final e in myEvents)
          _tile(e.title, "GOING", const Color(0xFF22C55E)),

        const SizedBox(height: 20),

        const Text("Waitlisted", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),

        for (final e in waitlisted)
          _tile(e.title, "WAITLISTED", const Color(0xFF8B5CF6)),
      ],
    );
  }

  Widget _tile(String title, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          Text(status, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}