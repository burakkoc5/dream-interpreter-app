import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteGuard {
  static String? guard(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthCubit>().state;
    final hasCompletedOnboarding =
        context.read<OnboardingCubit>().isOnboardingComplete;

    final location = state.uri.toString();

    debugPrint('RouteGuard - hasCompletedOnboarding: $hasCompletedOnboarding');
    debugPrint('RouteGuard - isAuthenticated: ${authState.isAuthenticated}');
    debugPrint('RouteGuard - isInitializing: ${authState.isInitializing}');
    debugPrint('RouteGuard - userId: ${authState.user?.id}');
    debugPrint('RouteGuard - location: $location');

    if (location == AppRoute.splash) {
      return null;
    }

    // If auth is initializing, stay on current route
    if (authState.isInitializing) {
      return null;
    }

    // If onboarding is not complete, redirect to onboarding
    // unless already on onboarding or splash screen
    if (!hasCompletedOnboarding &&
        location != AppRoute.onboarding &&
        location != AppRoute.splash) {
      return AppRoute.onboarding;
    }

    // Handle authentication redirects
    if (!authState.isAuthenticated &&
        location != AppRoute.login &&
        location != AppRoute.register &&
        location != AppRoute.onboarding &&
        location != AppRoute.passwordReset &&
        location != AppRoute.splash) {
      return AppRoute.login;
    }

    if (authState.isAuthenticated &&
        (location == AppRoute.login || location == AppRoute.register)) {
      return AppRoute.dreamEntry;
    }

    // Redirect root /home to /home/entry
    if (authState.isAuthenticated && location == '/home') {
      return AppRoute.dreamEntry;
    }

    return null;
  }
}
