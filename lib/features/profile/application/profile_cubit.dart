import 'dart:async';
import 'package:dream/features/profile/models/reminder_settings_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repositories/profile_repository.dart';
import '../models/profile_model.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;
  StreamSubscription<Profile>? _profileSubscription;

  ProfileCubit(this._repository) : super(const ProfileState());

  Future<void> loadProfile(String userId) async {
    print('ProfileCubit: Loading profile for user $userId');
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      await _profileSubscription?.cancel();
      _profileSubscription = _repository.getProfile(userId).listen(
        (profile) {
          if (!isClosed) {
            emit(state.copyWith(
              isLoading: false,
              profile: profile,
              error: null,
            ));
          }
        },
        onError: (error) {
          print('ProfileCubit: Error loading profile: $error');
          // Only emit error if we don't have a profile yet
          if (!isClosed && state.profile == null) {
            emit(state.copyWith(
              isLoading: false,
              error: 'Failed to load profile',
            ));
          }
        },
      );
    } catch (e) {
      print('ProfileCubit: Exception in loadProfile: $e');
      // Only emit error if we don't have a profile yet
      if (!isClosed && state.profile == null) {
        emit(state.copyWith(
          isLoading: false,
          error: 'Failed to load profile',
        ));
      }
    }
  }

  @override
  Future<void> close() async {
    await _profileSubscription?.cancel();
    return super.close();
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

  Future<void> updatePersonalInfo({
    String? gender,
    String? horoscope,
    String? occupation,
    String? relationshipStatus,
    DateTime? birthDate,
    List<String>? interests,
    bool? hasCompletedPersonalization,
  }) async {
    print('ProfileCubit: Updating personal information');

    if (state.profile == null) return;
    try {
      final updatedProfile = state.profile!.copyWith(
        gender: gender,
        horoscope: horoscope,
        occupation: occupation,
        relationshipStatus: relationshipStatus,
        birthDate: birthDate,
        interests: interests ?? [],
        hasCompletedPersonalization: hasCompletedPersonalization ?? false,
      );

      await _repository.updateProfile(updatedProfile);
      print('ProfileCubit: Updated profile: ${updatedProfile.toJson()}');
      emit(state.copyWith(profile: updatedProfile));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update personal information',
      ));
    }
  }
}
