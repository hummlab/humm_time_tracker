import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/screens/tags/widgets/tag_chip.dart';

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
    return Padding(
      padding: EdgeInsets.all(isDesktop ? 32 : 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children:
            tags.map((tag) {
              final entryCount = entryCountFor(tag.id);

              return TagChip(
                tag: tag,
                entryCount: entryCount,
                onTap: () => onEditTag(tag),
                onDelete: () => onDeleteTag(tag),
              );
            }).toList(),
      ),
    );
  }
}
