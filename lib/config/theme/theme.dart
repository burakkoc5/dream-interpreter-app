import 'package:flutter/material.dart';

/// AppTheme defines the application's theme configuration including colors,
/// typography, and other Material Design attributes for both light and dark modes.
class AppTheme {
  // Dreamy color palette with ethereal tones
  static const _primaryColor = Color(0xFF8B7FD7); // Soft purple
  static const _secondaryColor = Color(0xFFB4A6FF); // Light lavender
  static const _tertiaryColor = Color(0xFFE2C6FF); // Pale lilac
  static const _errorColor = Color(0xFFFF6B6B); // Soft red
  static const _backgroundColor =
      Color(0xFFF8F6FF); // Light ethereal background
  static const _darkBackgroundColor =
      Color(0xFF1A1625); // Deep mysterious background
  static const _accentColor = Color(0xFFFFA6B9); // Soft pink accent

  /// Creates the light theme configuration for the application.
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _tertiaryColor,
        error: _errorColor,
        surface: _backgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onError: Colors.white,
        onSurface: const Color(0xFF2D2738),
        surfaceTint: _accentColor.withValues(alpha: 0.1),
        outline: _primaryColor.withValues(alpha: 0.3),
      ),
      textTheme: _buildTextTheme(),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _backgroundColor.withValues(alpha: 0.8),
        foregroundColor: _primaryColor,
        shadowColor: _primaryColor.withValues(alpha: 0.1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: _primaryColor.withValues(alpha: 0.3),
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _primaryColor.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _primaryColor.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _errorColor.withValues(alpha: 0.5)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.9),
        labelStyle: TextStyle(color: _primaryColor.withValues(alpha: 0.8)),
        hintStyle: TextStyle(color: _primaryColor.withValues(alpha: 0.5)),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: _primaryColor.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white.withValues(alpha: 0.9),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _primaryColor.withValues(alpha: 0.9),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      dividerTheme: DividerThemeData(
        space: 24,
        thickness: 1,
        color: _primaryColor.withValues(alpha: 0.1),
      ),
      scaffoldBackgroundColor: _backgroundColor,
      chipTheme: ChipThemeData(
        backgroundColor: _primaryColor.withValues(alpha: 0.1),
        selectedColor: _primaryColor,
        labelStyle: const TextStyle(fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Creates the dark theme configuration for the application.
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _tertiaryColor,
        error: _errorColor,
        surface: _darkBackgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onError: Colors.white,
        onSurface: const Color(0xFFF8F6FF),
        surfaceTint: _accentColor.withValues(alpha: 0.1),
        outline: _primaryColor.withValues(alpha: 0.4),
      ),
      textTheme: _buildTextTheme(),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _darkBackgroundColor.withValues(alpha: 0.8),
        foregroundColor: _primaryColor,
        shadowColor: _primaryColor.withValues(alpha: 0.2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: _primaryColor.withValues(alpha: 0.4),
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _primaryColor.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _primaryColor.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _errorColor.withValues(alpha: 0.5)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        filled: true,
        fillColor: _darkBackgroundColor.withValues(alpha: 0.7),
        labelStyle: TextStyle(color: _primaryColor.withValues(alpha: 0.8)),
        hintStyle: TextStyle(color: _primaryColor.withValues(alpha: 0.5)),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: _primaryColor.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: _darkBackgroundColor.withValues(alpha: 0.7),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _primaryColor.withValues(alpha: 0.9),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      dividerTheme: DividerThemeData(
        space: 24,
        thickness: 1,
        color: _primaryColor.withValues(alpha: 0.2),
      ),
      scaffoldBackgroundColor: _darkBackgroundColor,
      chipTheme: ChipThemeData(
        backgroundColor: _primaryColor.withValues(alpha: 0.15),
        selectedColor: _primaryColor,
        labelStyle: const TextStyle(fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Builds the text theme configuration used by both light and dark themes.
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        height: 64 / 57,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w300,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        height: 52 / 45,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w300,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        height: 44 / 36,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 28,
        height: 36 / 28,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: 22,
        height: 30 / 22,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        height: 26 / 18,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.15,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        height: 26 / 18,
        letterSpacing: 0.1,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.1,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        height: 40 / 32,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        height: 36 / 28,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        height: 32 / 24,
        letterSpacing: -0.25,
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
