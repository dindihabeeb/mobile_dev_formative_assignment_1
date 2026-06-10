import 'package:flutter/material.dart';
import '../Widgets/Navigation.dart';
import '../Screens/explore.dart';
import '../Screens/post.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 1; // start on Explore

  final List<Widget> _screens = const [
    _PlaceholderScreen(label: 'Home'),
    ExploreScreen(),
    _PlaceholderScreen(label: 'Clubs'),
    _PlaceholderScreen(label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      // IndexedStack keeps each screen alive when you switch tabs
      // so scroll positions and state are preserved
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFB800),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String label;
  const _PlaceholderScreen({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 20),
        ),
      ),
    );
  }
}
