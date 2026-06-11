import 'package:flutter/material.dart';
import '../widgets/Navigation.dart';
import '../screens/home.dart';
import '../screens/explore.dart';
import '../screens/communityPage.dart';
import '../screens/profile_screen.dart';
import '../screens/post.dart';
import '../theme/app_colors.dart';

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
      HomeScreen(name: widget.name),
      ExploreScreen(),
      Communitypage(),
      ProfileScreen(name: widget.name, email: widget.email),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
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
