import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_entry/models/dream_entry_model.dart';
import 'package:dream/shared/widgets/app_modal_sheet.dart';
import 'package:dream/shared/services/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../widgets/interpretation_modal_content.dart';
import '../widgets/dream_details_modal_content.dart';

/// A form widget for entering and editing dreams
class DreamFormWidget extends StatefulWidget {
  const DreamFormWidget({super.key});

  @override
  State<DreamFormWidget> createState() => _DreamFormWidgetState();
}

class _DreamFormWidgetState extends State<DreamFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  static const int maxContentLength = 1000;
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Ad failed to load: ${error.message}');
          ad.dispose();
        },
      ),
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _bannerAd?.dispose();
    super.dispose();
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
              'Record Your Dream',
              style: theme.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _contentController,
            maxLength: maxContentLength,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Dream Content',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your dream';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Get Interpretation'),
          ),
          if (_isAdLoaded)
            Container(
              margin: const EdgeInsets.only(top: 16),
              height: _bannerAd!.size.height.toDouble(),
              width: _bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    print('Submitting dream form');
    if (_formKey.currentState?.validate() ?? false) {
      final cubit = context.read<DreamEntryCubit>();
      await cubit.interpretDream(
        title: '', // Empty title, will be set later
        content: _contentController.text,
      );

      if (!mounted) return;

      final state = cubit.state;
      state.whenOrNull(
        success: (dreamEntry) async {
          print('Dream interpreted successfully');
          await _showInterpretationModal(dreamEntry);
        },
      );
    }
  }

  Future<void> _showInterpretationModal(DreamEntry dreamEntry) async {
    print('Showing interpretation modal');

    await AppModalSheet.show(
      context: context,
      child: InterpretationModalContent(
        dreamEntry: dreamEntry,
        onSave: () => _showDetailsModal(dreamEntry),
        onShare: () => _shareDream(dreamEntry),
        onDiscard: () {
          context.read<DreamEntryCubit>().reset();
          context.pop();
        },
      ),
    );
  }

  Future<void> _showDetailsModal(DreamEntry dreamEntry) async {
    print('Showing details modal');
    context.pop(); // Close interpretation modal
    await AppModalSheet.show(
      context: context,
      child: DreamDetailsModalContent(
        dreamEntry: dreamEntry,
        onConfirm: (title, tags, moodRating) async {
          final updatedDream = dreamEntry.copyWith(
            title: title,
            tags: tags,
            moodRating: moodRating,
          );

          try {
            await context.read<DreamEntryCubit>().saveDream(updatedDream);
            if (mounted) {
              context.pop(); // Close details modal
              context.go(AppRoute.dreamEntry);
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to save dream: $e')),
              );
            }
          }
        },
      ),
    );
  }

  Future<void> _shareDream(DreamEntry dreamEntry) async {
    final shareText = '''
Dream:
${dreamEntry.content}

Interpretation:
${dreamEntry.interpretation}
''';

    await Share.share(shareText, subject: 'Dream Interpretation');
  }
}
