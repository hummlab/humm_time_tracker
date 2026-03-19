import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/screens/tags/widgets/tag_chip.dart';
import 'package:time_tracker/theme/app_theme.dart';

class TagsList extends StatelessWidget {
  const TagsList({
    super.key,
    required this.tags,
    required this.isDesktop,
    required this.entryCountFor,
    required this.onEditTag,
    required this.onDeleteTag,
  });

  final List<Tag> tags;
  final bool isDesktop;
  final int Function(String tagId) entryCountFor;
  final ValueChanged<Tag> onEditTag;
  final ValueChanged<Tag> onDeleteTag;

  @override
  Widget build(BuildContext context) {
    final sortedTags = List<Tag>.from(tags)..sort((a, b) {
      final countCompare = entryCountFor(b.id).compareTo(entryCountFor(a.id));
      if (countCompare != 0) return countCompare;
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    final totalUsages = sortedTags.fold<int>(0, (sum, tag) => sum + entryCountFor(tag.id));

    return Padding(
      padding: EdgeInsets.all(isDesktop ? 32 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderDark),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.label_outline, size: 18, color: AppTheme.primaryAccent),
                    const SizedBox(width: 8),
                    Text('Tags: ${sortedTags.length}', style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                Container(width: 1, height: 18, color: AppTheme.borderDark),
                Text(
                  'Total usages: $totalUsages',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                sortedTags.map((tag) {
                  final entryCount = entryCountFor(tag.id);

                  return TagChip(
                    tag: tag,
                    entryCount: entryCount,
                    onTap: () => onEditTag(tag),
                    onDelete: () => onDeleteTag(tag),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
