import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ThemeCubit extends Cubit<bool> {
  final SharedPreferences _prefs;
  static const _themeKey = 'isDarkMode';

  ThemeCubit(this._prefs) : super(_prefs.getBool(_themeKey) ?? false);

  void toggleTheme() {
    final isDarkMode = !state;
    _prefs.setBool(_themeKey, isDarkMode);
    emit(isDarkMode);
  }
}
