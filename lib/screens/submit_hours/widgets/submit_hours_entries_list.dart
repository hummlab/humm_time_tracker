import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_models.dart';
import 'package:time_tracker/theme/app_theme.dart';

class SubmitHoursEntriesList extends StatelessWidget {
  const SubmitHoursEntriesList({
    super.key,
    required this.sections,
    required this.isForReview,
    required this.isDesktop,
    required this.getProjectById,
    required this.getTagById,
    required this.isSelected,
    required this.onToggleEntry,
  });

  final List<SubmitHoursDateSection> sections;
  final bool isForReview;
  final bool isDesktop;
  final Project? Function(String? id) getProjectById;
  final Tag? Function(String id) getTagById;
  final bool Function(String id) isSelected;
  final ValueChanged<String> onToggleEntry;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return _DateSection(
          section: section,
          isForReview: isForReview,
          getProjectById: getProjectById,
          getTagById: getTagById,
          isSelected: isSelected,
          onToggleEntry: onToggleEntry,
        );
      },
    );
  }
}

class _DateSection extends StatelessWidget {
  const _DateSection({
    required this.section,
    required this.isForReview,
    required this.getProjectById,
    required this.getTagById,
    required this.isSelected,
    required this.onToggleEntry,
  });

  final SubmitHoursDateSection section;
  final bool isForReview;
  final Project? Function(String? id) getProjectById;
  final Tag? Function(String id) getTagById;
  final bool Function(String id) isSelected;
  final ValueChanged<String> onToggleEntry;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d');
    final hours = section.totalMinutes / 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 6, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  dateFormat.format(section.date),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
              Text(
                '${hours.toStringAsFixed(1)}h',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.primaryAccent),
              ),
            ],
          ),
        ),
        ...section.entries.map(
          (entry) => _EntryCard(
            entry: entry,
            project: getProjectById(entry.projectId),
            tags: entry.tagIds.map(getTagById).whereType<Tag>().toList(),
            isForReview: isForReview,
            isSelected: isSelected(entry.id),
            onToggle: () => onToggleEntry(entry.id),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.entry,
    required this.project,
    required this.tags,
    required this.isForReview,
    required this.isSelected,
    required this.onToggle,
  });

  final TimeEntry entry;
  final Project? project;
  final List<Tag> tags;
  final bool isForReview;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isForReview ? null : onToggle,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppTheme.primaryAccent.withValues(alpha: 0.1)
                  : AppTheme.cardDark.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isForReview)
                  Checkbox(
                    value: isSelected,
                    onChanged: (_) => onToggle(),
                    activeColor: AppTheme.primaryAccent,
                    visualDensity: VisualDensity.compact,
                  ),
                if (!isForReview) const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.description.isEmpty
                            ? '(No description)'
                            : entry.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (project != null || tags.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (project != null)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppTheme.colorFromHex(
                                        project!.color,
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    project!.name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.colorFromHex(
                                        project!.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ...tags.map(
                              (tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.colorFromHex(
                                    tag.color,
                                  ).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '#${tag.name}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppTheme.colorFromHex(tag.color),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  entry.formattedDuration,
                  style: const TextStyle(
                    color: AppTheme.primaryAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            if (entry.isRejected && entry.rejectionReason != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.tertiaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.tertiaryAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.feedback_outlined,
                      size: 16,
                      color: AppTheme.tertiaryAccent,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rejection Reason:',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: AppTheme.tertiaryAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.rejectionReason!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
