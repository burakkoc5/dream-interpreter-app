import 'package:flutter/material.dart';

/// AppTheme defines the application's theme configuration including colors,
/// typography, and other Material Design attributes for both light and dark modes.
class AppTheme {
  static const _primaryColor = Color(0xFF6750A4);
  static const _secondaryColor = Color(0xFF958DA5);
  static const _tertiaryColor = Color(0xFFB58392);
  static const _errorColor = Color(0xFFB3261E);

  /// Creates the light theme configuration for the application.
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _tertiaryColor,
        error: _errorColor,
        surface: Color(0xFFFFFBFE),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onError: Colors.white,
        onSurface: Color(0xFF1C1B1F),
      ),
      textTheme: _buildTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        space: 16,
        thickness: 1,
      ),
    );
  }

  /// Creates the dark theme configuration for the application.
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _tertiaryColor,
        error: _errorColor,
        surface: Color(0xFF1C1B1F),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onError: Colors.white,
        onSurface: Color(0xFFE6E1E5),
      ),
      textTheme: _buildTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        space: 16,
        thickness: 1,
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
        fontFamily: 'Roboto',
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        height: 52 / 45,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      displaySmall: TextStyle(
        fontSize: 34,
        height: 40 / 34,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        height: 32 / 24,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        height: 28 / 20,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        height: 32 / 24,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        height: 28 / 20,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: -0.25,
        fontFamily: 'Roboto',
      ),
    );
  }
}
