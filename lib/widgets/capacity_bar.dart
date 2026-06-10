import 'package:flutter/material.dart';

class CapacityBar extends StatelessWidget {
  final int current;
  final int max;

  const CapacityBar({
    super.key,
    required this.current,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = current / max;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: ratio,
          backgroundColor: const Color(0xFF2A2E45),
          color: const Color(0xFFF5A623),
          minHeight: 8,
        ),
        const SizedBox(height: 6),
        Text(
          "$current / $max spots",
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}