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
  static const String _channelId = 'dream_reminder';
  static const String _channelName = 'Dream Reminders';
  static const String _channelDescription =
      'Notifications for dream recording reminders';

  NotificationRepository(
    this._notifications,
    this._platformSettings,
    this._timeZoneService,
    this._prefs,
  );

  Future<bool> checkNotificationPermissions() async {
    if (!Platform.isAndroid) return true;

    final androidInfo = await _deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt < 33) return true;

    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin == null) return false;

    final areNotificationsEnabled =
        await androidPlugin.areNotificationsEnabled();
    final hasExactAlarms = await androidPlugin.requestExactAlarmsPermission();

    return (areNotificationsEnabled ?? false) && (hasExactAlarms ?? false);
  }

  Future<bool> _checkAndRequestAndroidPermissions() async {
    if (!Platform.isAndroid) return true;

    final androidInfo = await _deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt < 33) return true;

    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin == null) return false;

    // First check if we already have permissions
    final hasPermissions = await checkNotificationPermissions();
    if (hasPermissions) return true;

    // Request permissions if we don't have them
    final notificationPermission =
        await androidPlugin.requestNotificationsPermission();
    final alarmPermission = await androidPlugin.requestExactAlarmsPermission();

    return (notificationPermission ?? false) && (alarmPermission ?? false);
  }

  Future<void> _createNotificationChannel() async {
    if (!Platform.isAndroid) return;

    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin == null) return;

    // Check if channel exists first
    final channels = await androidPlugin.getNotificationChannels();
    final channelExists =
        channels?.any((channel) => channel.id == _channelId) ?? false;

    if (!channelExists) {
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: _channelDescription,
          importance: Importance.high,
          enableVibration: true,
          enableLights: true,
          playSound: true,
          showBadge: true,
        ),
      );
    }
  }

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    print('NotificationRepository: Starting initialization');
    try {
      await _timeZoneService.initialize();
      final settings = await _platformSettings.getSettings();

      // Ensure proper initialization with sound and icon
      final initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      final success = await _notifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          print(
              'NotificationRepository: Notification received: ${details.payload}');
        },
      );
      print('NotificationRepository: Initialization result: $success');

      await _createNotificationChannel();
      print('NotificationRepository: Notification channel created');

      // Request permissions on first app launch
      final permissionsRequested =
          _prefs.getBool(_permissionsRequestedKey) ?? false;
      if (!permissionsRequested) {
        if (Platform.isIOS) {
          await _platformSettings.requestPermissions(_notifications);
        } else {
          await _checkAndRequestAndroidPermissions();
        }
        await _prefs.setBool(_permissionsRequestedKey, true);
      }

      _isInitialized = true;
      print('NotificationRepository: Initialization completed');
    } catch (e) {
      print('NotificationRepository: Initialization failed: $e');
      _isInitialized = false;
      rethrow;
    }
  }

  @override
  Future<void> scheduleDreamReminder({
    required DateTime time,
  }) async {
    if (!_isInitialized) {
      print('NotificationRepository: Not initialized, initializing now...');
      await initialize();
    }

    print('NotificationRepository: Scheduling reminder for time: $time');

    // Check permissions first
    final hasPermissions = await checkNotificationPermissions();
    print(
        'NotificationRepository: Has notification permissions: $hasPermissions');
    if (!hasPermissions) {
      print('NotificationRepository: Missing required permissions');
      await _checkAndRequestAndroidPermissions();
      final newPermissions = await checkNotificationPermissions();
      print(
          'NotificationRepository: Permissions after request: $newPermissions');
      if (!newPermissions) {
        print(
            'NotificationRepository: Failed to get permissions, cannot schedule notification');
        return;
      }
    }

    // Cancel existing reminders before scheduling new one
    print('NotificationRepository: Cancelling existing reminders');
    await cancelAllReminders();

    final scheduledDate = await _timeZoneService.getScheduledDate(time);
    print('NotificationRepository: Converted to timezone date: $scheduledDate');

    try {
      // Verify Android plugin is available
      final androidPlugin =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin == null) {
        print('NotificationRepository: Android plugin not available');
        return;
      }

      await _notifications.zonedSchedule(
        0,
        'Dream Journal',
        'Time to record your dream!',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.high,
            priority: Priority.high,
            enableVibration: true,
            enableLights: true,
            playSound: true,
            icon: '@mipmap/ic_launcher',
            category: AndroidNotificationCategory.reminder,
            visibility: NotificationVisibility.public,
            fullScreenIntent:
                true, // Add this to ensure notification shows even on locked screen
          ),
          iOS: const DarwinNotificationDetails(
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
      print('NotificationRepository: Successfully scheduled notification');

      // Verify the notification was scheduled
      final pendingNotifs = await androidPlugin.pendingNotificationRequests();
      print(
          'NotificationRepository: Pending notifications: ${pendingNotifs.length}');
      if (pendingNotifs.isEmpty) {
        print(
            'NotificationRepository: Warning - No pending notifications found after scheduling');
      }
    } catch (e, stackTrace) {
      print('NotificationRepository: Failed to schedule notification: $e');
      print('NotificationRepository: Stack trace: $stackTrace');
    }
  }

  @override
  Future<void> cancelAllReminders() async {
    if (!_isInitialized) await initialize();
    await _notifications.cancelAll();
  }
}
