import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/approve_hours/cubit/approve_hours_models.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ApproveHoursEntriesList extends StatelessWidget {
  const ApproveHoursEntriesList({
    super.key,
    required this.sections,
    required this.getProjectById,
    required this.isSelected,
    required this.onToggleEntry,
    required this.isDesktop,
  });

  final List<ApproveHoursUserSection> sections;
  final Project? Function(String? id) getProjectById;
  final bool Function(String entryId) isSelected;
  final ValueChanged<String> onToggleEntry;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return _UserSection(
          section: section,
          getProjectById: getProjectById,
          isSelected: isSelected,
          onToggleEntry: onToggleEntry,
        );
      },
    );
  }
}

class _UserSection extends StatelessWidget {
  const _UserSection({
    required this.section,
    required this.getProjectById,
    required this.isSelected,
    required this.onToggleEntry,
  });

  final ApproveHoursUserSection section;
  final Project? Function(String? id) getProjectById;
  final bool Function(String entryId) isSelected;
  final ValueChanged<String> onToggleEntry;

  @override
  Widget build(BuildContext context) {
    final hours = section.totalMinutes / 60;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UserHeader(memberName: section.member.name, hours: hours, entryCount: section.entries.length),
          ...section.dateSections.map(
            (dateSection) => _DateSection(
              section: dateSection,
              getProjectById: getProjectById,
              isSelected: isSelected,
              onToggleEntry: onToggleEntry,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({required this.memberName, required this.hours, required this.entryCount});

  final String memberName;
  final double hours;
  final int entryCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppTheme.borderDark))),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _getInitials(memberName),
                style: const TextStyle(color: AppTheme.primaryAccent, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(memberName, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  '$entryCount entries • ${hours.toStringAsFixed(1)}h',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${hours.toStringAsFixed(1)}h total',
              style: const TextStyle(color: AppTheme.primaryAccent, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

class _DateSection extends StatelessWidget {
  const _DateSection({
    required this.section,
    required this.getProjectById,
    required this.isSelected,
    required this.onToggleEntry,
  });

  final ApproveHoursDateSection section;
  final Project? Function(String? id) getProjectById;
  final bool Function(String entryId) isSelected;
  final ValueChanged<String> onToggleEntry;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEE, MMM d');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              Text(
                dateFormat.format(section.date),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '${(section.totalMinutes / 60).toStringAsFixed(1)}h',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted),
              ),
            ],
          ),
        ),
        ...section.entries.map(
          (entry) => _EntryRow(
            entry: entry,
            project: getProjectById(entry.projectId),
            isSelected: isSelected(entry.id),
            onToggle: () => onToggleEntry(entry.id),
          ),
        ),
      ],
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry, required this.project, required this.isSelected, required this.onToggle});

  final TimeEntry entry;
  final Project? project;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.05) : null,
          border: const Border(bottom: BorderSide(color: AppTheme.borderDark, width: 0.5)),
        ),
        child: Row(
          children: [
            Checkbox(value: isSelected, onChanged: (_) => onToggle(), activeColor: AppTheme.primaryAccent),
            if (project != null) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.colorFromHex(project!.color),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 120,
                child: Text(
                  project!.name,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                entry.description.isEmpty ? '(No description)' : entry.description,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(6)),
              child: Text(
                entry.formattedDuration,
                style: const TextStyle(color: AppTheme.primaryAccent, fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
