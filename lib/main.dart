import 'package:dream/config/theme/theme.dart';
import 'package:dream/config/theme/theme_cubit.dart';
import 'package:dream/core/di/injection.dart';
import 'package:dream/core/routing/app_router.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/firebase_options.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await configureDependencies();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = AppRouter().router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider<DreamEntryCubit>(
          create: (context) => getIt<DreamEntryCubit>(),
        ),
        BlocProvider<DreamHistoryCubit>(
          create: (context) => getIt<DreamHistoryCubit>(),
        ),
        BlocProvider<OnboardingCubit>(
          create: (context) => getIt<OnboardingCubit>(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => getIt<ProfileCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp.router(
            title: t.core.appName,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
