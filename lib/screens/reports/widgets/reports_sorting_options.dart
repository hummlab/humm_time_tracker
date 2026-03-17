import 'package:flutter/material.dart';
import 'package:time_tracker/screens/reports/cubit/reports_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsSortingOptions extends StatelessWidget {
  const ReportsSortingOptions({
    super.key,
    required this.sortBy,
    required this.groupBy,
    required this.sortDescending,
    required this.onSortByChanged,
    required this.onToggleSortDirection,
    required this.onGroupByChanged,
  });

  final SortBy sortBy;
  final GroupBy groupBy;
  final bool sortDescending;
  final ValueChanged<SortBy> onSortByChanged;
  final VoidCallback onToggleSortDirection;
  final ValueChanged<GroupBy> onGroupByChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Row(
        children: [
          const Icon(Icons.sort, size: 18, color: AppTheme.primaryAccent),
          const SizedBox(width: 8),
          Text('Sort by:', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 12),
          _SortChip(label: 'Date', isSelected: sortBy == SortBy.date, onTap: () => onSortByChanged(SortBy.date)),
          const SizedBox(width: 8),
          _SortChip(
            label: 'Duration',
            isSelected: sortBy == SortBy.duration,
            onTap: () => onSortByChanged(SortBy.duration),
          ),
          const SizedBox(width: 8),
          _SortChip(
            label: 'Project',
            isSelected: sortBy == SortBy.project,
            onTap: () => onSortByChanged(SortBy.project),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(sortDescending ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: onToggleSortDirection,
            tooltip: sortDescending ? 'Descending' : 'Ascending',
            color: AppTheme.primaryAccent,
          ),
          const SizedBox(width: 8),
          Text('Group by:', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 8),
          DropdownButton<GroupBy>(
            value: groupBy,
            dropdownColor: AppTheme.cardDark,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: GroupBy.none, child: Text('None')),
              DropdownMenuItem(value: GroupBy.date, child: Text('Date')),
              DropdownMenuItem(value: GroupBy.project, child: Text('Project')),
              DropdownMenuItem(value: GroupBy.client, child: Text('Client')),
            ],
            onChanged: (value) {
              if (value != null) onGroupByChanged(value);
            },
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.2) : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryAccent : AppTheme.textSecondary,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
