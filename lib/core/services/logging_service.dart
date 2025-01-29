import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

@singleton
class LoggingService {
  final FirebaseCrashlytics _crashlytics;

  LoggingService(this._crashlytics) {
    // Set up Crashlytics
    _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  void log(
    String message, {
    LogLevel level = LogLevel.info,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalData,
  }) {
    if (kDebugMode) {
      _logDebug(message, level, error, stackTrace, additionalData);
    } else {
      _logProduction(message, level, error, stackTrace, additionalData);
    }
  }

  void _logDebug(
    String message,
    LogLevel level,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalData,
  ) {
    final now = DateTime.now();
    final logMessage = '''
    [$now] ${level.name.toUpperCase()}: $message
    ${error != null ? '\nError: $error' : ''}
    ${stackTrace != null ? '\nStack Trace: $stackTrace' : ''}
    ${additionalData != null ? '\nAdditional Data: $additionalData' : ''}
    ''';

    debugPrint(logMessage);
  }

  void _logProduction(
    String message,
    LogLevel level,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalData,
  ) {
    // Always log to console in a minimal format
    debugPrint('${level.name.toUpperCase()}: $message');

    // For warnings and errors, log to Crashlytics
    if (level == LogLevel.warning || level == LogLevel.error) {
      _crashlytics.log(message);

      if (additionalData != null) {
        for (final entry in additionalData.entries) {
          _crashlytics.setCustomKey(entry.key, entry.value.toString());
        }
      }

      if (error != null) {
        _crashlytics.recordError(
          error,
          stackTrace,
          reason: message,
          fatal: level == LogLevel.error,
        );
      }
    }
  }

  Future<void> setUserIdentifier(String userId) async {
    if (!kDebugMode) {
      await _crashlytics.setUserIdentifier(userId);
    }
  }
}
