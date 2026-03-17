import 'package:flutter/material.dart';

import '../models/projects/project.dart';
import '../models/projects/tag.dart';
import '../models/time/time_entry.dart';
import '../theme/app_theme.dart';

class TimeEntryCard extends StatelessWidget {
  final TimeEntry entry;
  final Project? project;
  final List<Tag> tags;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TimeEntryCard({super.key, required this.entry, this.project, this.tags = const [], this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final projectColor = project != null ? AppTheme.colorFromHex(project!.color) : AppTheme.textMuted;

    return Dismissible(
      key: Key(entry.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppTheme.tertiaryAccent.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: AppTheme.tertiaryAccent),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.borderDark),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(color: projectColor, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.description,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (project != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: projectColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              project!.name,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: projectColor),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        ...tags
                            .take(2)
                            .map(
                              (tag) => Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.colorFromHex(tag.color).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    tag.name,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.colorFromHex(tag.color),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        if (tags.length > 2) Text('+${tags.length - 2}', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  entry.formattedDuration,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.primaryAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
