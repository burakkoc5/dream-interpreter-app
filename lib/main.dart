import 'package:dream/config/theme/theme.dart';
import 'package:dream/config/theme/theme_cubit.dart';
import 'package:dream/config/language/language_cubit.dart';
import 'package:dream/core/di/injection.dart';
import 'package:dream/core/routing/app_router.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/application/stats_cubit.dart';
import 'package:dream/firebase_options.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/repositories/notification_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await configureDependencies();

  // Initialize notifications
  final notificationRepository = getIt<NotificationRepository>();
  await notificationRepository.initialize();

  // Initialize localization with stored preference
  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString('appLanguage');
  if (savedLanguage != null) {
    LocaleSettings.setLocale(AppLocale.values.firstWhere(
      (locale) => locale.languageCode == savedLanguage,
      orElse: () => AppLocale.en,
    ));
  } else {
    LocaleSettings.setLocale(AppLocale.en);
  }

  runApp(
    TranslationProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = AppRouter().router;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NotificationRepository>(
          create: (_) => getIt<NotificationRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<OnboardingCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<ThemeCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<LanguageCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<StatsCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<DreamEntryCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<DreamHistoryCubit>(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: t.core.appName,
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              themeMode: context.watch<ThemeCubit>().state,
              routerConfig: _router,
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales:
                  AppLocale.values.map((locale) => locale.flutterLocale),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
