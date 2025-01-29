import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable text field widget that follows the app's design system.
///
/// This text field provides consistent styling and behavior across the app,
/// with support for various input types, validation, and customization options.
///
/// Example usage:
/// ```dart
/// AppTextField(
///   label: 'Email',
///   hint: 'Enter your email',
///   keyboardType: TextInputType.emailAddress,
///   validator: (value) {
///     if (value?.isEmpty ?? true) return 'Email is required';
///     if (!value!.contains('@')) return 'Invalid email format';
///     return null;
///   },
/// )
/// ```
class AppTextField extends StatelessWidget {
  /// Creates an AppTextField with optional configuration parameters.
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.prefix,
    this.suffix,
    this.contentPadding,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.expands = false,
    this.initialValue,
    this.autovalidateMode,
    this.showClearButton = false,
    this.showCharacterCount = false,
    this.borderRadius,
    this.fillColor,
    this.style,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The label text displayed above the input field.
  final String? label;

  /// The hint text displayed when the input field is empty.
  final String? hint;

  /// The error text displayed below the input field.
  final String? errorText;

  /// Whether to hide the text being edited.
  final bool obscureText;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The type of action button to show on the keyboard.
  final TextInputAction? textInputAction;

  /// Called when the text being edited changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits editable content.
  final VoidCallback? onEditingComplete;

  /// Called to validate the input.
  final FormFieldValidator<String>? validator;

  /// Optional input formatters to use.
  final List<TextInputFormatter>? inputFormatters;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// The minimum number of lines for the text to span.
  final int? minLines;

  /// The maximum number of characters the text field will accept.
  final int? maxLength;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Optional widget to show before the text input.
  final Widget? prefix;

  /// Optional widget to show after the text input.
  final Widget? suffix;

  /// The padding around the input decoration.
  final EdgeInsetsGeometry? contentPadding;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Called when the user taps this text field.
  final VoidCallback? onTap;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;

  /// Whether this widget's height will be sized to fill its parent.
  final bool expands;

  /// The initial value of the text field.
  final String? initialValue;

  /// Used to enable/disable auto validation and to control the error text visibility.
  final AutovalidateMode? autovalidateMode;

  /// Whether to show a clear button when the field has text.
  final bool showClearButton;

  /// Whether to show the character count below the field.
  final bool showCharacterCount;

  /// The border radius of the text field.
  final double? borderRadius;

  /// The background color of the text field.
  final Color? fillColor;

  /// The text style to use for the input text.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultRadius = borderRadius ?? 16.0;
    final defaultPadding = contentPadding ??
        const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        );

    Widget? suffixWidget = suffix;
    if (showClearButton && controller != null && controller!.text.isNotEmpty) {
      suffixWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (suffix != null) ...[
            suffix!,
            const SizedBox(width: 8),
          ],
          IconButton(
            icon: Icon(
              Icons.clear,
              size: 18,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            onPressed: () => controller?.clear(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefix,
            suffixIcon: suffixWidget,
            contentPadding: defaultPadding,
            filled: true,
            fillColor: fillColor ?? theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.error.withValues(alpha: 0.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2,
              ),
            ),
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          style: style ?? theme.textTheme.bodyLarge,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          validator: validator,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          enabled: enabled,
          focusNode: focusNode,
          autofocus: autofocus,
          readOnly: readOnly,
          onTap: onTap,
          textCapitalization: textCapitalization,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          expands: expands,
          autovalidateMode: autovalidateMode,
          buildCounter: showCharacterCount
              ? (
                  BuildContext context, {
                  required int currentLength,
                  required bool isFocused,
                  required int? maxLength,
                }) {
                  return Text(
                    '$currentLength${maxLength != null ? '/$maxLength' : ''}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  );
                }
              : null,
        ),
      ],
    );
  }
}
