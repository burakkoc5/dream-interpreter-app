import 'package:dream/features/profile/models/reminder_settings_model.dart';
import 'package:flutter/material.dart';

DateTime getTimeForType(ReminderType type, TimeOfDay? customTime) {
  final now = DateTime.now();
  switch (type) {
    case ReminderType.earlyMorning:
      return DateTime(now.year, now.month, now.day, 6, 0);
    case ReminderType.afternoon:
      return DateTime(now.year, now.month, now.day, 14, 0);
    case ReminderType.nighttime:
      return DateTime(now.year, now.month, now.day, 22, 0);
    case ReminderType.custom:
      if (customTime != null) {
        return DateTime(
            now.year, now.month, now.day, customTime.hour, customTime.minute);
      }
      return now;
  }
}
