import 'package:dream/shared/services/platform_notification_settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

/// Android specific notification settings
@injectable
class AndroidNotificationSettings implements IPlatformNotificationSettings {
  @override
  Future<InitializationSettings> getSettings() async {
    final androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    return InitializationSettings(android: androidSettings);
  }

  @override
  Future<void> requestPermissions(
      FlutterLocalNotificationsPlugin notifications) async {
    // Android permissions are handled through the manifest
    return;
  }
}
