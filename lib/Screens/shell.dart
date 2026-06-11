import 'package:flutter/material.dart';
import '../widgets/Navigation.dart';
import '../screens/feed.dart';
import '../screens/explore.dart';
import '../screens/communityPage.dart';
import '../screens/profile_screen.dart';
import '../screens/post.dart';

class AppShell extends StatefulWidget {
  final String name;
  final String email;

  const AppShell({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const FeedScreen(),
      const ExploreScreen(),
      const Communitypage(),
      ProfileScreen(name: widget.name, email: widget.email),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
