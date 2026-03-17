import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ApproveHoursSummaryBar extends StatelessWidget {
  const ApproveHoursSummaryBar({
    super.key,
    required this.entryCount,
    required this.totalMinutes,
    required this.selectedCount,
    required this.onToggleSelectAll,
  });

  final int entryCount;
  final int totalMinutes;
  final int selectedCount;
  final VoidCallback onToggleSelectAll;

  @override
  Widget build(BuildContext context) {
    final hours = totalMinutes / 60;
    final isAllSelected = entryCount > 0 && selectedCount == entryCount;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.warningAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.warningAccent.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.pending_actions, color: AppTheme.warningAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pending Approval', style: Theme.of(context).textTheme.titleMedium),
                Text(
                  '$entryCount entries • ${hours.toStringAsFixed(1)} hours total',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: entryCount == 0 ? null : onToggleSelectAll,
            child: Text(isAllSelected ? 'Deselect All' : 'Select All'),
          ),
        ],
      ),
    );
  }
}
