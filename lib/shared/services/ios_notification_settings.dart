import 'package:dream/shared/services/platform_notification_settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

@injectable
class IOSNotificationSettings implements IPlatformNotificationSettings {
  @override
  Future<InitializationSettings> getSettings() async {
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    return InitializationSettings(iOS: iosSettings);
  }

  @override
  Future<void> requestPermissions(
      FlutterLocalNotificationsPlugin notifications) async {
    await notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
