import 'package:dream/core/di/injection.dart';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_entry/application/dream_entry_state.dart';
import 'package:dream/features/dream_entry/models/dream_entry_model.dart';
import 'package:dream/features/dream_entry/widgets/dream_details_modal_content.dart';
import 'package:dream/features/dream_entry/widgets/interpretation_modal_content.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/dream_form_widget.dart';

/// Screen for entering and interpreting dreams
class DreamEntryScreen extends StatelessWidget {
  const DreamEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DreamEntryCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.dreamEntry.newDream),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<DreamEntryCubit, DreamEntryState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const DreamFormWidget(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  success: (dreamEntry) => InterpretationModalContent(
                    dreamEntry: dreamEntry,
                    onSave: () => _showDetailsModal(dreamEntry, context),
                    onShare: () => _shareDream(dreamEntry),
                  ),
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${t.core.errors.error}$message'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<DreamEntryCubit>().reset();
                          },
                          child: Text(t.core.errors.tryAgain),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDetailsModal(
      DreamEntry dreamEntry, BuildContext context) async {
    print('Showing details modal');
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
          context.pop();
          try {
            await context.read<DreamEntryCubit>().saveDream(updatedDream);
            if (context.mounted) {
              context.read<DreamEntryCubit>().reset();
              context.go(AppRoute.dreamEntry);
            }
          } catch (e) {
            if (context.mounted) {
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
