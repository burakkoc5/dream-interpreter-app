import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_settings_model.freezed.dart';
part 'reminder_settings_model.g.dart';

@freezed
class ReminderSettings with _$ReminderSettings {
  const factory ReminderSettings({
    required String type,
    required DateTime time,
    @Default(true) bool isEnabled,
  }) = _ReminderSettings;

  factory ReminderSettings.fromJson(Map<String, dynamic> json) =>
      _$ReminderSettingsFromJson(json);
}

enum ReminderType {
  earlyMorning,
  afternoon,
  nighttime,
  custom,
}
