import 'package:dream/core/di/injection.dart';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/core/presentation/animated_background.dart';
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
import 'dart:ui';
import 'package:dream/config/theme/theme_cubit.dart';

/// Screen for entering and interpreting dreams
class DreamEntryScreen extends StatefulWidget {
  const DreamEntryScreen({super.key});

  @override
  State<DreamEntryScreen> createState() => _DreamEntryScreenState();
}

class _DreamEntryScreenState extends State<DreamEntryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => getIt<DreamEntryCubit>(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            t.dreamEntry.newDream,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            const AnimatedBackground(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: (isDarkMode
                                ? theme.colorScheme.surface
                                : theme.colorScheme.surface)
                            .withOpacity(isDarkMode ? 0.4 : 0.7),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: BlocBuilder<DreamEntryCubit, DreamEntryState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(24, 16, 24, 24),
                              child: const DreamFormWidget(),
                            ),
                            loading: () => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Interpreting your dream...',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            success: (dreamEntry) => InterpretationModalContent(
                              dreamEntry: dreamEntry,
                              onSave: () =>
                                  _showDetailsModal(dreamEntry, context),
                              onShare: () => _shareDream(dreamEntry),
                              onDiscard: () {
                                context.read<DreamEntryCubit>().reset();
                                context.go(AppRoute.dreamEntry);
                              },
                            ),
                            error: (message) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: theme.colorScheme.error,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${t.core.errors.error}$message',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: theme.colorScheme.error
                                          .withOpacity(0.1),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.refresh,
                                        color: theme.colorScheme.error,
                                      ),
                                      onPressed: () {
                                        context.read<DreamEntryCubit>().reset();
                                      },
                                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDetailsModal(
      DreamEntry dreamEntry, BuildContext context) async {
    final theme = Theme.of(context);
    await AppModalSheet.show(
      context: context,
      useGlassmorphism: true,
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
                SnackBar(
                  content: Text('Failed to save dream: $e'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: theme.colorScheme.error,
                ),
              );
            }
          }
        },
      ),
    );
  }

  Future<void> _shareDream(DreamEntry dreamEntry) async {
    final shareText = '''
✨ Dream:
${dreamEntry.content}

🌙 Interpretation:
${dreamEntry.interpretation}
''';

    await Share.share(shareText, subject: 'Dream Interpretation');
  }
}
