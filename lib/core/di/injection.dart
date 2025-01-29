import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/core/di/injection.config.dart';
import 'package:dream/shared/repositories/time_zone_repository.dart';
import 'package:dream/shared/services/android_notification_settings.dart';
import 'package:dream/shared/services/ios_notification_settings.dart';
import 'package:dream/shared/services/platform_notification_settings.dart';
import 'package:dream/shared/services/time_zone_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async {
  await init(getIt);
  await getIt.allReady();
}

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @singleton
  FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;

  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @singleton
  FlutterLocalNotificationsPlugin get notifications =>
      FlutterLocalNotificationsPlugin();

  @singleton
  IPlatformNotificationSettings get platformSettings => Platform.isIOS
      ? IOSNotificationSettings()
      : AndroidNotificationSettings();

  @singleton
  ITimeZoneService get timeZoneService => TimeZoneRepository();
}
