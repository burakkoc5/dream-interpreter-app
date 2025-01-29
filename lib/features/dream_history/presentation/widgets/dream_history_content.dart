import 'dart:ui';
import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/features/dream_history/presentation/widgets/delete_dream_alert_dialog.dart';
import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_toast.dart';
import 'package:dream/shared/widgets/dream_card_widget.dart';
import 'package:dream/core/services/logging_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> _handleRefresh(BuildContext context) async {
    final logger = context.read<LoggingService>();
    logger.log('Refreshing dreams list', level: LogLevel.info);
    await context.read<DreamHistoryCubit>().loadDreams(refresh: true);
  }

  Future<void> _handleDreamDeletion(
      BuildContext context, DreamHistoryModel dream) async {
    final logger = context.read<LoggingService>();
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: DeleteDreamAlertDialog(theme: theme, dream: dream),
      ),
    );

    if (shouldDelete == true && context.mounted) {
      logger.log('Deleting dream',
          level: LogLevel.info, additionalData: {'dreamId': dream.id});
      context.read<DreamHistoryCubit>().deleteDream(dream.id);
      AppToast.showSuccess(
        context,
        title: t.core.success,
        description: t.searchDreams.dreamDeleted,
      );
    }
  }

  Widget _buildDreamCard(BuildContext context, DreamHistoryModel dream) {
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
        onDelete: () => _handleDreamDeletion(context, dream),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.9),
      color: theme.colorScheme.primary,
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemCount: state.filteredDreams.length,
        itemBuilder: (context, index) =>
            _buildDreamCard(context, state.filteredDreams[index]),
      ),
    );
  }
}
