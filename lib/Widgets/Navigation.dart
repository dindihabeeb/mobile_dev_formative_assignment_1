import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF1A2D3F),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            index: 0,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
            label: 'Explore',
            index: 1,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          const SizedBox(width: 48), // gap for the FAB in the middle
          _NavItem(
            icon: Icons.groups_outlined,
            activeIcon: Icons.groups,
            label: 'Clubs',
            index: 2,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            index: 3,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? const Color(0xFFFFB800) : Colors.white54,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFFFFB800) : Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
