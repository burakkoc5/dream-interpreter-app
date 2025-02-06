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
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dream/core/error/error_boundary.dart';
import 'package:dream/core/services/logging_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void configureDebugPrints() {
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message?.contains('MESA') ?? false) return;
    debugPrintSynchronously(message ?? '', wrapWidth: wrapWidth);
  };
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void configureCrashlytics() {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Future<void> handleFirstInstall() async {
  final prefs = await SharedPreferences.getInstance();
  final hasRunBefore = prefs.getBool('has_run_before') ?? false;

  if (!hasRunBefore) {
    await FirebaseAuth.instance.signOut();
    await prefs.setBool('has_run_before', true);
  }
}

Future<void> initializeLocalization() async {
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
}

Future<void> initializeApp() async {
  try {
    try {
      await dotenv.load(fileName: ".env");
      debugPrint('✓ Environment variables loaded');
    } catch (e) {
      debugPrint('❌ Failed to load environment variables: $e');
      // Continue even if .env fails - we have fallback values
    }

    try {
      WidgetsFlutterBinding.ensureInitialized();
      debugPrint('✓ Flutter binding initialized');
    } catch (e) {
      debugPrint('❌ Failed to initialize Flutter binding: $e');
      rethrow;
    }

    try {
      await MobileAds.instance.initialize();
      debugPrint('✓ Mobile ads initialized');
    } catch (e) {
      debugPrint('❌ Failed to initialize Mobile Ads: $e');
      // Continue even if ads fail
    }

    try {
      await initializeFirebase();
      debugPrint('✓ Firebase initialized');
    } catch (e) {
      debugPrint('❌ Failed to initialize Firebase: $e');
      rethrow;
    }

    try {
      configureCrashlytics();
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
      debugPrint('✓ Crashlytics configured');
    } catch (e) {
      debugPrint('❌ Failed to configure Crashlytics: $e');
      // Continue even if Crashlytics fails
    }

    try {
      await configureDependencies();
      debugPrint('✓ Dependencies configured');
    } catch (e) {
      debugPrint('❌ Failed to configure dependencies: $e');
      rethrow;
    }

    try {
      await handleFirstInstall();
      debugPrint('✓ First install handled');
    } catch (e) {
      debugPrint('❌ Failed to handle first install: $e');
      // Continue even if first install handling fails
    }

    try {
      final notificationRepository = getIt<NotificationRepository>();
      await notificationRepository.initialize();
      debugPrint('✓ Notifications initialized');
    } catch (e) {
      debugPrint('❌ Failed to initialize notifications: $e');
      // Continue even if notifications fail
    }

    try {
      await initializeLocalization();
      debugPrint('✓ Localization initialized');
    } catch (e) {
      debugPrint('❌ Failed to initialize localization: $e');
      // Continue even if localization fails
    }
  } catch (e, stack) {
    debugPrint('❌ Fatal error during initialization: $e');
    if (!kDebugMode) {
      await FirebaseCrashlytics.instance.recordError(e, stack);
    }
    rethrow;
  }
}

void main() async {
  try {
    configureDebugPrints();
    await initializeApp();

    runApp(
      TranslationProvider(
        child: ErrorBoundary(
          child: MyApp(),
        ),
      ),
    );
  } catch (e, stack) {
    debugPrint('Fatal error during app startup: $e');
    if (!kDebugMode) {
      await FirebaseCrashlytics.instance.recordError(e, stack);
    }
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Failed to start the app',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (kDebugMode) ...[
                    SizedBox(height: 8),
                    Text(
                      e.toString(),
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      main();
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = AppRouter().router;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoggingService>(
          create: (_) => getIt<LoggingService>(),
        ),
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
