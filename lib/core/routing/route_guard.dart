import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteGuard {
  static String? guard(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthCubit>().state;
    final profileState = context.read<ProfileCubit>().state;
    final hasCompletedOnboarding =
        context.read<OnboardingCubit>().isOnboardingComplete;

    // Allow access to splash screen
    if (state.matchedLocation == AppRoute.splash) {
      return null;
    }

    // If initializing, stay on current page
    if (authState.isInitializing) {
      return null;
    }

    if (!hasCompletedOnboarding &&
        state.matchedLocation != AppRoute.onboarding &&
        state.matchedLocation != AppRoute.splash) {
      return AppRoute.onboarding;
    }

    // If not authenticated, only allow access to auth routes
    if (authState.user == null) {
      final isAuthRoute = [
        AppRoute.login,
        AppRoute.register,
        AppRoute.passwordReset,
        AppRoute.onboarding,
        AppRoute.splash,
      ].contains(state.matchedLocation);

      if (isAuthRoute) {
        return null;
      }
      return AppRoute.login;
    }

    // If authenticated but profile not loaded, wait
    if (profileState.isLoading) {
      return null;
    }

    // If profile exists but personalization not completed, redirect to personalization
    if (profileState.profile != null) {
      if (!profileState.profile!.hasCompletedPersonalization &&
          state.matchedLocation != AppRoute.personalization) {
        return AppRoute.personalization;
      }
    }

    // If on auth route while authenticated, redirect to home
    final isAuthRoute = [
      AppRoute.login,
      AppRoute.register,
      AppRoute.passwordReset,
    ].contains(state.matchedLocation);

    if (isAuthRoute) {
      return AppRoute.dreamEntry;
    }

    return null;
  }
}
