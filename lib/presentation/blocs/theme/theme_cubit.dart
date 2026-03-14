import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/local/shared_preferences_datasource.dart';

/// Persists and exposes the current [ThemeMode].
/// Reads the stored value from [SharedPreferencesDataSource] on construction.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._prefs) : super(_initialTheme(_prefs));

  final SharedPreferencesDataSource _prefs;

  /// Reads the persisted theme mode (defaults to [ThemeMode.light]).
  static ThemeMode _initialTheme(SharedPreferencesDataSource prefs) {
    return prefs.getThemeMode() == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDark => state == ThemeMode.dark;

  /// Toggles between light and dark and persists the choice.
  Future<void> toggleTheme() async {
    final next = isDark ? ThemeMode.light : ThemeMode.dark;
    await _prefs.setThemeMode(next == ThemeMode.dark ? 'dark' : 'light');
    emit(next);
  }

  /// Explicitly sets the [ThemeMode] and persists it.
  Future<void> setTheme(ThemeMode mode) async {
    await _prefs.setThemeMode(mode == ThemeMode.dark ? 'dark' : 'light');
    emit(mode);
  }
}
