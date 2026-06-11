import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  static const Map<String, Color> _categoryColors = {
    'Careers': Color(0xFFFFB800),
    'Social': Color(0xFFFF4444),
    'Sports': Color(0xFF44DD88),
    'Tech': Color(0xFF4499FF),
    'Entrepreneurship': Color(0xFF9B59B6),
  };

  static const List<String> _months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
  ];

  @override
  Widget build(BuildContext context) {
    final dotColor =
        _categoryColors[post.category] ?? const Color(0xFFFFB800);
    final hasImage = post.imageBytes != null;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2D3F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Image / banner area 
          Expanded(
            flex: 4,
            child: SizedBox.expand(
              child: Stack(
                children: [
                  // Background: photo or gradient
                  Positioned.fill(
                    child: hasImage
                        ? Image.memory(
                            post.imageBytes!,
                            fit: BoxFit.cover,
                            gaplessPlayback: true,
                          )
                        : Container(
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
                  ),

                  // Dark overlay on photo
                  if (hasImage)
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black26, Colors.black54],
                          ),
                        ),
                      ),
                    ),

                // ✦ For you badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB800),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star,
                            color: Colors.black, size: 10),
                        SizedBox(width: 4),
                        Text(
                          'For you',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // CATEGORY · PHOTO label at bottom of image area
                Positioned(
                  bottom: 8,
                  left: 12,
                  child: Text(
                    post.category.isNotEmpty
                        ? '${post.category.toUpperCase()}  ·  ${hasImage ? "PHOTO" : ""}'
                        : hasImage
                            ? 'PHOTO'
                            : '',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),

          //  Content area 
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category pill
                  if (post.category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: dotColor.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: dotColor.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                color: dotColor,
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            post.category,
                            style: TextStyle(
                                color: dotColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
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

                  const SizedBox(height: 4),

                  // Description in golden
                  if (post.description.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.star,
                            color: Color(0xFFFFB800), size: 11),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            post.description,
                            style: const TextStyle(
                              color: Color(0xFFFFB800),
                              fontSize: 11,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                  const Spacer(),

                  // Date + action button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              color: Colors.white54, size: 11),
                          const SizedBox(width: 4),
                          Text(
                            post.date == null
                                ? (post.type == 'Opportunity'
                                    ? 'Open'
                                    : 'TBD')
                                : '${_months[post.date!.month - 1]} ${post.date!.day}',
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 11),
                          ),
                        ],
                      ),
                      _StatusButton(post: post),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  Status / action button 

class _StatusButton extends StatelessWidget {
  final Post post;
  const _StatusButton({required this.post});

  Future<void> _openLink(BuildContext context) async {
    var raw = post.applyLink.trim();
    if (raw.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No apply link provided for this opportunity')),
        );
      }
      return;
    }
    if (!raw.startsWith('http://') && !raw.startsWith('https://')) {
      raw = 'https://$raw';
    }
    final uri = Uri.parse(raw);
    try {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open: $raw')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (post.type == 'Opportunity') {
      return GestureDetector(
        onTap: () => _openLink(context),
        child: _chip('Apply', const Color(0xFFFFB800), Colors.black),
      );
    }
    if (post.isFinished) {
      return _chip('Finished', Colors.white24, Colors.white54);
    }
    return _chip('✓  Going', const Color(0xFF44DD88), Colors.black);
  }

  Widget _chip(String label, Color bg, Color fg) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: fg,
            fontSize: 11,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
