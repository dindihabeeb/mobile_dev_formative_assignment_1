import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'edit_profile_screen.dart';
import 'splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email
    });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> _profile = {};
  final String _role = '';

  @override
  void initState() {
    super.initState();
    _profile = {
      'name': widget.name,
      'email': widget.email,
      'cohort': '',
      'mission': '',
      'interests': <String>[],
    };
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
        backgroundColor: AppColors.background,
        title: Text('My Profile', style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textPrimary),
            onPressed: () {
              if (!mounted) return;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SplashScreen()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: AppColors.accent,
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: AppTypography.displayLarge.copyWith(color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(name, style: AppTypography.headlineMedium.copyWith(color: AppColors.textPrimary)),
                  Text(email, style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted)),
                  if (_role.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.radiusMd, vertical: AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                      ),
                      child: Text(_role, style: AppTypography.bodyMedium.copyWith(color: AppColors.accent)),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Cohort', style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: AppSpacing.xs),
            Text(cohort.isEmpty ? 'Not set' : cohort, style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.md),
            Text('Mission', style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: AppSpacing.xs),
            Text(mission.isEmpty ? 'Not set' : mission, style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.md),
            Text('Interests', style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: AppSpacing.sm),
            interests.isEmpty
                ? Text('No interests added', style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary))
                : Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: interests.map((i) => Chip(
                      label: Text(i.toString(), style: AppTypography.bodyMedium.copyWith(color: AppColors.accent)),
                      backgroundColor: AppColors.surface,
                      side: const BorderSide(color: AppColors.accent),
                    )).toList(),
                  ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: () async {
                final updated = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(builder: (_) => EditProfileScreen(profile: _profile)),
                );
                if (updated != null) setState(() => _profile = updated);
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
