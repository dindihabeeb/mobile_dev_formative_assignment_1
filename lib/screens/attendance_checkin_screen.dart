import 'package:flutter/material.dart';
import '../store/event_store.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

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
    final result = EventStore.instance.checkIn(_codeController.text);

    setState(() {
      switch (result) {
        case CheckInResult.success:
          _messageState = const _MessageState(
            text: "+50 Points Earned 🎉",
            color: AppColors.success,
          );
        case CheckInResult.alreadyCheckedIn:
          _messageState = const _MessageState(
            text: "Already checked in to this event.",
            color: AppColors.primary,
          );
        case CheckInResult.invalid:
          _messageState = const _MessageState(
            text: "Invalid code — please try again.",
            color: AppColors.error,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Check-in",
            style: AppTypography.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            "Enter the event code provided at the door.",
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _codeController,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textPrimary,
            ),
            onChanged: (_) {
              // Reset message when user starts typing a new code
              if (_messageState.text.isNotEmpty) {
                setState(() => _messageState = const _MessageState.empty());
              }
            },
            decoration: InputDecoration(
              hintText: "Event code",
              hintStyle: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
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
                backgroundColor: AppColors.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
              onPressed: _handleCheckIn,
              child: const Text(
                "Check In",
                style: AppTypography.labelLarge,
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_messageState.text.isNotEmpty)
            Text(
              _messageState.text,
              style: AppTypography.titleLarge.copyWith(
                color: _messageState.color,
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
