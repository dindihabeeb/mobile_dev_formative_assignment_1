class Event {
  final int id;
  final String title;
  final String category;
  final String location;
  final int capacity;
  final int attendees;

  const Event({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.capacity,
    required this.attendees,
  });

  bool get isFull => attendees >= capacity;

  Event copyWith({int? attendees}) {
    return Event(
      id: id,
      title: title,
      category: category,
      location: location,
      capacity: capacity,
      attendees: attendees ?? this.attendees,
    );
  }
}