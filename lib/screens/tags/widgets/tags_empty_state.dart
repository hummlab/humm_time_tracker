import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class TagsEmptyState extends StatelessWidget {
  const TagsEmptyState({super.key, required this.onAddTag});

  final VoidCallback onAddTag;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppTheme.primaryAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.label_outline, size: 64, color: AppTheme.primaryAccent),
          ),
          const SizedBox(height: 24),
          Text('No tags yet', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Create tags to categorize your time entries', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          ElevatedButton.icon(onPressed: onAddTag, icon: const Icon(Icons.add), label: const Text('Create Tag')),
        ],
      ),
    );
  }
}
