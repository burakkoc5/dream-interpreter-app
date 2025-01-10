/// Defines the route names used throughout the app.
abstract class AppRoute {
  // Splash route
  static const splash = '/splash';

  // Onboarding routes
  static const onboarding = '/onboarding';

  // Root route
  static const root = '/auth';

  // Reminder settings
  static const reminderSettings = '/reminder-settings';

  // Auth routes
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const passwordReset = '/auth/password-reset';
  static const changePassword = '/auth/change-password';

  // Main navigation routes
  static const dreamEntry = '/home/entry';
  static const dreamHistory = '/home/dreams';
  static const profile = '/home/profile';

  // Detail routes
  static const dreamDetail = '/dream-detail';
  static const dreamInterpretation = '/dream-interpretation';
}
