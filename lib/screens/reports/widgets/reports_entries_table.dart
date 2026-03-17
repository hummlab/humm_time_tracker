import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/reports/cubit/reports_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsEntriesTable extends StatelessWidget {
  const ReportsEntriesTable({
    super.key,
    required this.entries,
    required this.groupBy,
    required this.getProjectById,
    required this.getClientById,
    required this.getTagById,
  });

  final List<TimeEntry> entries;
  final GroupBy groupBy;
  final Project? Function(String? id) getProjectById;
  final Client? Function(String? id) getClientById;
  final Tag? Function(String id) getTagById;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderDark),
        ),
        child: const Center(
          child: Text('No entries match the current filters', style: TextStyle(color: AppTheme.textMuted)),
        ),
      );
    }

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
              Text('Time Entries (${entries.length})', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              Text(
                'Total: ${_formatMinutes(entries.fold(0, (sum, e) => sum + e.durationMinutes))}',
                style: const TextStyle(color: AppTheme.primaryAccent, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._buildGroupedEntries(context),
        ],
      ),
    );
  }

  List<Widget> _buildGroupedEntries(BuildContext context) {
    if (groupBy == GroupBy.none) {
      return entries.map((e) => _buildEntryRow(context, e)).toList();
    }

    final groups = <String, List<TimeEntry>>{};
    for (final entry in entries) {
      final key = _groupKey(entry);
      groups.putIfAbsent(key, () => []).add(entry);
    }

    final widgets = <Widget>[];
    groups.forEach((key, groupEntries) {
      final groupName = _groupName(key);
      final groupTotal = groupEntries.fold(0, (sum, e) => sum + e.durationMinutes);

      widgets.add(
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Text(groupName, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
              const Spacer(),
              Text(
                '${groupEntries.length} entries • ${_formatMinutes(groupTotal)}',
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
              ),
            ],
          ),
        ),
      );
      widgets.addAll(groupEntries.map((e) => _buildEntryRow(context, e)));
    });

    return widgets;
  }

  String _groupKey(TimeEntry entry) {
    switch (groupBy) {
      case GroupBy.date:
        return DateFormat('yyyy-MM-dd').format(entry.date);
      case GroupBy.project:
        return entry.projectId ?? 'unassigned';
      case GroupBy.client:
        final project = entry.projectId != null ? getProjectById(entry.projectId) : null;
        return project?.clientId ?? 'no-client';
      case GroupBy.none:
        return 'all';
    }
  }

  String _groupName(String key) {
    switch (groupBy) {
      case GroupBy.date:
        return DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(key));
      case GroupBy.project:
        final project = key != 'unassigned' ? getProjectById(key) : null;
        return project?.name ?? 'Unassigned';
      case GroupBy.client:
        final client = key != 'no-client' ? getClientById(key) : null;
        return client?.name ?? 'No Client';
      case GroupBy.none:
        return 'All';
    }
  }

  String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) return '${hours}h ${mins}m';
    if (hours > 0) return '${hours}h';
    return '${mins}m';
  }

  Widget _buildEntryRow(BuildContext context, TimeEntry entry) {
    final project = entry.projectId != null ? getProjectById(entry.projectId) : null;
    final projectColor = project != null ? AppTheme.colorFromHex(project.color) : AppTheme.textMuted;
    final tags = entry.tagIds.map((id) => getTagById(id)).whereType<Tag>().toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(border: Border(left: BorderSide(color: projectColor, width: 3))),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              DateFormat('MMM d').format(entry.date),
              style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              entry.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(color: AppTheme.textPrimary),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          if (project != null)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: projectColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(project.name, style: TextStyle(fontSize: 11, color: projectColor)),
            ),
          ...tags
              .take(2)
              .map(
                (tag) => Container(
                  margin: const EdgeInsets.only(left: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.colorFromHex(tag.color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('#${tag.name}', style: TextStyle(fontSize: 10, color: AppTheme.colorFromHex(tag.color))),
                ),
              ),
          if (tags.length > 2)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text('+${tags.length - 2}', style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
            ),
          const SizedBox(width: 12),
          Text(
            entry.formattedDuration,
            style: const TextStyle(color: AppTheme.primaryAccent, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
