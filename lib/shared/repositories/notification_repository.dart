import 'dart:io';

import 'package:dream/shared/services/notification_servicess.dart';
import 'package:dream/shared/services/platform_notification_settings.dart';
import 'package:dream/shared/services/time_zone_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// Main notification service implementing the interface
@singleton
class NotificationRepository implements INotificationService {
  final FlutterLocalNotificationsPlugin _notifications;
  final IPlatformNotificationSettings _platformSettings;
  final ITimeZoneService _timeZoneService;
  bool _isInitialized = false;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  NotificationRepository(
    this._notifications,
    this._platformSettings,
    this._timeZoneService,
  );

  Future<bool> _checkAndroidPermissions() async {
    if (!Platform.isAndroid) return true;

    final androidInfo = await _deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 31) {
      // Android 12 or higher
      final androidPlugin =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      // Check exact alarm permission
      final alarmPermissionStatus =
          await androidPlugin?.requestExactAlarmsPermission();
      if (alarmPermissionStatus != true) {
        print('Exact alarm permission not granted');
        return false;
      }

      // Check notification permission
      final notificationPermissionStatus =
          await androidPlugin?.requestNotificationsPermission();
      if (notificationPermissionStatus != true) {
        print('Notification permission not granted');
        return false;
      }
    }
    return true;
  }

  Future<bool> _requestIOSPermissions() async {
    if (!Platform.isIOS) return true;

    final iosPlugin = _notifications.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    final bool? permissionResult = await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    return permissionResult ?? false;
  }

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _timeZoneService.initialize();
    final settings = await _platformSettings.getSettings();
    await _platformSettings.requestPermissions(_notifications);

    final hasIOSPermissions = await _requestIOSPermissions();
    if (!hasIOSPermissions) {
      throw Exception('iOS permissions not granted');
    }

    final hasAndroidPermissions = await _checkAndroidPermissions();
    if (!hasAndroidPermissions) {
      throw Exception('Android permissions not granted');
    }

    await _notifications.initialize(settings);

    _isInitialized = true;
  }

  @override
  Future<void> scheduleDreamReminder({required DateTime time}) async {
    if (!_isInitialized) {
      await initialize();
    }

    final androidDetails = AndroidNotificationDetails(
      'dream_reminders',
      'Dream Reminders',
      channelDescription: 'Notifications for dream entry reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    final scheduledDate = await _timeZoneService.getScheduledDate(time);
    final int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _notifications.zonedSchedule(
      notificationId,
      'Time to Record Your Dream',
      'Don\'t forget to write down your dream while it\'s fresh in your memory!',
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> cancelAllReminders() async {
    await _notifications.cancelAll();
  }
}
