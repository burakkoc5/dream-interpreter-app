import 'dart:ui';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/features/dream_history/presentation/widgets/delete_dream_alert_dialog.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/dream_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class DreamHistoryContent extends StatelessWidget {
  const DreamHistoryContent({
    super.key,
    required this.theme,
    required this.scrollController,
    required this.state,
    required this.context,
  });

  final ThemeData theme;
  final ScrollController? scrollController;
  final DreamHistoryState state;
  final BuildContext context;

  void _showSuccessToast(String message) {
    if (!context.mounted) return;

    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: Text('Başarılı'),
      description: Text(message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        debugPrint('DreamHistoryMixin - Pull-to-refresh of dreams');
        await context.read<DreamHistoryCubit>().loadDreams(refresh: true);
      },
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.9),
      color: theme.colorScheme.primary,
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemCount: state.filteredDreams.length,
        itemBuilder: (context, index) {
          final dream = state.filteredDreams[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DreamCard(
              title: dream.title,
              dreamContent: dream.content,
              interpretation: dream.interpretation,
              date: dream.createdAt,
              moodRating: dream.moodRating,
              isFavourite: dream.isFavourite,
              onFavoriteToggle: () {
                context.read<DreamHistoryCubit>().toggleFavorite(dream);
              },
              onTap: () {
                context.push(
                  AppRoute.dreamDetail,
                  extra: dream,
                );
              },
              onDelete: () async {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: DeleteDreamAlertDialog(theme: theme, dream: dream),
                  ),
                );

                if (shouldDelete == true && context.mounted) {
                  debugPrint('DreamHistoryMixin - Deleting dream ${dream.id}');
                  context.read<DreamHistoryCubit>().deleteDream(dream.id);
                  _showSuccessToast(t.searchDreams.dreamDeleted);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
