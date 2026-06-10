class Event {
  final int id;
  final String title;
  final String category;
  final String location;
  final int capacity;
  int attendees;

  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.capacity,
    required this.attendees,
  });

  bool get isFull => attendees >= capacity;
}

// ---------------- MOCK STATE ----------------

List<Event> events = [
  Event(
    id: 1,
    title: "ALU Leadership Summit",
    category: "Leadership",
    location: "Kigali Campus",
    capacity: 100,
    attendees: 84,
  ),
  Event(
    id: 2,
    title: "Startup Pitch Night",
    category: "Entrepreneurship",
    location: "Innovation Hub",
    capacity: 60,
    attendees: 60,
  ),
  Event(
    id: 3,
    title: "Flutter Hackathon",
    category: "Hackathon",
    location: "ALU Labs",
    capacity: 150,
    attendees: 96,
  ),
];

Set<int> joinedEvents = {};
Set<int> waitlistedEvents = {};
Set<int> attendedEvents = {};

int participationPoints = 0;

// ---------------- ACTIONS ----------------

void rsvp(Event event) {
  if (event.isFull) {
    waitlistedEvents.add(event.id);
  } else {
    joinedEvents.add(event.id);
    event.attendees++;
  }
}

void cancelRSVP(Event event) {
  joinedEvents.remove(event.id);
  waitlistedEvents.remove(event.id);
  if (event.attendees > 0) event.attendees--;
}

void checkIn(Event event) {
  if (!attendedEvents.contains(event.id)) {
    attendedEvents.add(event.id);
    participationPoints += 50;
  }
}