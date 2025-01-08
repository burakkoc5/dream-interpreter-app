import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DreamCard extends StatelessWidget {
  final String title;
  final String dreamContent;
  final String interpretation;
  final DateTime date;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const DreamCard({
    super.key,
    required this.title,
    required this.dreamContent,
    required this.interpretation,
    required this.date,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                dreamContent,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () =>
                            _shareDream(title, dreamContent, interpretation),
                      ),
                      if (onDelete != null)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: onDelete,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _shareDream(
    String title,
    String dream,
    String interpretation,
  ) async {
    final text = 'Dream: $title\n\n$dream\n\nInterpretation:\n$interpretation';
    await Share.share(text);
  }
}
