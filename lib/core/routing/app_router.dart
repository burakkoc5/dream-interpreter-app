import 'package:dream/core/presentation/main_screen.dart';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/core/routing/route_guard.dart';
import 'package:dream/features/auth/presentation/auth_check_screen.dart';
import 'package:dream/features/auth/presentation/change_password_screen.dart';
import 'package:dream/features/auth/presentation/login_screen.dart';
import 'package:dream/features/auth/presentation/password_reset_screen.dart';
import 'package:dream/features/auth/presentation/register_screen.dart';
import 'package:dream/features/dream_entry/models/dream_entry_model.dart';
import 'package:dream/features/dream_entry/presentation/dream_entry_screen.dart';
import 'package:dream/features/dream_entry/presentation/interpretation_screen.dart';
import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:dream/features/dream_history/presentation/dream_detail_screen.dart';
import 'package:dream/features/dream_history/presentation/dream_history_screen.dart';
import 'package:dream/features/profile/presentation/profile_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          redirect: RouteGuard.guard,
          routes: [
            // Root route with auth check
            GoRoute(
              path: AppRoute.root,
              builder: (context, state) => const AuthCheckScreen(),
            ),

            // Auth routes (outside shell)
            GoRoute(
              path: AppRoute.login,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: AppRoute.register,
              builder: (context, state) => const RegisterScreen(),
            ),
            GoRoute(
              path: AppRoute.passwordReset,
              builder: (context, state) => const PasswordResetScreen(),
            ),
            GoRoute(
              path: AppRoute.changePassword,
              builder: (context, state) => const ChangePasswordScreen(),
            ),

            // Main navigation shell
            ShellRoute(
              builder: (context, state, child) => MainScreen(child: child),
              routes: [
                GoRoute(
                  path: AppRoute.dreamEntry,
                  builder: (context, state) => const DreamEntryScreen(),
                ),
                GoRoute(
                  path: AppRoute.dreamHistory,
                  builder: (context, state) => const DreamHistoryScreen(),
                ),
                GoRoute(
                  path: AppRoute.profile,
                  builder: (context, state) => const ProfileScreen(),
                ),
              ],
            ),

            // Detail routes (outside shell)
            GoRoute(
              path: AppRoute.dreamInterpretation,
              builder: (context, state) => InterpretationScreen(
                dreamEntry: state.extra as DreamEntry,
              ),
            ),
            GoRoute(
              path: AppRoute.dreamDetail,
              builder: (context, state) => DreamDetailScreen(
                dream: state.extra as DreamHistoryModel,
              ),
            ),
          ],
        );
}
