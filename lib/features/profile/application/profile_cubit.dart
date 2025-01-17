import 'package:dream/features/profile/models/reminder_settings_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repositories/profile_repository.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileState());
  Future<void> loadProfile(String userId) async {
    print('ProfileCubit: Loading profile for user $userId');
    // Check if the cubit is still open before emitting state
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      await for (final profile in _repository.getProfile(userId)) {
        // Check if the cubit is still open before emitting state
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            profile: profile,
            error: null,
          ));
        }
      }
      print('ProfileCubit: Profile stream closed. Get profile successful');
    } catch (e) {
      // Check if the cubit is still open before emitting state
      if (!isClosed) {
        emit(state.copyWith(
          isLoading: false,
          error: 'Failed to load profile',
        ));
      }
    }
  }

  Future<void> updateDisplayName(String newName, String userId) async {
    // Check if the cubit is still open before emitting state
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      print('Right before updateDisplayName');
      await _repository.updateDisplayName(newName);
      print('ProfileCubit: Display name updated successfully');
      if (state.profile != null) {
        // Check if the cubit is still open before emitting state
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            profile: state.profile!.copyWith(displayName: newName),
          ));
        }
        loadProfile(
            userId); // This will again emit a new state, check isClosed before calling
      }
    } catch (e) {
      // Check if the cubit is still open before emitting state
      if (!isClosed) {
        emit(state.copyWith(
          isLoading: false,
          error: 'Failed to update display name',
        ));
      }
    }
  }

  // Future<void> loadProfile(String userId) async {
  //   emit(state.copyWith(isLoading: true, error: null));

  //   try {
  //     await for (final profile in _repository.getProfile(userId)) {
  //       emit(state.copyWith(
  //         isLoading: false,
  //         profile: profile,
  //         error: null,
  //       ));
  //     }
  //     print('ProfileCubit: Profile stream closed. Get profile successful');
  //   } catch (e) {
  //     emit(state.copyWith(
  //       isLoading: false,
  //       error: 'Failed to load profile',
  //     ));
  //   }
  // }

  // Future<void> updateDisplayName(String newName, String userId) async {
  //   emit(state.copyWith(isLoading: true, error: null));

  //   try {
  //     print('Right before updateDisplayName');
  //     await _repository.updateDisplayName(newName);
  //     print('ProfileCubit: Display name updated successfully');
  //     if (state.profile != null) {
  //       emit(state.copyWith(
  //         isLoading: false,
  //         profile: state.profile!.copyWith(displayName: newName),
  //       ));
  //       loadProfile(userId);
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(
  //       isLoading: false,
  //       error: 'Failed to update display name',
  //     ));
  //   }
  // }

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

  Future<void> updateReminders(ReminderSettings settings) async {
    print('ProfileCubit: Updating reminder settings');
    print(state.profile);
    if (state.profile == null) return;

    try {
      final updatedPreferences =
          Map<String, dynamic>.from(state.profile!.preferences);
      updatedPreferences['reminderSettings'] = settings.toJson();

      print(updatedPreferences);

      await _repository.updateProfilePreferences({
        'preferences': updatedPreferences,
        'notificationsEnabled': true,
      });

      final updatedProfile = state.profile!.copyWith(
        preferences: updatedPreferences,
        notificationsEnabled: true,
      );

      emit(state.copyWith(profile: updatedProfile));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update reminder settings',
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

  Future<void> updateProfilePreferences(Map<String, dynamic> data) async {
    if (state.profile == null) return;

    try {
      await _repository.updateProfilePreferences(data);
      final updatedProfile = state.profile!.copyWith(
        preferences: (data['preferences'] as Map<String, dynamic>?) ??
            state.profile!.preferences,
      );
      emit(state.copyWith(profile: updatedProfile));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update preferences',
      ));
    }
  }
}
