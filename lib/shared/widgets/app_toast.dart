import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// A utility class for showing toast notifications in the app.
///
/// This class provides a consistent way to show different types of toast notifications
/// (success, error, info, warning) with proper styling and animations.
class AppToast {
  /// Shows a success toast notification.
  static void showSuccess(
    BuildContext context, {
    required String title,
    String? description,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
      ),
      description: description != null
          ? Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.8),
                  ),
            )
          : null,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      primaryColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topCenter,
      dragToClose: true,
      showProgressBar: true,
      closeOnClick: true,
      pauseOnHover: true,
    );
  }

  /// Shows an error toast notification.
  static void showError(
    BuildContext context, {
    required String title,
    String? description,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
      ),
      description: description != null
          ? Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.8),
                  ),
            )
          : null,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      primaryColor: Theme.of(context).colorScheme.error,
      backgroundColor: Theme.of(context).colorScheme.surface,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topCenter,
      dragToClose: true,
      showProgressBar: true,
      closeOnClick: true,
      pauseOnHover: true,
    );
  }

  /// Shows an info toast notification.
  static void showInfo(
    BuildContext context, {
    required String title,
    String? description,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
      ),
      description: description != null
          ? Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.8),
                  ),
            )
          : null,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      primaryColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topCenter,
      dragToClose: true,
      showProgressBar: true,
      closeOnClick: true,
      pauseOnHover: true,
    );
  }

  /// Shows a warning toast notification.
  static void showWarning(
    BuildContext context, {
    required String title,
    String? description,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
      ),
      description: description != null
          ? Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.8),
                  ),
            )
          : null,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      primaryColor: Theme.of(context).colorScheme.tertiary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topCenter,
      dragToClose: true,
      showProgressBar: true,
      closeOnClick: true,
      pauseOnHover: true,
    );
  }
}
