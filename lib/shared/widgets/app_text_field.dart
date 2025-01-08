import 'package:flutter/material.dart';

/// A customizable text field widget that follows the app's theme guidelines.
class AppTextField extends StatelessWidget {
  /// Creates an AppTextField with optional configuration parameters.
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator,
    );
  }
}
