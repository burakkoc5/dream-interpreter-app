import 'dart:async';
import 'package:dream/features/profile/models/reminder_settings_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../repositories/profile_repository.dart';
import '../models/profile_model.dart';
import 'profile_state.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/shared/repositories/notification_repository.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;
  final AuthCubit _authCubit;
  final NotificationRepository _notificationRepository;
  StreamSubscription<Profile>? _profileSubscription;
  StreamSubscription? _authSubscription;

  ProfileCubit(this._repository, this._authCubit, this._notificationRepository)
      : super(const ProfileState()) {
    // Listen to auth state changes
    _authSubscription = _authCubit.stream.listen((authState) {
      if (authState.user != null && authState.user!.emailVerified) {
        _loadProfile(authState.user!.id);
      } else {
        // Cancel existing subscription and clear state when user is not authenticated
        // or email is not verified
        _profileSubscription?.cancel();
        _profileSubscription = null;
        emit(const ProfileState());
      }
    });

    // Load initial profile if user is already logged in and verified
    if (_authCubit.state.user != null && _authCubit.state.user!.emailVerified) {
      _loadProfile(_authCubit.state.user!.id);
    }
  }

  Future<void> _loadProfile(String userId) async {
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
          if (!isClosed) {
            if (error.toString().contains('Profile not found')) {
              final user = _authCubit.state.user;
              if (user != null) {
                _repository.createInitialProfile(
                  userId: user.id,
                  email: user.email,
                );
              }
            } else if (_authCubit.state.user == null ||
                !_authCubit.state.user!.emailVerified) {
              emit(const ProfileState());
            } else {
              emit(state.copyWith(
                isLoading: false,
                error: 'Failed to load profile',
              ));
            }
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        if (_authCubit.state.user == null ||
            !_authCubit.state.user!.emailVerified) {
          emit(const ProfileState());
        } else {
          emit(state.copyWith(
            isLoading: false,
            error: 'Failed to load profile',
          ));
        }
      }
    }
  }

  void _reset() async {
    await _profileSubscription?.cancel();
    _profileSubscription = null;
    if (!isClosed) {
      emit(const ProfileState());
    }
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    await _profileSubscription?.cancel();
    return super.close();
  }

  Future<void> updateDisplayName(String newName) async {
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      await _repository.updateDisplayName(newName);
      if (state.profile != null) {
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            profile: state.profile!.copyWith(displayName: newName),
          ));
        }
      }
    } catch (e) {
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
      if (!enabled) {
        // If notifications are being disabled, cancel all reminders
        await _notificationRepository.cancelAllReminders();
      }

      final updatedProfile = state.profile!.copyWith(
        notificationsEnabled: enabled,
      );
      await _repository.updateProfile(updatedProfile);
      emit(state.copyWith(profile: updatedProfile));

      // If notifications are being enabled and there are reminder settings, reschedule them
      if (enabled) {
        final reminderSettings = state.profile?.preferences['reminderSettings'];
        if (reminderSettings != null) {
          final settings = ReminderSettings.fromJson(
              reminderSettings as Map<String, dynamic>);
          await _notificationRepository.scheduleDreamReminder(
            time: settings.time,
          );
        }
      }
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update notifications',
      ));
    }
  }

  Future<void> updateReminders(ReminderSettings settings) async {
    if (state.profile == null) return;

    try {
      // Check if system notifications are enabled
      final systemNotificationsEnabled =
          await _notificationRepository.isSystemNotificationsEnabled();

      if (!systemNotificationsEnabled) {
        // If system notifications are disabled, update the profile to reflect this
        final updatedProfile = state.profile!.copyWith(
          notificationsEnabled: false,
        );
        await _repository.updateProfile(updatedProfile);
        emit(state.copyWith(
          profile: updatedProfile,
          error: 'Please enable notifications in system settings',
        ));
        return;
      }

      final updatedPreferences =
          Map<String, dynamic>.from(state.profile!.preferences);
      updatedPreferences['reminderSettings'] = settings.toJson();

      await _repository.updateProfilePreferences({
        'preferences': updatedPreferences,
        'notificationsEnabled': true,
      });

      final updatedProfile = state.profile!.copyWith(
        preferences: updatedPreferences,
        notificationsEnabled: true,
      );

      emit(state.copyWith(profile: updatedProfile));

      // Schedule the notification
      await _notificationRepository.scheduleDreamReminder(
        time: settings.time,
      );
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
    if (state.profile == null) {
      final user = _authCubit.state.user;
      if (user != null) {
        await _loadProfile(user.id);
        await Future.delayed(const Duration(milliseconds: 500));
      }
      if (state.profile == null) {
        emit(state.copyWith(
            error: 'Failed to update preferences: Profile not loaded'));
        return;
      }
    }

    try {
      await _repository.updateProfilePreferences(data);

      final updatedProfile = state.profile!.copyWith(
        preferences: (data['preferences'] as Map<String, dynamic>?) ??
            state.profile!.preferences,
      );
      emit(state.copyWith(profile: updatedProfile, error: null));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update preferences: ${e.toString()}',
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
    try {
      if (state.profile == null) {
        final user = _authCubit.state.user;
        if (user == null) throw Exception('User not authenticated');

        final now = DateTime.now();
        final newProfile = Profile(
          userId: user.id,
          email: user.email,
          createdAt: now,
          lastActive: now,
          gender: gender,
          horoscope: horoscope,
          occupation: occupation,
          relationshipStatus: relationshipStatus,
          birthDate: birthDate,
          interests: interests ?? [],
          hasCompletedPersonalization: hasCompletedPersonalization ?? false,
        );

        await _repository.updateProfile(newProfile);
        emit(state.copyWith(profile: newProfile));
        return;
      }

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
      emit(state.copyWith(profile: updatedProfile));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update personal information',
      ));
    }
  }

  void reset() {
    _reset();
  }
}
