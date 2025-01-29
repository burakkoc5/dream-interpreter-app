import 'package:flutter/material.dart';
import 'package:dream/shared/widgets/app_button.dart' as app;

/// A customizable icon button widget that follows the app's design system.
///
/// This is a convenience wrapper around [AppButton] for icon-only use cases.
/// It provides a more concise API for creating icon buttons.
class AppIconButton extends StatelessWidget {
  /// Creates an AppIconButton with required icon and onPressed callback.
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = app.ButtonSize.small,
    this.style = app.ButtonStyle.text,
    this.color,
    this.padding = const EdgeInsets.all(8),
    this.isLoading = false,
    this.borderRadius,
    this.elevated = false,
  });

  /// The icon to display
  final IconData icon;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// The size variant of the button
  final app.ButtonSize size;

  /// The style variant of the button
  final app.ButtonStyle style;

  /// Optional custom color for the icon
  final Color? color;

  /// Optional custom padding
  final EdgeInsets padding;

  /// Whether to show a loading indicator instead of the icon
  final bool isLoading;

  /// Optional custom border radius
  final double? borderRadius;

  /// Whether to show elevation shadow
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return app.AppButton(
      text: '',
      icon: icon,
      iconOnly: true,
      onPressed: onPressed,
      style: style,
      size: size,
      padding: padding,
      foregroundColor: color,
      borderRadius: borderRadius,
      elevated: elevated,
      isLoading: isLoading,
    );
  }
}
