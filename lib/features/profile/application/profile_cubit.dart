import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repositories/profile_repository.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileState());

  Future<void> loadProfile(String userId) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await for (final profile in _repository.getProfile(userId)) {
        emit(state.copyWith(
          isLoading: false,
          profile: profile,
          error: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load profile',
      ));
    }
  }

  Future<void> updateDisplayName(String newName, String userId) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await _repository.updateDisplayName(newName);
      if (state.profile != null) {
        emit(state.copyWith(
          isLoading: false,
          profile: state.profile!.copyWith(displayName: newName),
        ));
        loadProfile(userId);
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to update display name',
      ));
    }
  }

  Future<void> updateNotifications(bool enabled) async {
    if (state.profile == null) return;

    try {
      final updatedProfile = state.profile!.copyWith(
        notificationsEnabled: enabled,
      );
      await _repository.updateProfile(updatedProfile);
      emit(state.copyWith(profile: updatedProfile));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update notifications',
      ));
    }
  }

  Future<void> updateProfilePhoto(String photoUrl) async {
    if (state.profile == null) return;

    try {
      final updatedProfile = state.profile!.copyWith(photoUrl: photoUrl);
      await _repository.updateProfile(updatedProfile);
      emit(state.copyWith(profile: updatedProfile));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update profile photo',
      ));
    }
  }
}
