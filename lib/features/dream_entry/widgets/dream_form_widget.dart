import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:dream/shared/services/ad_helper.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DreamFormWidget extends StatefulWidget {
  const DreamFormWidget({super.key});

  @override
  State<DreamFormWidget> createState() => _DreamFormWidgetState();
}

class _DreamFormWidgetState extends State<DreamFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  static const int maxContentLength = 1000;
  RewardedAd? _rewardedAd;
  bool _isLoadingAd = false;

  @override
  void initState() {
    super.initState();
    _checkAndPreloadAd();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  void _checkAndPreloadAd() {
    final profile = context.read<ProfileCubit>().state.profile;
    if (profile != null && profile.remainingDailyAttempts == 1) {
      debugPrint('One attempt remaining, preloading ad...');
      _loadRewardedAd();
    }
  }

  void _loadRewardedAd() {
    if (_isLoadingAd) return;

    debugPrint('Starting to load rewarded ad...');
    setState(() => _isLoadingAd = true);

    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('Rewarded ad loaded successfully');
          setState(() {
            _rewardedAd = ad;
            _isLoadingAd = false;
          });
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to load rewarded ad: ${error.message}');
          setState(() => _isLoadingAd = false);
        },
      ),
    );
  }

  Future<bool> _showRewardedAd() async {
    if (_rewardedAd == null) {
      debugPrint('Cannot show rewarded ad: ad is null');
      return false;
    }

    try {
      debugPrint('Attempting to show rewarded ad...');
      Completer<bool> adCompleter = Completer<bool>();

      await _rewardedAd?.show(
        onUserEarnedReward: (_, __) {
          debugPrint('User earned reward from ad');
          adCompleter.complete(true);
        },
      );

      _rewardedAd = null;
      final result = await adCompleter.future;
      debugPrint('Ad show result: $result');
      return result;
    } catch (e) {
      debugPrint('Error showing rewarded ad: $e');
      return false;
    }
  }

  Future<bool> _checkAndHandleAttempts() async {
    final profileCubit = context.read<ProfileCubit>();
    final profile = profileCubit.state.profile;

    if (profile == null) {
      debugPrint('Profile is null, cannot check attempts');
      return false;
    }

    // Reset attempts if it's a new day
    final now = DateTime.now();
    final lastReset = profile.lastAttemptsResetDate;
    debugPrint('Last reset date: $lastReset');
    debugPrint('Current remaining attempts: ${profile.remainingDailyAttempts}');

    if (lastReset == null || !_isSameDay(lastReset, now)) {
      debugPrint('Resetting daily attempts (new day)');
      await profileCubit.updateProfilePreferences({
        'remainingDailyAttempts': 2,
        'lastAttemptsResetDate': Timestamp.fromDate(now),
      });
      return true;
    }

    // Check remaining attempts
    if (profile.remainingDailyAttempts > 0) {
      debugPrint(
          'Using one attempt, ${profile.remainingDailyAttempts - 1} remaining');
      final newAttempts = profile.remainingDailyAttempts - 1;
      await profileCubit.updateProfilePreferences({
        'remainingDailyAttempts': newAttempts,
        'lastAttemptsResetDate': Timestamp.fromDate(lastReset),
      });

      // If this was the last attempt, preload ad for next time
      if (newAttempts == 1) {
        debugPrint('One attempt remaining after update, preloading ad...');
        _loadRewardedAd();
      }
      return true;
    }

    // No attempts left, show ad
    debugPrint('No attempts left, preparing to show ad');
    if (_rewardedAd == null) {
      debugPrint('No ad loaded, starting load process');
      _loadRewardedAd();

      // Wait for ad to load
      debugPrint('Waiting for ad to load...');
      while (_rewardedAd == null && mounted) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      if (_rewardedAd == null) {
        debugPrint('Failed to load ad after waiting');
        return false;
      }
      debugPrint('Ad loaded successfully after waiting');
    }

    final watchedAd = await _showRewardedAd();
    debugPrint('Ad watch result: $watchedAd');
    if (!watchedAd) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.dreamEntry.dreamForm.watchAdError)),
        );
      }
      return false;
    }

    return true;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.dreamEntry.dreamForm.record,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.dreamEntry.dreamForm.contentHint,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _contentController,
            maxLength: maxContentLength,
            maxLines: 12,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: t.dreamEntry.dreamForm.content,
              contentPadding: const EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: colorScheme.error,
                  width: 1.5,
                ),
              ),
              counterStyle: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return t.dreamEntry.dreamForm.contentHint;
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.auto_awesome, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    t.dreamEntry.dreamForm.getInterpretation,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '${t.dreamEntry.dreamForm.remainingAttempts}: ${context.select((ProfileCubit cubit) => cubit.state.profile?.remainingDailyAttempts ?? 0)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final canProceed = await _checkAndHandleAttempts();
      if (canProceed) {
        await _handleDreamInterpretation();
      }
    }
  }

  Future<void> _handleDreamInterpretation() async {
    final cubit = context.read<DreamEntryCubit>();
    await cubit.interpretDream(
      title: '',
      content: _contentController.text,
    );
  }
}
