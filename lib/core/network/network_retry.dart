import 'dart:async';
import 'package:dream/core/services/logging_service.dart';

class NetworkRetry {
  final LoggingService _logger;
  final int maxAttempts;
  final Duration initialDelay;
  final double backoffFactor;

  NetworkRetry(
    this._logger, {
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.backoffFactor = 2.0,
  });

  Future<T> retry<T>(
    Future<T> Function() operation, {
    String? operationName,
    bool Function(Exception)? shouldRetry,
  }) async {
    int attempts = 0;
    Duration currentDelay = initialDelay;
    Exception? lastException;

    while (attempts < maxAttempts) {
      try {
        attempts++;
        return await operation();
      } on Exception catch (e) {
        lastException = e;

        if (shouldRetry != null && !shouldRetry(e)) {
          _logger.log(
            'Operation ${operationName ?? 'unknown'} failed with non-retryable exception',
            level: LogLevel.error,
            error: e,
          );
          rethrow;
        }

        if (attempts == maxAttempts) {
          _logger.log(
            'Operation ${operationName ?? 'unknown'} failed after $maxAttempts attempts',
            level: LogLevel.error,
            error: e,
            additionalData: {
              'attempts': attempts,
              'maxAttempts': maxAttempts,
            },
          );
          rethrow;
        }

        _logger.log(
          'Operation ${operationName ?? 'unknown'} failed, attempt $attempts of $maxAttempts',
          level: LogLevel.warning,
          error: e,
          additionalData: {
            'attempt': attempts,
            'maxAttempts': maxAttempts,
            'nextRetryDelay': currentDelay.inMilliseconds,
          },
        );

        await Future.delayed(currentDelay);
        currentDelay *= backoffFactor;
      }
    }

    throw lastException ?? Exception('Unknown error in retry mechanism');
  }

  Future<T> retryWithFallback<T>(
    Future<T> Function() operation,
    T fallback, {
    String? operationName,
    bool Function(Exception)? shouldRetry,
  }) async {
    try {
      return await retry(
        operation,
        operationName: operationName,
        shouldRetry: shouldRetry,
      );
    } catch (e) {
      _logger.log(
        'Operation ${operationName ?? 'unknown'} failed, using fallback value',
        level: LogLevel.warning,
        error: e,
      );
      return fallback;
    }
  }
}
