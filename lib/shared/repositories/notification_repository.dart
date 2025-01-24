import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:dream/shared/services/notification_servicess.dart';
import 'package:dream/shared/services/platform_notification_settings.dart';
import 'package:dream/shared/services/time_zone_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/main.dart';

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
  static const int _notificationId = 0; // Fixed notification ID for reminders

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
      debugPrint('Notification channel created');
    }
  }

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    debugPrint('NotificationRepository: Starting initialization');
    try {
      await _timeZoneService.initialize();
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
          debugPrint(
              'NotificationRepository: Notification received: ${details.payload}');
          // Get the BuildContext from the navigator key and navigate
          final context = navigatorKey.currentContext;
          if (context != null) {
            context.go('/dream-entry');
          }
        },
      );
      debugPrint('NotificationRepository: Initialization result: $success');

      await _createNotificationChannel();
      debugPrint('NotificationRepository: Notification channel created');

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
      debugPrint('NotificationRepository: Initialization completed');
    } catch (e) {
      debugPrint('NotificationRepository: Initialization failed: $e');
      _isInitialized = false;
      rethrow;
    }
  }

  void _logDebug(String message) {
    debugPrint('🔔 NotificationDebug: $message');
  }

  Future<bool> isSystemNotificationsEnabled() async {
    if (Platform.isIOS) {
      final iosPlugin = _notifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      if (iosPlugin == null) return false;

      final result = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      // On iOS, if we can request permissions, it means notifications are enabled
      return result != null;
    } else if (Platform.isAndroid) {
      final androidPlugin =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin == null) return false;

      final areNotificationsEnabled =
          await androidPlugin.areNotificationsEnabled();
      return areNotificationsEnabled ?? false;
    }
    return false;
  }

  @override
  Future<void> scheduleDreamReminder({
    required DateTime time,
  }) async {
    if (!_isInitialized) {
      _logDebug('Not initialized, initializing now...');
      await initialize();
    }

    _logDebug('========================');
    _logDebug('Starting notification scheduling process');
    _logDebug('Target time: $time');
    _logDebug('Current time: ${DateTime.now()}');

    // Check system notification settings first
    final systemNotificationsEnabled = await isSystemNotificationsEnabled();
    _logDebug('System notifications enabled: $systemNotificationsEnabled');

    if (!systemNotificationsEnabled) {
      _logDebug('❌ System notifications are disabled');
      await cancelAllReminders();
      return;
    }

    // Check permissions
    final hasPermissions = await checkNotificationPermissions();
    _logDebug('Initial permission check: $hasPermissions');

    if (!hasPermissions) {
      _logDebug('Missing permissions, requesting now...');
      if (Platform.isIOS) {
        await _platformSettings.requestPermissions(_notifications);
      } else {
        await _checkAndRequestAndroidPermissions();
      }
      final newPermissions = await checkNotificationPermissions();
      _logDebug('Permissions after request: $newPermissions');
      if (!newPermissions) {
        _logDebug('❌ Failed to get permissions, cannot schedule notification');
        await cancelAllReminders();
        return;
      }
    }

    // Cancel existing reminders before scheduling new one
    _logDebug('Cancelling existing reminders');
    await cancelAllReminders();

    final scheduledDate = await _timeZoneService.getScheduledDate(time);
    _logDebug('Timezone converted date: $scheduledDate');

    try {
      _logDebug('Attempting to schedule notification...');
      await _notifications.zonedSchedule(
        _notificationId, // Use fixed notification ID
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
            autoCancel: true,
            icon: '@mipmap/ic_launcher',
            largeIcon:
                const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            enableLights: true,
            playSound: true,
            showWhen: true,
            category: AndroidNotificationCategory.reminder,
            visibility: NotificationVisibility.public,
            fullScreenIntent: true,
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
      _logDebug('✅ Successfully scheduled notification');

      // Verify the notification was scheduled
      if (Platform.isAndroid) {
        final androidPlugin =
            _notifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
        if (androidPlugin != null) {
          final pendingNotifs =
              await androidPlugin.pendingNotificationRequests();
          _logDebug('Number of pending notifications: ${pendingNotifs.length}');
        }
      }

      _logDebug('========================');
    } catch (e, stackTrace) {
      _logDebug('❌ Failed to schedule notification');
      _logDebug('Error: $e');
      _logDebug('Stack trace: $stackTrace');
      _logDebug('========================');
      await cancelAllReminders();
      rethrow;
    }
  }

  @override
  Future<void> cancelAllReminders() async {
    if (!_isInitialized) await initialize();
    await _notifications.cancelAll();
  }
}
