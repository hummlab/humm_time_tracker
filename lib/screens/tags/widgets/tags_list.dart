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
    final totalUsages = sortedTags.fold<int>(
      0,
      (sum, tag) => sum + entryCountFor(tag.id),
    );

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 32 : 16,
        8,
        isDesktop ? 32 : 16,
        112,
      ),
      itemCount: sortedTags.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Tags: ${sortedTags.length} | Total usages: $totalUsages',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted),
            ),
          );
        }

        final tag = sortedTags[index - 1];
        final entryCount = entryCountFor(tag.id);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TagChip(
            tag: tag,
            entryCount: entryCount,
            onTap: () => onEditTag(tag),
            onDelete: () => onDeleteTag(tag),
          ),
        );
      },
    );
  }
}
