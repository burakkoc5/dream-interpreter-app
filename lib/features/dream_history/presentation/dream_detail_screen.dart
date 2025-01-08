import 'package:dream/features/dream_history/models/dream_history_model.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DreamDetailScreen extends StatelessWidget {
  final DreamHistoryModel dream;

  const DreamDetailScreen({super.key, required this.dream});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
              onPressed: () {
                context.pop();
              },
            ),
            expandedHeight: 150,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                dream.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.tertiaryFixed,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    context,
                    title: t.dreamDetail,
                    content: dream.content,
                  ),
                  const SizedBox(height: 20),
                  if (dream.interpretation.isNotEmpty)
                    _buildSection(
                      context,
                      title: t.dreamEntry.interpretation.title,
                      content: dream.interpretation,
                      icon: Icons.psychology,
                      iconColor: theme.colorScheme.tertiary,
                    ),
                  if (dream.tags.isNotEmpty)
                    _buildTagsSection(context, dream.tags),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    IconData? icon,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: iconColor),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection(BuildContext context, List<String> tags) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.dreamEntry.tags.tags,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: theme.colorScheme.primaryContainer,
                labelStyle: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
