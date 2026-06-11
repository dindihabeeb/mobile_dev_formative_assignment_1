import 'package:flutter/foundation.dart';
import '../models/event.dart';

class EventStore extends ChangeNotifier {
  EventStore._internal();
  static final EventStore instance = EventStore._internal();

  final List<Event> events = [
    const Event(
      id: 1,
      title: "ALU Leadership Summit",
      category: "Leadership",
      location: "Kigali Campus",
      capacity: 100,
      attendees: 84,
    ),
    const Event(
      id: 2,
      title: "Startup Pitch Night",
      category: "Entrepreneurship",
      location: "Innovation Hub",
      capacity: 60,
      attendees: 60,
    ),
    const Event(
      id: 3,
      title: "Flutter Hackathon",
      category: "Hackathon",
      location: "ALU Labs",
      capacity: 150,
      attendees: 96,
    ),
  ];

  final Set<int> joinedEvents = {};
  final Set<int> waitlistedEvents = {};
  final Set<int> attendedEvents = {};
  int participationPoints = 0;

  List<Event> get myEvents =>
      events.where((e) => joinedEvents.contains(e.id)).toList();

  List<Event> get waitlisted =>
      events.where((e) => waitlistedEvents.contains(e.id)).toList();

  void rsvp(Event event) {
    if (event.isFull) {
      waitlistedEvents.add(event.id);
    } else {
      joinedEvents.add(event.id);
      final index = events.indexWhere((e) => e.id == event.id);
      if (index != -1) {
        events[index] = event.copyWith(attendees: event.attendees + 1);
      }
    }
    notifyListeners();
  }

  void cancelRSVP(Event event) {
    joinedEvents.remove(event.id);
    waitlistedEvents.remove(event.id);
    final index = events.indexWhere((e) => e.id == event.id);
    if (index != -1 && event.attendees > 0) {
      events[index] = event.copyWith(attendees: event.attendees - 1);
    }
    notifyListeners();
  }

  /// Returns true if check-in succeeded, false if code is invalid,
  /// null if already checked in.
  CheckInResult checkIn(String code) {
    final index = events.indexWhere(
      (e) => e.id.toString() == code.trim(),
    );
    if (index == -1) return CheckInResult.invalid;
    final event = events[index];
    if (attendedEvents.contains(event.id)) return CheckInResult.alreadyCheckedIn;
    attendedEvents.add(event.id);
    participationPoints += 50;
    notifyListeners();
    return CheckInResult.success;
  }
}

enum CheckInResult { success, invalid, alreadyCheckedIn }