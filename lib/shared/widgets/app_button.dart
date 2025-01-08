import 'package:flutter/material.dart';

/// A customizable button widget that follows the app's theme guidelines.
class AppButton extends StatelessWidget {
  /// Creates an AppButton with required text and onPressed callback.
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.variant = AppButtonVariant.primary,
    this.width,
    this.height = 48,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;
  final double? width;
  final double height;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(theme),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    return isLoading
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
        );
      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
        );
    }
  }
}

enum AppButtonVariant { primary, secondary }
