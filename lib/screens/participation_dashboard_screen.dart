import 'package:flutter/material.dart';
import '../mock_data/mock_data.dart';

class ParticipationDashboardScreen extends StatelessWidget {
  const ParticipationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attended = attendedEvents.length;
    final joined = joinedEvents.length;
    final rate = joined == 0 ? 0 : (attended / joined * 100);

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
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          _card("Events Joined", joined.toString(), const Color(0xFFF5A623)),
          _card("Events Attended", attended.toString(), const Color(0xFF22C55E)),
          _card("Points", participationPoints.toString(), const Color(0xFF8B5CF6)),

          const SizedBox(height: 20),

          Text(
            "Attendance Rate: ${rate.toStringAsFixed(1)}%",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _card(String title, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
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