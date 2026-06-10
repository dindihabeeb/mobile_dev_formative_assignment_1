import 'dart:io';
import 'package:flutter/material.dart';
import 'post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  static const Map<String, Color> _categoryColors = {
    'Careers': Color(0xFFFFB800),
    'Social': Color(0xFFFF4444),
    'Sports': Color(0xFF44DD88),
    'Tech': Color(0xFF4499FF),
  };

  @override
  Widget build(BuildContext context) {
    final dotColor = _categoryColors[post.category] ?? const Color(0xFFFFB800);

    final hasImage = post.imagePath.isNotEmpty;

    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background: image or gradient
          if (hasImage)
            Image.file(File(post.imagePath), fit: BoxFit.cover)
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    dotColor.withValues(alpha: 0.25),
                    const Color(0xFF0D1B2A),
                  ],
                ),
              ),
            ),

          // Dark overlay so text is always readable over the image
          if (hasImage)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),

          // Content on top
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              post.type,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ),

          const Spacer(),

          // Category chip
          if (post.category.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: dotColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration:
                        BoxDecoration(color: dotColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    post.category,
                    style: TextStyle(color: dotColor, fontSize: 11),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 6),

          // Title
          Text(
            post.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 10),

          // Bottom row: date + status button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date or Apply link label
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      color: Colors.white54, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    post.type == 'Opportunity'
                        ? 'Apply'
                        : post.date == null
                            ? 'No date'
                            : 'MAY ${post.date!.day}',
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),

              // Status button
              _StatusButton(post: post),
            ],
          ),
              ],
            ),          // closes Column
          ),            // closes Padding
        ],              // closes Stack children
      ),                // closes Stack
    );                  // closes Container
  }
}

class _StatusButton extends StatelessWidget {
  final Post post;
  const _StatusButton({required this.post});

  @override
  Widget build(BuildContext context) {
    if (post.type == 'Opportunity') {
      return _chip('Apply', const Color(0xFFFFB800), Colors.black);
    }
    if (post.isFinished) {
      return _chip('Finished', Colors.white24, Colors.white54);
    }
    return _chip('Going', const Color(0xFF44DD88), Colors.black);
  }

  Widget _chip(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: textColor, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
