import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClientDashboardTagFilter extends StatelessWidget {
  const ClientDashboardTagFilter({
    super.key,
    required this.tags,
    required this.selectedTagIds,
    required this.onToggleTag,
    required this.onClearTags,
  });

  final List<Tag> tags;
  final List<String> selectedTagIds;
  final ValueChanged<String> onToggleTag;
  final VoidCallback onClearTags;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.filter_list, size: 18, color: AppTheme.textMuted),
              const SizedBox(width: 8),
              Text(
                'Filter by tags',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
              ),
              const Spacer(),
              if (selectedTagIds.isNotEmpty) TextButton(onPressed: onClearTags, child: const Text('Clear')),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                tags.map((tag) {
                  final isSelected = selectedTagIds.contains(tag.id);
                  final tagColor = AppTheme.colorFromHex(tag.color);

                  return GestureDetector(
                    onTap: () => onToggleTag(tag.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? tagColor.withValues(alpha: 0.2) : AppTheme.surfaceDark,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? tagColor : AppTheme.borderDark,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(color: tagColor, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tag.name,
                            style: TextStyle(
                              color: isSelected ? tagColor : AppTheme.textSecondary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
