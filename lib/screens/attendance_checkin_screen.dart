import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/event_store.dart';
import '../theme/app_colors.dart';

class AttendanceCheckInScreen extends StatefulWidget {
  const AttendanceCheckInScreen({super.key});

  @override
  State<AttendanceCheckInScreen> createState() =>
      _AttendanceCheckInScreenState();
}

class _AttendanceCheckInScreenState extends State<AttendanceCheckInScreen> {
  final _codeController = TextEditingController();
  _MessageState _messageState = const _MessageState.empty();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _handleCheckIn() {
    final store = context.read<EventStore>();
    final result = store.checkIn(_codeController.text);

    setState(() {
      switch (result) {
        case CheckInResult.success:
          _messageState = const _MessageState(
            text: "+50 Points Earned 🎉",
            color: AppColors.green,
          );
        case CheckInResult.alreadyCheckedIn:
          _messageState = const _MessageState(
            text: "Already checked in to this event.",
            color: AppColors.orange,
          );
        case CheckInResult.invalid:
          _messageState = const _MessageState(
            text: "Invalid code — please try again.",
            color: Colors.redAccent,
          );
      }
    });
  }

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
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Enter the event code provided at the door.",
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _codeController,
            style: const TextStyle(color: AppColors.textPrimary),
            onChanged: (_) {
              // Reset message when user starts typing a new code
              if (_messageState.text.isNotEmpty) {
                setState(() => _messageState = const _MessageState.empty());
              }
            },
            decoration: InputDecoration(
              hintText: "Event code",
              hintStyle: const TextStyle(color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _handleCheckIn,
              child: const Text(
                "Check In",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_messageState.text.isNotEmpty)
            Text(
              _messageState.text,
              style: TextStyle(
                color: _messageState.color,
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }
}

class _MessageState {
  final String text;
  final Color color;

  const _MessageState({required this.text, required this.color});
  const _MessageState.empty()
      : text = '',
        color = Colors.transparent;
}