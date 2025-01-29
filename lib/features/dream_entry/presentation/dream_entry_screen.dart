import 'package:dream/core/di/injection.dart';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/core/presentation/animated_background.dart';
import 'package:dream/features/dream_entry/application/dream_entry_cubit.dart';
import 'package:dream/features/dream_entry/application/dream_entry_state.dart';
import 'package:dream/features/dream_entry/models/dream_entry_model.dart';
import 'package:dream/features/dream_entry/presentation/widgets/dream_details_modal_content.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/utils/share_utils.dart';
import 'package:dream/shared/widgets/app_modal_sheet.dart';
import 'package:dream/shared/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'widgets/dream_form_widget.dart';
import 'widgets/dream_loading_widget.dart';
import 'widgets/dream_error_widget.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return BlocProvider(
      create: (context) => getIt<DreamEntryCubit>(),
      child: Scaffold(
        extendBody: true,
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    children: [
                      _buildGlassContainer(
                        context,
                        isDarkMode,
                        theme,
                      ),
                      const SizedBox(
                          height:
                              80), // Reduced bottom padding since we have spacing above
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassContainer(
    BuildContext context,
    bool isDarkMode,
    ThemeData theme,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: (isDarkMode
                    ? theme.colorScheme.surface
                    : theme.colorScheme.surface)
                .withValues(alpha: isDarkMode ? 0.4 : 0.7),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: BlocBuilder<DreamEntryCubit, DreamEntryState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Padding(
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: DreamFormWidget(),
                ),
                loading: () => const DreamLoadingWidget(),
                success: (dreamEntry) => SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.dreamEntry.yourDream,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          dreamEntry.content,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        t.dreamEntry.interpretation.interpretationText,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.secondary
                                .withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          dreamEntry.interpretation,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  _showDetailsModal(dreamEntry, context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(t.dreamEntry.saveDream),
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: () => ShareUtils.shareDreamAsImage(
                                context: context,
                                title: dreamEntry.title,
                                content: dreamEntry.content,
                                interpretation: dreamEntry.interpretation,
                                date: dreamEntry.createdAt,
                                moodRating: dreamEntry.moodRating),
                            icon: const Icon(Icons.share),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<DreamEntryCubit>().reset();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                error: (message) => DreamErrorWidget(message: message),
              );
            },
          ),
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
            moodRating: moodRating.toInt(),
          );
          try {
            await context.read<DreamEntryCubit>().saveDream(updatedDream);
            if (context.mounted) {
              AppToast.showSuccess(
                context,
                title: t.core.success,
                description: t.dreamEntry.dreamForm.dreamSaved,
              );
              context.read<DreamEntryCubit>().reset();
              context.pop();
              context.go(AppRoute.dreamEntry);
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.dreamEntry.failedToSaveDream),
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
}
