import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_entry/models/dream_entry_model.dart';
import 'package:dream/shared/widgets/app_modal_sheet.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/interpretation_modal_content.dart';
import '../widgets/dream_details_modal_content.dart';
import 'package:dream/shared/widgets/ad_banner_widget.dart';

class DreamFormWidget extends StatefulWidget {
  const DreamFormWidget({super.key});

  @override
  State<DreamFormWidget> createState() => _DreamFormWidgetState();
}

class _DreamFormWidgetState extends State<DreamFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  static const int maxContentLength = 1000;

  @override
  void dispose() {
    _contentController.dispose();
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
          const AdBannerWidget(),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _handleDreamInterpretation();
    }
  }

  Future<void> _handleDreamInterpretation() async {
    final cubit = context.read<DreamEntryCubit>();
    await cubit.interpretDream(
      title: '',
      content: _contentController.text,
    );

    if (!mounted) return;

    final state = cubit.state;
    state.whenOrNull(
      success: (dreamEntry) async {
        await _showInterpretationModal(dreamEntry);
      },
    );
  }

  Future<void> _showInterpretationModal(DreamEntry dreamEntry) async {
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
    context.pop();
    await AppModalSheet.show(
      context: context,
      child: DreamDetailsModalContent(
        dreamEntry: dreamEntry,
        onConfirm: (title, tags, moodRating) async {
          await _saveDreamEntry(dreamEntry, title, tags, moodRating.toInt());
        },
      ),
    );
  }

  Future<void> _saveDreamEntry(
    DreamEntry dreamEntry,
    String title,
    List<String> tags,
    int moodRating,
  ) async {
    final updatedDream = dreamEntry.copyWith(
      title: title,
      tags: tags,
      moodRating: moodRating,
    );

    try {
      await context.read<DreamEntryCubit>().saveDream(updatedDream);
      if (mounted) {
        context.pop();
        context.go(AppRoute.dreamEntry);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.dreamEntry.failedToSaveDream)),
        );
      }
    }
  }

  Future<void> _shareDream(DreamEntry dreamEntry) async {
    final shareText = '''
${t.dreamEntry.yourDream}:
${dreamEntry.content}

${t.dreamEntry.interpretation.interpretationText}:
${dreamEntry.interpretation}
''';

    await Share.share(shareText, subject: t.dreamEntry.interpretation.title);
  }
}
