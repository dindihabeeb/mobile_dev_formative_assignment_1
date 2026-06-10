import 'package:flutter/material.dart';
import 'screens/event_registration_screen.dart';
import 'screens/my_events_screen.dart';
import 'screens/attendance_checkin_screen.dart';
import 'screens/participation_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int currentIndex = 0;

  final pages = const [
    EventRegistrationScreen(),
    MyEventsScreen(),
    AttendanceCheckInScreen(),
    ParticipationDashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Imbuga",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0D0F1A),
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF5A623),
          secondary: Color(0xFF8B5CF6),
          surface: Color(0xFF1A1D2E),
        ),
      ),
      home: Scaffold(
        body: pages[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFF5A623),
          child: const Icon(Icons.add, color: Colors.black),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          backgroundColor: const Color(0xFF1A1D2E),
          selectedItemColor: const Color(0xFFF5A623),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: "Events",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "My Events",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: "Check-in",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Points",
            ),
          ],
        ),
      ),
    );
  }
}