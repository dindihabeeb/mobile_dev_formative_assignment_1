import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'store/event_store.dart';
import 'theme/app_colors.dart';
import 'screens/event_registration_screen.dart';
import 'screens/my_events_screen.dart';
import 'screens/attendance_checkin_screen.dart';
import 'screens/participation_dashboard_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EventStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Imbuga",
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.dark(
          primary: AppColors.orange,
          secondary: AppColors.purple,
          surface: AppColors.surface,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const _pages = [
    EventRegistrationScreen(),
    MyEventsScreen(),
    AttendanceCheckInScreen(),
    ParticipationDashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "My Events"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Check-in"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Points"),
        ],
      ),
    );
  }
}