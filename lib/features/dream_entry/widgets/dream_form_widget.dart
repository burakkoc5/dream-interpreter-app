import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:dream/shared/services/ad_helper.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'dart:async';

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
  void dispose() {
    _contentController.dispose();
    _rewardedAd?.dispose();
    super.dispose();
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
        'preferences': profile.preferences,
        'remainingDailyAttempts': 2,
        'lastAttemptsResetDate': now,
      });
      return true;
    }

    // Check remaining attempts
    if (profile.remainingDailyAttempts > 0) {
      debugPrint(
          'Using one attempt, ${profile.remainingDailyAttempts - 1} remaining');
      await profileCubit.updateProfilePreferences({
        'preferences': profile.preferences,
        'remainingDailyAttempts': profile.remainingDailyAttempts - 1,
      });
      return true;
    }

    // No attempts left, load and show ad
    debugPrint('No attempts left, preparing to show ad');
    if (_rewardedAd == null) {
      debugPrint('No ad loaded, starting load process');
      final completer = Completer<void>();

      _loadRewardedAd();

      // Wait for ad to load
      debugPrint('Waiting for ad to load...');
      while (_rewardedAd == null && !completer.isCompleted) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (!mounted) {
          debugPrint('Widget unmounted while waiting for ad');
          completer.complete();
          return false;
        }
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.dreamEntry.dreamForm.watchAdError)),
      );
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

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              t.dreamEntry.dreamForm.record,
              style: theme.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _contentController,
            maxLength: maxContentLength,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: t.dreamEntry.dreamForm.content,
              border: const OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return t.dreamEntry.dreamForm.contentHint;
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text(t.dreamEntry.dreamForm.getInterpretation),
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
