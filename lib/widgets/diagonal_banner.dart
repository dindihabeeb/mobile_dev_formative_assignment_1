import 'package:flutter/material.dart';

class DiagonalBanner extends StatelessWidget {
  final Color color;

  const DiagonalBanner({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DiagonalPainter(color),
      child: const SizedBox(height: 90, width: double.infinity),
    );
  }
}

class _DiagonalPainter extends CustomPainter {
  final Color color;

  _DiagonalPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = color;
    canvas.drawRect(Offset.zero & size, bg);

    final pattern = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    for (double i = -size.height; i < size.width; i += 14) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        pattern,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}