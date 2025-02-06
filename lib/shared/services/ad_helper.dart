import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdHelper {
  static String get appId {
    if (Platform.isAndroid) {
      return dotenv.env['ADMOB_ANDROID_APP_ID'] ??
          'ca-app-pub-3940256099942544~3347511713';
    } else if (Platform.isIOS) {
      return dotenv.env['ADMOB_IOS_APP_ID'] ??
          'ca-app-pub-3940256099942544~1458002511';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return dotenv.env['ADMOB_ANDROID_REWARDED_AD_ID'] ??
          'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return dotenv.env['ADMOB_IOS_REWARDED_AD_ID'] ??
          'ca-app-pub-3940256099942544/1712485313';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
