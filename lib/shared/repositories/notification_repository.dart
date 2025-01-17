import 'dart:io';

import 'package:dream/shared/services/notification_servicess.dart';
import 'package:dream/shared/services/platform_notification_settings.dart';
import 'package:dream/shared/services/time_zone_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Main notification service implementing the interface
@singleton
class NotificationRepository implements INotificationService {
  final FlutterLocalNotificationsPlugin _notifications;
  final IPlatformNotificationSettings _platformSettings;
  final ITimeZoneService _timeZoneService;
  final SharedPreferences _prefs;
  bool _isInitialized = false;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static const String _permissionsRequestedKey =
      'notification_permissions_requested';

  NotificationRepository(
    this._notifications,
    this._platformSettings,
    this._timeZoneService,
    this._prefs,
  );

  Future<bool> _checkAndroidPermissions() async {
    if (!Platform.isAndroid) return true;

    final androidInfo = await _deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt < 33) return true;

    final permissionStatus = await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    return permissionStatus ?? false;
  }

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _timeZoneService.initialize();
    final settings = await _platformSettings.getSettings();
    await _notifications.initialize(settings);

    // Request permissions on first app launch
    final permissionsRequested =
        _prefs.getBool(_permissionsRequestedKey) ?? false;
    if (!permissionsRequested) {
      if (Platform.isIOS) {
        await _platformSettings.requestPermissions(_notifications);
      } else {
        await _checkAndroidPermissions();
      }
      await _prefs.setBool(_permissionsRequestedKey, true);
    }

    _isInitialized = true;
  }

  @override
  Future<void> scheduleDreamReminder({
    required DateTime time,
  }) async {
    if (!_isInitialized) await initialize();

    final scheduledDate = await _timeZoneService.getScheduledDate(time);

    await _notifications.zonedSchedule(
      0,
      'Dream Journal',
      'Time to record your dream!',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dream_reminder',
          'Dream Reminders',
          channelDescription: 'Notifications for dream recording reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> cancelAllReminders() async {
    if (!_isInitialized) await initialize();
    await _notifications.cancelAll();
  }
}
