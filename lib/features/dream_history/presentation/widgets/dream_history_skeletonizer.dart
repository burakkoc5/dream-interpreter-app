import 'package:dream/shared/widgets/dream_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DreamHistorySkeletonizer extends StatelessWidget {
  const DreamHistorySkeletonizer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      containersColor: theme.colorScheme.surface,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DreamCard(
              title: 'Loading...',
              dreamContent: 'Loading...',
              interpretation: 'Loading...',
              date: DateTime.now(),
              moodRating: 0,
              isFavourite: false,
              onFavoriteToggle: () {
                // context.read<DreamHistoryCubit>().toggleFavorite(dream);
              },
              onTap: () {},
              onDelete: () async {},
            ),
          );
        },
      ),
    );
  }
}
