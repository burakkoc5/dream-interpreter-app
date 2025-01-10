import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_step.freezed.dart';
part 'onboarding_step.g.dart';

@freezed
class OnboardingStep with _$OnboardingStep {
  const factory OnboardingStep({
    required String title,
    required String subtitle,
    required String imagePath,
    required String buttonText,
    required String backgroundColor,
  }) = _OnboardingStep;

  factory OnboardingStep.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStepFromJson(json);
}
