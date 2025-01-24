import 'package:dream/core/presentation/main_screen.dart';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/core/routing/route_guard.dart';
import 'package:dream/features/auth/presentation/auth_check_screen.dart';
import 'package:dream/features/auth/presentation/change_password_screen.dart';
import 'package:dream/features/auth/presentation/login_screen.dart';
import 'package:dream/features/auth/presentation/password_reset_screen.dart';
import 'package:dream/features/auth/presentation/register_screen.dart';
import 'package:dream/features/dream_entry/presentation/dream_entry_screen.dart';
import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:dream/features/dream_history/presentation/dream_detail_screen.dart';
import 'package:dream/features/dream_history/presentation/dream_history_screen.dart';
import 'package:dream/features/onboarding/presentation/onboarding_screen.dart';
import 'package:dream/features/profile/presentation/personalization_screen.dart';
import 'package:dream/features/profile/presentation/profile_screen.dart';
import 'package:dream/features/profile/presentation/reminder_settings_screen.dart';
import 'package:dream/features/profile/presentation/settings_screen.dart';
import 'package:dream/features/splash/presentation/splash_screen.dart';
import 'package:dream/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeSlideTransitionPage extends CustomTransitionPage<void> {
  FadeSlideTransitionPage({
    required super.child,
    super.key,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.05);
            const end = Offset.zero;
            const curve = Curves.bounceIn;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            var offsetAnimation = animation.drive(tween);
            var fadeAnimation = animation.drive(
              Tween<double>(begin: 0.0, end: 1.0).chain(
                CurveTween(curve: curve),
              ),
            );

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
          maintainState: true,
          opaque: true,
        );
}

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          initialLocation: AppRoute.splash,
          redirect: RouteGuard.guard,
          navigatorKey: navigatorKey,
          routes: [
            // Root route with auth check
            GoRoute(
              path: AppRoute.root,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const AuthCheckScreen(),
              ),
            ),

            // Auth routes (outside shell)
            GoRoute(
              path: AppRoute.login,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const LoginScreen(),
              ),
            ),
            GoRoute(
              path: AppRoute.register,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const RegisterScreen(),
              ),
            ),
            GoRoute(
              path: AppRoute.passwordReset,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const PasswordResetScreen(),
              ),
            ),
            GoRoute(
              path: AppRoute.changePassword,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const ChangePasswordScreen(),
              ),
            ),

            // Main navigation shell
            ShellRoute(
              builder: (context, state, child) => MainScreen(child: child),
              routes: [
                GoRoute(
                  path: AppRoute.dreamEntry,
                  pageBuilder: (context, state) => FadeSlideTransitionPage(
                    child: const DreamEntryScreen(),
                  ),
                ),
                GoRoute(
                  path: AppRoute.dreamHistory,
                  pageBuilder: (context, state) => FadeSlideTransitionPage(
                    child: const DreamHistoryScreen(),
                  ),
                ),
                GoRoute(
                  path: AppRoute.profile,
                  pageBuilder: (context, state) => FadeSlideTransitionPage(
                    child: const ProfileScreen(),
                  ),
                ),
              ],
            ),

            // Detail routes (outside shell)

            GoRoute(
              path: AppRoute.dreamDetail,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: DreamDetailScreen(
                  dream: state.extra as DreamHistoryModel,
                ),
              ),
            ),
            GoRoute(
              path: AppRoute.splash,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const SplashScreen(),
              ),
            ),

            // Onboarding route
            GoRoute(
              path: AppRoute.onboarding,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const OnboardingScreen(),
              ),
            ),
            GoRoute(
              path: AppRoute.reminderSettings,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const ReminderSettingsScreen(),
              ),
            ),

            // Personalization route
            GoRoute(
              path: AppRoute.personalization,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const PersonalizationScreen(),
              ),
            ),
            GoRoute(
              path: AppRoute.settings,
              pageBuilder: (context, state) => FadeSlideTransitionPage(
                child: const SettingsScreen(),
              ),
            ),
          ],
        );
}
