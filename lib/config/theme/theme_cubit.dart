import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;
  static const _themeKey = 'theme_mode';

  ThemeCubit(this._prefs) : super(_getInitialTheme(_prefs));

  static ThemeMode _getInitialTheme(SharedPreferences prefs) {
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      return ThemeMode.values.firstWhere(
        (mode) => mode.name == savedTheme,
        orElse: () => ThemeMode.system,
      );
    }
    return ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _prefs.setString(_themeKey, mode.name);
    emit(mode);
  }

  bool isDarkMode(BuildContext context) {
    switch (state) {
      case ThemeMode.system:
        return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
    }
  }
}
