import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Circular avatar that shows initials when no image is provided.
class AppAvatar extends StatelessWidget {
  final String initials;
  final Color? color;
  final double size;
  final Uint8List? imageBytes;
  final String? semanticLabel;

  const AppAvatar({
    super.key,
    required this.initials,
    this.color,
    this.size = 40,
    this.imageBytes,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color ?? AppColors.accent;
    final fontSize = size * 0.36;

    return Semantics(
      label: semanticLabel ?? '$initials avatar',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: imageBytes != null ? Colors.transparent : bg.withValues(alpha: 0.25),
          shape: BoxShape.circle,
          border: Border.all(color: bg.withValues(alpha: 0.5), width: 1.5),
          image: imageBytes != null
              ? DecorationImage(
                  image: MemoryImage(imageBytes!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imageBytes == null
            ? Center(
                child: Text(
                  initials.toUpperCase(),
                  style: AppTypography.labelLarge.copyWith(
                    color: bg,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
