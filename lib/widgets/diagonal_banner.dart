import 'package:flutter/material.dart';

class DiagonalBanner extends StatelessWidget {
  final Color color;

  const DiagonalBanner({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      child: CustomPaint(
        painter: _DiagonalPainter(color),
        child: const SizedBox(height: 90, width: double.infinity),
      ),
    );
  }
}

class _DiagonalPainter extends CustomPainter {
  final Color color;

  _DiagonalPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = color,
    );
    final linePaint = Paint()
      // ignore: deprecated_member_use
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 2;
    for (double i = -size.height; i < size.width; i += 14) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DiagonalPainter old) => old.color != color;
}