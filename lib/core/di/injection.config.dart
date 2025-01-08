// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../config/theme/theme_cubit.dart' as _i223;
import '../../features/auth/application/auth_cubit.dart' as _i877;
import '../../features/auth/repositories/auth_repository.dart' as _i1041;
import '../../features/auth/services/firebase_auth_service.dart' as _i38;
import '../../features/dream_entry/application/dream_entry_cubit.dart' as _i234;
import '../../features/dream_entry/repositories/dream_repository.dart'
    as _i1046;
import '../../features/dream_entry/repositories/firebase_dream_repository.dart'
    as _i235;
import '../../features/dream_entry/services/interpretation_service.dart'
    as _i947;
import '../../features/dream_entry/services/local_storage_service.dart'
    as _i567;
import '../../features/dream_entry/services/openai_service.dart' as _i342;
import '../../features/dream_history/application/dream_history_cubit.dart'
    as _i127;
import '../../features/dream_history/repositories/dream_history_repository.dart'
    as _i386;
import '../../features/profile/application/profile_cubit.dart' as _i402;
import '../../features/profile/application/stats_cubit.dart' as _i382;
import '../../features/profile/repositories/profile_repository.dart' as _i155;
import '../../features/profile/repositories/stats_repository.dart' as _i733;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i342.OpenAIService>(() => _i342.OpenAIService());
  await gh.singletonAsync<_i460.SharedPreferences>(
    () => registerModule.sharedPreferences,
    preResolve: true,
  );
  gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.singleton<_i974.FirebaseFirestore>(() => registerModule.firebaseFirestore);
  gh.singleton<_i567.LocalStorageService>(
      () => _i567.LocalStorageService(gh<_i460.SharedPreferences>()));
  gh.factory<_i223.ThemeCubit>(
      () => _i223.ThemeCubit(gh<_i460.SharedPreferences>()));
  gh.factory<_i386.DreamHistoryRepository>(
      () => _i386.DreamHistoryRepository(gh<_i974.FirebaseFirestore>()));
  gh.factory<_i733.StatsRepository>(
      () => _i733.StatsRepository(gh<_i974.FirebaseFirestore>()));
  gh.factory<_i155.ProfileRepository>(
      () => _i155.ProfileRepository(gh<_i974.FirebaseFirestore>()));
  gh.factory<_i38.FirebaseAuthService>(() => _i38.FirebaseAuthService(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ));
  gh.singleton<_i947.InterpretationService>(
      () => _i947.InterpretationService(gh<_i342.OpenAIService>()));
  gh.factory<_i1046.DreamRepository>(
      () => _i235.FirebaseDreamRepository(gh<_i974.FirebaseFirestore>()));
  gh.factory<_i382.StatsCubit>(
      () => _i382.StatsCubit(gh<_i733.StatsRepository>()));
  gh.factory<_i1041.AuthRepository>(
      () => _i1041.AuthRepository(gh<_i38.FirebaseAuthService>()));
  gh.factory<_i402.ProfileCubit>(
      () => _i402.ProfileCubit(gh<_i155.ProfileRepository>()));
  gh.factory<_i877.AuthCubit>(
      () => _i877.AuthCubit(gh<_i1041.AuthRepository>()));
  gh.factory<_i234.DreamEntryCubit>(() => _i234.DreamEntryCubit(
        gh<_i947.InterpretationService>(),
        gh<_i567.LocalStorageService>(),
        gh<_i877.AuthCubit>(),
      ));
  gh.factory<_i127.DreamHistoryCubit>(() => _i127.DreamHistoryCubit(
        gh<_i386.DreamHistoryRepository>(),
        gh<_i877.AuthCubit>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i464.RegisterModule {}
