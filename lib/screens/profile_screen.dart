import 'package:flutter/material.dart';
import '../services/prefs_service.dart';
import 'edit_profile_screen.dart';
import 'splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> _profile = {};
  String _role = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await PrefsService.getProfile();
    final role = await PrefsService.getRole();
    setState(() {
      _profile = profile;
      _role = role ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = _profile['name'] ?? '';
    final email = _profile['email'] ?? '';
    final cohort = _profile['cohort'] ?? '';
    final mission = _profile['mission'] ?? '';
    final interests = (_profile['interests'] ?? []) as List;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1A),
        title: const Text('My Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await PrefsService.clearAll();
              if (!mounted) return;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SplashScreen()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: const Color(0xFF6C63FF),
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(email, style: const TextStyle(color: Color(0xFF9090A0), fontSize: 13)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_role, style: const TextStyle(color: Color(0xFF6C63FF), fontSize: 13)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Cohort', style: TextStyle(color: Color(0xFF9090A0), fontSize: 13)),
            const SizedBox(height: 4),
            Text(cohort.isEmpty ? 'Not set' : cohort, style: const TextStyle(color: Colors.white, fontSize: 15)),
            const SizedBox(height: 16),
            const Text('Mission', style: TextStyle(color: Color(0xFF9090A0), fontSize: 13)),
            const SizedBox(height: 4),
            Text(mission.isEmpty ? 'Not set' : mission, style: const TextStyle(color: Colors.white, fontSize: 15)),
            const SizedBox(height: 16),
            const Text('Interests', style: TextStyle(color: Color(0xFF9090A0), fontSize: 13)),
            const SizedBox(height: 8),
            interests.isEmpty
                ? const Text('No interests added', style: TextStyle(color: Colors.white))
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: interests.map((i) => Chip(
                      label: Text(i.toString(), style: const TextStyle(color: Color(0xFF6C63FF))),
                      backgroundColor: const Color(0xFF1A1A2E),
                      side: const BorderSide(color: Color(0xFF6C63FF)),
                    )).toList(),
                  ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen(profile: _profile)));
                _loadProfile();
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}