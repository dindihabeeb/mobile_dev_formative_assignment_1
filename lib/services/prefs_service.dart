import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _keyOnboardingDone = 'onboarding_done';
  static const _keyRole = 'role';
  static const _keyName = 'name';
  static const _keyEmail = 'email';
  static const _keyCohort = 'cohort';
  static const _keyMission = 'mission';
  static const _keyInterests = 'interests';

  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  static Future<void> setOnboardingDone() async {
    final p = await _prefs;
    await p.setBool(_keyOnboardingDone, true);
  }

  static Future<bool> isOnboardingDone() async {
    final p = await _prefs;
    return p.getBool(_keyOnboardingDone) ?? false;
  }

  static Future<void> saveRole(String role) async {
    final p = await _prefs;
    await p.setString(_keyRole, role);
  }

  static Future<String?> getRole() async {
    final p = await _prefs;
    return p.getString(_keyRole);
  }

  static Future<void> saveProfile({
    required String name,
    required String email,
    required String cohort,
    required String mission,
    required List<String> interests,
  }) async {
    final p = await _prefs;
    await p.setString(_keyName, name);
    await p.setString(_keyEmail, email);
    await p.setString(_keyCohort, cohort);
    await p.setString(_keyMission, mission);
    await p.setStringList(_keyInterests, interests);
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final p = await _prefs;
    return {
      'name': p.getString(_keyName) ?? '',
      'email': p.getString(_keyEmail) ?? '',
      'cohort': p.getString(_keyCohort) ?? '',
      'mission': p.getString(_keyMission) ?? '',
      'interests': p.getStringList(_keyInterests) ?? [],
    };
  }

  static Future<bool> isLoggedIn() async {
    final p = await _prefs;
    final name = p.getString(_keyName) ?? '';
    return name.isNotEmpty;
  }

  static Future<void> clearAll() async {
    final p = await _prefs;
    await p.clear();
  }
}