import 'dart:typed_data';

class Post {
  final String id;
  final String type;
  final String title;
  final String description;
  final DateTime? date;
  final String location;
  final String applyLink;
  final String category;
  final String imagePath;
  final Uint8List? imageBytes;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.date,
    this.location = '',
    this.applyLink = '',
    this.category = '',
    this.imagePath = '',
    this.imageBytes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isFinished =>
      type == 'Event' && date != null && date!.isBefore(DateTime.now());
}
