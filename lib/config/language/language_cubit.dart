import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dream/i18n/strings.g.dart';

@injectable
class LanguageCubit extends Cubit<AppLocale> {
  final SharedPreferences _prefs;
  static const _languageKey = 'appLanguage';

  LanguageCubit(this._prefs) : super(_getInitialLocale(_prefs));

  static AppLocale _getInitialLocale(SharedPreferences prefs) {
    final savedLanguage = prefs.getString(_languageKey);
    if (savedLanguage != null) {
      return AppLocale.values.firstWhere(
        (locale) => locale.languageCode == savedLanguage,
        orElse: () => AppLocale.en,
      );
    }
    return AppLocale.en;
  }

  Future<void> setLanguage(AppLocale locale) async {
    await _prefs.setString(_languageKey, locale.languageCode);
    LocaleSettings.setLocale(locale);
    emit(locale);
  }
}
