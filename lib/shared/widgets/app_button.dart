import 'package:flutter/material.dart';
import 'package:dream/shared/widgets/app_loading.dart';

/// The style variants available for [AppButton].
enum ButtonStyle {
  /// Primary action button with filled background
  primary,

  /// Secondary action button with filled background
  secondary,

  /// Outlined button with border and transparent background
  outlined,

  /// Text-only button without background
  text,

  /// Warning/Danger button with error color
  danger,
}

/// The size variants available for [AppButton].
enum ButtonSize {
  /// Small compact button
  small,

  /// Regular sized button (default)
  regular,

  /// Large prominent button
  large,
}

/// A customizable button widget that follows the app's design system.
///
/// This button can be styled in different ways using [ButtonStyle] and supports
/// various features like loading states, icons, and different sizes.
///
/// Example usage:
/// ```dart
/// AppButton(
///   text: 'Submit',
///   onPressed: handleSubmit,
///   style: ButtonStyle.primary,
///   size: ButtonSize.regular,
///   isLoading: isSubmitting,
///   icon: Icons.send,
/// )
/// ```
class AppButton extends StatelessWidget {
  /// Creates an AppButton with required text and onPressed callback.
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.style = ButtonStyle.primary,
    this.size = ButtonSize.regular,
    this.isFullWidth = false,
    this.icon,
    this.iconOnly = false,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.elevated = true,
  });

  /// The text to display on the button
  final String text;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Whether to show a loading indicator instead of the text/icon
  final bool isLoading;

  /// The style variant of the button
  final ButtonStyle style;

  /// The size variant of the button
  final ButtonSize size;

  /// Whether the button should take up the full width of its container
  final bool isFullWidth;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Whether to show only the icon without text
  final bool iconOnly;

  /// Optional custom width
  final double? width;

  /// Optional custom height
  final double? height;

  /// Optional custom padding
  final EdgeInsets? padding;

  /// Optional custom border radius
  final double? borderRadius;

  /// Optional custom background color
  final Color? backgroundColor;

  /// Optional custom foreground color
  final Color? foregroundColor;

  /// Whether to show elevation shadow
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderRadius = borderRadius ?? 16.0;
    final defaultPadding = padding ?? _getPaddingForSize(size);

    Widget buildButtonContent() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && !isLoading) ...[
            Icon(
              icon,
              size: _getIconSize(size),
            ),
            if (!iconOnly) const SizedBox(width: 8),
          ],
          if (isLoading)
            AppLoading(
              size: _getLoadingSize(size),
              color: _getForegroundColor(theme),
              style: LoadingStyle.doubleBounce,
            )
          else if (!iconOnly)
            Flexible(
              child: Text(
                text,
                style: _getTextStyle(theme),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      );
    }

    Widget button;
    switch (style) {
      case ButtonStyle.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? theme.colorScheme.primary,
            foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
            padding: defaultPadding,
            elevation: elevated ? _getElevation(size) : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.pressed)
                  ? theme.colorScheme.onPrimary.withValues(alpha: 0.1)
                  : null;
            }),
          ),
          child: buildButtonContent(),
        );
        break;

      case ButtonStyle.secondary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? theme.colorScheme.secondary,
            foregroundColor: foregroundColor ?? theme.colorScheme.onSecondary,
            padding: defaultPadding,
            elevation: elevated ? _getElevation(size) : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.pressed)
                  ? theme.colorScheme.onSecondary.withValues(alpha: 0.1)
                  : null;
            }),
          ),
          child: buildButtonContent(),
        );
        break;

      case ButtonStyle.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? theme.colorScheme.primary,
            padding: defaultPadding,
            side: BorderSide(
              color: backgroundColor ?? theme.colorScheme.primary,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.pressed)
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : null;
            }),
          ),
          child: buildButtonContent(),
        );
        break;

      case ButtonStyle.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor ?? theme.colorScheme.primary,
            padding: defaultPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.pressed)
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : null;
            }),
          ),
          child: buildButtonContent(),
        );
        break;

      case ButtonStyle.danger:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? theme.colorScheme.error,
            foregroundColor: foregroundColor ?? theme.colorScheme.onError,
            padding: defaultPadding,
            elevation: elevated ? _getElevation(size) : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.pressed)
                  ? theme.colorScheme.onError.withValues(alpha: 0.1)
                  : null;
            }),
          ),
          child: buildButtonContent(),
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: height ?? _getHeight(size),
        child: button,
      );
    }

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height ?? _getHeight(size),
        child: button,
      );
    }

    return button;
  }

  EdgeInsets _getPaddingForSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.regular:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
    }
  }

  double _getIconSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.regular:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  double _getLoadingSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.regular:
        return 24;
      case ButtonSize.large:
        return 28;
    }
  }

  double _getHeight(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.regular:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  double _getElevation(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 2;
      case ButtonSize.regular:
        return 4;
      case ButtonSize.large:
        return 6;
    }
  }

  TextStyle? _getTextStyle(ThemeData theme) {
    final baseStyle = theme.textTheme.labelLarge?.copyWith(
      color: _getForegroundColor(theme),
      fontWeight: FontWeight.w600,
      height: 1,
      leadingDistribution: TextLeadingDistribution.even,
    );

    switch (size) {
      case ButtonSize.small:
        return baseStyle?.copyWith(fontSize: 12);
      case ButtonSize.regular:
        return baseStyle?.copyWith(fontSize: 14);
      case ButtonSize.large:
        return baseStyle?.copyWith(fontSize: 16);
    }
  }

  Color? _getForegroundColor(ThemeData theme) {
    if (foregroundColor != null) return foregroundColor;

    switch (style) {
      case ButtonStyle.primary:
        return theme.colorScheme.onPrimary;
      case ButtonStyle.secondary:
        return theme.colorScheme.onSecondary;
      case ButtonStyle.danger:
        return theme.colorScheme.onError;
      case ButtonStyle.outlined:
      case ButtonStyle.text:
        return theme.colorScheme.primary;
    }
  }
}
