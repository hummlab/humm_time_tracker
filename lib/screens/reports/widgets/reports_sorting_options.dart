import 'package:flutter/material.dart';
import 'package:time_tracker/screens/reports/cubit/reports_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsSortingOptions extends StatelessWidget {
  const ReportsSortingOptions({
    super.key,
    required this.isDesktop,
    required this.sortBy,
    required this.groupBy,
    required this.sortDescending,
    required this.onSortByChanged,
    required this.onToggleSortDirection,
    required this.onGroupByChanged,
  });

  final bool isDesktop;
  final SortBy sortBy;
  final GroupBy groupBy;
  final bool sortDescending;
  final ValueChanged<SortBy> onSortByChanged;
  final VoidCallback onToggleSortDirection;
  final ValueChanged<GroupBy> onGroupByChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 14 : 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _GroupByMenuButton(
            groupBy: groupBy,
            onGroupByChanged: onGroupByChanged,
          ),
          _SortChip(
            label: 'Date',
            isSelected: sortBy == SortBy.date,
            onTap: () => onSortByChanged(SortBy.date),
          ),
          _SortChip(
            label: 'Duration',
            isSelected: sortBy == SortBy.duration,
            onTap: () => onSortByChanged(SortBy.duration),
          ),
          _SortChip(
            label: 'Project',
            isSelected: sortBy == SortBy.project,
            onTap: () => onSortByChanged(SortBy.project),
          ),
          IconButton(
            icon: Icon(
              sortDescending ? Icons.arrow_downward : Icons.arrow_upward,
              size: 18,
            ),
            onPressed: onToggleSortDirection,
            tooltip: sortDescending ? 'Descending' : 'Ascending',
            color: AppTheme.primaryAccent,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _GroupByMenuButton extends StatelessWidget {
  const _GroupByMenuButton({
    required this.groupBy,
    required this.onGroupByChanged,
  });

  final GroupBy groupBy;
  final ValueChanged<GroupBy> onGroupByChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<GroupBy>(
      initialValue: groupBy,
      onSelected: onGroupByChanged,
      color: AppTheme.cardDark,
      itemBuilder:
          (context) => const [
            PopupMenuItem(value: GroupBy.none, child: Text('Group: None')),
            PopupMenuItem(value: GroupBy.date, child: Text('Group: Date')),
            PopupMenuItem(
              value: GroupBy.project,
              child: Text('Group: Project'),
            ),
            PopupMenuItem(value: GroupBy.client, child: Text('Group: Client')),
          ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.account_tree_outlined,
              size: 16,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              _groupLabel(groupBy),
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more, size: 16, color: AppTheme.textMuted),
          ],
        ),
      ),
    );
  }

  String _groupLabel(GroupBy value) {
    switch (value) {
      case GroupBy.none:
        return 'None';
      case GroupBy.date:
        return 'Date';
      case GroupBy.project:
        return 'Project';
      case GroupBy.client:
        return 'Client';
    }
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppTheme.primaryAccent.withValues(alpha: 0.2)
                  : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark,
          ),
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
