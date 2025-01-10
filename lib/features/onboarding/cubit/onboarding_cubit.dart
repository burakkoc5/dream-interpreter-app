import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class OnboardingCubit extends Cubit<bool> {
  final SharedPreferences _prefs;
  static const String _onboardingCompleteKey = 'onboarding_complete';

  OnboardingCubit(this._prefs) : super(false);

  bool get isOnboardingComplete =>
      _prefs.getBool(_onboardingCompleteKey) ?? false;

  Future<void> completeOnboarding() async {
    await _prefs.setBool(_onboardingCompleteKey, true);
    emit(true);
  }
}
