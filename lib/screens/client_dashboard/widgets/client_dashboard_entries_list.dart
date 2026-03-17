import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClientDashboardEntriesList extends StatelessWidget {
  const ClientDashboardEntriesList({
    super.key,
    required this.entries,
    required this.projects,
    required this.tags,
    required this.hasTagFilter,
    required this.isDesktop,
  });

  final List<TimeEntry> entries;
  final List<Project> projects;
  final List<Tag> tags;
  final bool hasTagFilter;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty, size: 64, color: AppTheme.textMuted.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              hasTagFilter ? 'No entries match the selected tags' : 'No hours logged this month',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textMuted),
            ),
          ],
        ),
      );
    }

    final groupedEntries = <DateTime, List<TimeEntry>>{};
    for (final entry in entries) {
      final dateKey = DateTime(entry.date.year, entry.date.month, entry.date.day);
      groupedEntries.putIfAbsent(dateKey, () => []).add(entry);
    }

    final sortedDates = groupedEntries.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : 16),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final dateEntries = groupedEntries[date]!;
        final dayTotal = dateEntries.fold<int>(0, (sum, entry) => sum + entry.durationMinutes);

        return _DateSection(date: date, entries: dateEntries, totalMinutes: dayTotal, projects: projects, tags: tags);
      },
    );
  }
}

class _DateSection extends StatelessWidget {
  const _DateSection({
    required this.date,
    required this.entries,
    required this.totalMinutes,
    required this.projects,
    required this.tags,
  });

  final DateTime date;
  final List<TimeEntry> entries;
  final int totalMinutes;
  final List<Project> projects;
  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d');
    final hours = totalMinutes / 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text(
                dateFormat.format(date),
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${hours.toStringAsFixed(1)}h',
                  style: const TextStyle(color: AppTheme.primaryAccent, fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        ...entries.map((entry) {
          return _EntryCard(entry: entry, projects: projects, tags: tags);
        }),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({required this.entry, required this.projects, required this.tags});

  final TimeEntry entry;
  final List<Project> projects;
  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    final project =
        entry.projectId != null
            ? projects.firstWhere(
              (project) => project.id == entry.projectId,
              orElse: () => Project(id: '', name: 'Unknown', createdAt: DateTime.now()),
            )
            : null;

    final entryTags =
        entry.tagIds
            .map(
              (tagId) => tags.firstWhere(
                (tag) => tag.id == tagId,
                orElse: () => Tag(id: '', name: 'Unknown', createdAt: DateTime.now()),
              ),
            )
            .where((tag) => tag.id.isNotEmpty)
            .toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (project != null) ...[
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppTheme.colorFromHex(project.color),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            project.name,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                    ],
                    Text(
                      entry.description.isEmpty ? '(No description)' : entry.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.formattedDuration,
                  style: const TextStyle(color: AppTheme.primaryAccent, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ],
          ),
          if (entryTags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children:
                  entryTags.map((tag) {
                    final tagColor = AppTheme.colorFromHex(tag.color);
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: tagColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: tagColor.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(color: tagColor, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 4),
                          Text(tag.name, style: TextStyle(color: tagColor, fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
