import 'package:dream/features/dream_history/application/dream_history_cubit.dart';
import 'package:dream/features/dream_history/application/dream_history_state.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dream_history_mixin.dart';

class DreamHistoryScreen extends StatefulWidget {
  const DreamHistoryScreen({super.key});

  @override
  State<DreamHistoryScreen> createState() => _DreamHistoryScreenState();
}

class _DreamHistoryScreenState extends State<DreamHistoryScreen>
    with DreamHistoryMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DreamHistoryCubit, DreamHistoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              t.dreamHistory.dreamHistory,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
                buildSearchBar(context),
                buildFilterChips(context, state),
                Expanded(
                  child: buildDreamsList(context, state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
