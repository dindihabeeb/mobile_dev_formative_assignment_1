import 'package:flutter/material.dart';
import '../services/prefs_service.dart';
import 'login_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  void _onContinue() async {
    if (_selectedRole == null) return;
    await PrefsService.saveRole(_selectedRole!);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const Text(
                'Who are you?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This helps us personalise your experience.',
                style: TextStyle(color: Color(0xFF9090A0), fontSize: 14),
              ),
              const SizedBox(height: 40),
              _RoleCard(
                title: 'Student',
                subtitle: 'Discover events, join clubs, and engage with the ALU community.',
                icon: Icons.school_rounded,
                selected: _selectedRole == 'Student',
                onTap: () => setState(() => _selectedRole = 'Student'),
              ),
              const SizedBox(height: 16),
              _RoleCard(
                title: 'Authorized Poster',
                subtitle: 'Post events, hackathons, opportunities and announcements.',
                icon: Icons.campaign_rounded,
                selected: _selectedRole == 'Authorized Poster',
                onTap: () => setState(() => _selectedRole = 'Authorized Poster'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _selectedRole != null ? _onContinue : null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: const Color(0xFF1A1A2E),
                  disabledForegroundColor: const Color(0xFF9090A0),
                ),
                child: const Text('Continue'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF6C63FF) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF6C63FF).withOpacity(0.15)
                    : const Color(0xFF0D0D1A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: selected ? const Color(0xFF6C63FF) : const Color(0xFF9090A0),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: selected ? const Color(0xFF6C63FF) : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9090A0),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded, color: Color(0xFF6C63FF), size: 22),
          ],
        ),
      ),
    );
  }
}