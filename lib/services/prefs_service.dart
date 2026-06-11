import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static Future<SharedPreferences> get _p async => SharedPreferences.getInstance();

  static Future<void> setOnboardingDone() async => (await _p).setBool('onboarding_done', true);
  static Future<bool> isOnboardingDone() async => (await _p).getBool('onboarding_done') ?? false;

  static Future<void> saveRole(String role) async => (await _p).setString('role', role);
  static Future<String?> getRole() async => (await _p).getString('role');

  static Future<void> saveProfile({
    required String name,
    required String email,
    required String cohort,
    required String mission,
    required List<String> interests,
  }) async {
    final p = await _p;
    p.setString('name', name);
    p.setString('email', email);
    p.setString('cohort', cohort);
    p.setString('mission', mission);
    p.setStringList('interests', interests);
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final p = await _p;
    return {
      'name': p.getString('name') ?? '',
      'email': p.getString('email') ?? '',
      'cohort': p.getString('cohort') ?? '',
      'mission': p.getString('mission') ?? '',
      'interests': p.getStringList('interests') ?? [],
    };
  }

  static Future<bool> isLoggedIn() async => ((await _p).getString('name') ?? '').isNotEmpty;
  static Future<void> clearAll() async => (await _p).clear();
}