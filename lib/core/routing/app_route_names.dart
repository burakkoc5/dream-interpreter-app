/// Defines the route names used throughout the app.
abstract class AppRoute {
  // Splash route
  static const splash = '/splash';

  // Onboarding routes
  static const onboarding = '/onboarding';

  // Root route
  static const root = '/';

  // Reminder settings
  static const reminderSettings = '/reminder-settings';

  // Auth routes
  static const login = '/login';
  static const register = '/register';
  static const passwordReset = '/password-reset';
  static const changePassword = '/change-password';

  // Main navigation routes
  static const home = '/home';
  static const dreamEntry = '/dream-entry';
  static const dreamHistory = '/dream-history';
  static const profile = '/profile';

  // Detail routes
  static const dreamDetail = '/dream-detail';
  static const dreamInterpretation = '/dream-interpretation';

  // New personalization route
  static const personalization = '/personalization';
  static const settings = '/settings';
}
