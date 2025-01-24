import 'package:dream/core/di/injection.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/features/profile/repository/streak_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../services/interpretation_service.dart';
import '../services/local_storage_service.dart';
import 'dream_entry_state.dart';
import '../models/dream_entry_model.dart';

@injectable
class DreamEntryCubit extends Cubit<DreamEntryState> {
  final InterpretationService _interpretationService;
  final LocalStorageService _localStorageService;
  final AuthCubit _authCubit;
  final StreakRepository _streakRepository;

  DreamEntryCubit(
      this._interpretationService, this._localStorageService, this._authCubit)
      : _streakRepository = getIt<StreakRepository>(),
        super(const DreamEntryState.initial());

  Future<void> interpretDream({
    required String title,
    required String content,
  }) async {
    emit(const DreamEntryState.loading());

    try {
      final interpretation =
          await _interpretationService.interpretDream(content);

      final userId = _authCubit.state.user?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final dreamEntry = DreamEntry(
        id: const Uuid().v4(),
        userId: userId,
        title: title,
        content: content,
        interpretation: interpretation,
        createdAt: DateTime.now(),
        tags: [],
        moodRating: 0,
      );

      // Save as draft
      await _localStorageService.saveDraft(dreamEntry);

      // Update streak after successful dream entry
      await _streakRepository.updateStreak(userId);

      emit(DreamEntryState.success(dreamEntry));
    } catch (e) {
      emit(DreamEntryState.error(e.toString()));
    }
  }

  Future<void> saveDream(DreamEntry dream) async {
    try {
      // First save to cloud
      await _interpretationService.saveDream(dream);

      // Update the user's streak
      await _streakRepository.updateStreak(dream.userId);

      // Clear the draft after successful save
      await _localStorageService.clearDraft();

      // Update state with saved dream
      emit(DreamEntryState.success(dream));
    } catch (e) {
      emit(DreamEntryState.error('Failed to save dream: $e'));
      rethrow; // Rethrow to handle in UI
    }
  }

  void reset() {
    emit(const DreamEntryState.initial());
  }
}
