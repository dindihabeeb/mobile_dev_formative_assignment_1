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
  bool _loading = true;

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
      _loading = false;
    });
  }

  void _onEdit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditProfileScreen(profile: _profile)),
    );
    _loadProfile();
  }

  void _onLogout() async {
    await PrefsService.clearAll();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFF6C63FF))),
      );
    }

    final interests = (_profile['interests'] as List<dynamic>).cast<String>();
    final name = _profile['name'] as String;
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e[0]).take(2).join().toUpperCase()
        : '?';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: _onLogout,
                    icon: const Icon(Icons.logout_rounded, color: Color(0xFF9090A0)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF6C63FF), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          initials,
                          style: const TextStyle(
                            color: Color(0xFF6C63FF),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _profile['email'] as String,
                      style: const TextStyle(color: Color(0xFF9090A0), fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.4)),
                      ),
                      child: Text(
                        _role,
                        style: const TextStyle(color: Color(0xFF6C63FF), fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _SectionCard(
                children: [
                  _InfoRow(icon: Icons.school_rounded, label: 'Cohort', value: _profile['cohort'] as String),
                  const Divider(color: Color(0xFF0D0D1A), height: 1),
                  _InfoRow(icon: Icons.flag_rounded, label: 'Mission', value: _profile['mission'] as String),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Interests',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              interests.isEmpty
                  ? const Text(
                      'No interests added yet.',
                      style: TextStyle(color: Color(0xFF9090A0), fontSize: 14),
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: interests.map((interest) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A2E),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.4)),
                          ),
                          child: Text(
                            interest,
                            style: const TextStyle(color: Color(0xFF6C63FF), fontSize: 13),
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 16),
              const Text(
                'Badges',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _SectionCard(
                children: [
                  _BadgeRow(icon: Icons.verified_rounded, label: 'Early Adopter', subtitle: 'Joined during launch'),
                  const Divider(color: Color(0xFF0D0D1A), height: 1),
                  _BadgeRow(icon: Icons.explore_rounded, label: 'Explorer', subtitle: 'Completed onboarding'),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onEdit,
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6C63FF), size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Color(0xFF9090A0), fontSize: 14)),
          const Spacer(),
          Text(
            value.isEmpty ? 'Not set' : value,
            style: TextStyle(
              color: value.isEmpty ? const Color(0xFF9090A0) : Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  const _BadgeRow({required this.icon, required this.label, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6C63FF), size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
              Text(subtitle, style: const TextStyle(color: Color(0xFF9090A0), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}