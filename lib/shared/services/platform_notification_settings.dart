import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class IPlatformNotificationSettings {
  Future<InitializationSettings> getSettings();
  Future<void> requestPermissions(
      FlutterLocalNotificationsPlugin notifications);
}
