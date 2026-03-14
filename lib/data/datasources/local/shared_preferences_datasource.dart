import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/errors/failures.dart';

/// Wraps [SharedPreferences] to persist the three user preferences:
/// theme mode, default district filter, and notifications toggle.
class SharedPreferencesDataSource {
  SharedPreferencesDataSource(this._prefs);

  final SharedPreferences _prefs;

  // ── Theme ─────────────────────────────────────────────────────────────────

  /// Returns 'light' or 'dark'. Defaults to 'light'.
  String getThemeMode() =>
      _prefs.getString(AppConstants.prefThemeMode) ?? 'light';

  Future<void> setThemeMode(String mode) async {
    try {
      await _prefs.setString(AppConstants.prefThemeMode, mode);
    } catch (e) {
      throw const CacheFailure('Failed to save theme preference.');
    }
  }

  // ── Default District ──────────────────────────────────────────────────────

  /// Returns the saved district, or null if none has been chosen.
  String? getDefaultDistrict() =>
      _prefs.getString(AppConstants.prefDefaultDistrict);

  Future<void> setDefaultDistrict(String? district) async {
    try {
      if (district == null || district.isEmpty) {
        await _prefs.remove(AppConstants.prefDefaultDistrict);
      } else {
        await _prefs.setString(AppConstants.prefDefaultDistrict, district);
      }
    } catch (e) {
      throw const CacheFailure('Failed to save district preference.');
    }
  }

  // ── Notifications ─────────────────────────────────────────────────────────

  bool getNotificationsEnabled() =>
      _prefs.getBool(AppConstants.prefNotifications) ?? true;

  Future<void> setNotificationsEnabled(bool enabled) async {
    try {
      await _prefs.setBool(AppConstants.prefNotifications, enabled);
    } catch (e) {
      throw const CacheFailure('Failed to save notification preference.');
    }
  }
}
