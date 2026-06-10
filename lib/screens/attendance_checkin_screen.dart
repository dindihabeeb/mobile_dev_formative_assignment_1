import 'package:flutter/material.dart';
import '../mock_data/mock_data.dart';

class AttendanceCheckInScreen extends StatefulWidget {
  const AttendanceCheckInScreen({super.key});

  @override
  State<AttendanceCheckInScreen> createState() =>
      _AttendanceCheckInScreenState();
}

class _AttendanceCheckInScreenState
    extends State<AttendanceCheckInScreen> {

  final codeController = TextEditingController();
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Check-in",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: codeController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter event code",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF1A1D2E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22C55E),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              setState(() {
                final event = events.firstWhere(
                  (e) => e.id.toString() == codeController.text.trim(),
                  orElse: () => Event(
                    id: -1,
                    title: "",
                    category: "",
                    location: "",
                    capacity: 0,
                    attendees: 0,
                  ),
                );

                if (event.id != -1) {
                  checkIn(event);
                  message = "+50 Points Earned 🎉";
                } else {
                  message = "Invalid Code";
                }
              });
            },
            child: const Text("Check In"),
          ),

          const SizedBox(height: 20),

          Text(
            message,
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}