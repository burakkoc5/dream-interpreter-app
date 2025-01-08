// 1. Authentication
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/core/di/injection.config.dart';

// 2. Dream Entry

// 3. Dream History

// 4. Profile

// 5. Third-party services
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async {
  // First, initialize the generated dependencies
  await init(getIt);
  // Third-party services
  // getIt.registerSingletonAsync<SharedPreferences>(
  //   () => SharedPreferences.getInstance(),
  // );

  // Register Firebase services
  // getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  // getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // Auth Feature
  // getIt.registerSingleton<FirebaseAuthService>(
  //   FirebaseAuthService(getIt<FirebaseAuth>(), getIt<FirebaseFirestore>()),
  // );

  // getIt.registerSingleton<AuthRepository>(
  //   AuthRepository(getIt<FirebaseAuthService>()),
  // );

  // getIt.registerFactory<AuthCubit>(
  //   () => AuthCubit(getIt<AuthRepository>()),
  // );

  // // Dream Entry Feature
  // getIt.registerSingleton<OpenAIService>(OpenAIService());

  // getIt.registerSingleton<InterpretationService>(
  //   InterpretationService(getIt<OpenAIService>()),
  // );

  // getIt.registerSingletonAsync<LocalStorageService>(
  //   () async => LocalStorageService(await getIt.getAsync<SharedPreferences>()),
  // );

  // // Register Firebase repositories
  // getIt.registerSingleton<DreamRepository>(
  //   FirebaseDreamRepository(getIt<FirebaseFirestore>()),
  // );

  // // Dream Entry Cubit
  // getIt.registerFactory<DreamEntryCubit>(
  //   () => DreamEntryCubit(
  //     getIt<InterpretationService>(),
  //     getIt<LocalStorageService>(),
  //   ),
  // );

  // // Dream History Feature
  // getIt.registerSingleton<DreamHistoryRepository>(
  //   DreamHistoryRepository(getIt<FirebaseFirestore>()),
  // );

  // getIt.registerFactory<DreamHistoryCubit>(
  //   () => DreamHistoryCubit(
  //     getIt<DreamHistoryRepository>(),
  //     getIt<AuthCubit>(),
  //   ),
  // );

  // // Profile Feature
  // getIt.registerSingleton<ProfileRepository>(
  //   ProfileRepository(getIt<FirebaseFirestore>()),
  // );

  // getIt.registerSingleton<StatsRepository>(
  //   StatsRepository(getIt<FirebaseFirestore>()),
  // );

  // getIt.registerFactory<ProfileCubit>(
  //   () => ProfileCubit(getIt<ProfileRepository>()),
  // );

  // getIt.registerFactory<StatsCubit>(
  //   () => StatsCubit(getIt<StatsRepository>()),
  // );

  // getIt.registerSingletonAsync<ThemeCubit>(
  //   () async => ThemeCubit(await getIt.getAsync<SharedPreferences>()),
  // );
  // Wait for all async dependencies to be ready before using them
  await getIt.allReady();
}

@module
abstract class RegisterModule {
  @preResolve // Mark for pre-resolution
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @singleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
}
