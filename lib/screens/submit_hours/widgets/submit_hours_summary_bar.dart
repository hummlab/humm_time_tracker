import 'package:flutter/material.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class SubmitHoursSummaryBar extends StatelessWidget {
  const SubmitHoursSummaryBar({
    super.key,
    required this.entryCount,
    required this.totalMinutes,
    required this.mode,
    required this.showSelectionControls,
    required this.isAllSelected,
    required this.onToggleSelectAll,
    required this.activeQuickSelect,
    required this.onSelectThisMonth,
    required this.onSelectLastMonth,
  });

  final int entryCount;
  final int totalMinutes;
  final SubmitHoursSummaryMode mode;
  final bool showSelectionControls;
  final bool isAllSelected;
  final VoidCallback onToggleSelectAll;
  final SubmitHoursQuickSelectPeriod activeQuickSelect;
  final VoidCallback onSelectThisMonth;
  final VoidCallback onSelectLastMonth;

  @override
  Widget build(BuildContext context) {
    final config = _SummaryConfig.fromMode(mode);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(config.icon, color: config.color, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            config.title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '$entryCount entries • ${_formatDuration(totalMinutes)} total',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (showSelectionControls)
                TextButton(
                  onPressed: entryCount == 0 ? null : onToggleSelectAll,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(isAllSelected ? 'Deselect All' : 'Select All'),
                ),
            ],
          ),
          if (showSelectionControls) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _QuickSelectChip(
                  label: 'This Month',
                  isActive:
                      activeQuickSelect ==
                      SubmitHoursQuickSelectPeriod.thisMonth,
                  onTap: onSelectThisMonth,
                ),
                _QuickSelectChip(
                  label: 'Last Month',
                  isActive:
                      activeQuickSelect ==
                      SubmitHoursQuickSelectPeriod.lastMonth,
                  onTap: onSelectLastMonth,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDuration(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    }
    if (hours > 0) {
      return '${hours}h';
    }
    return '${minutes}m';
  }
}

class _QuickSelectChip extends StatelessWidget {
  const _QuickSelectChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color:
              isActive
                  ? AppTheme.primaryAccent.withValues(alpha: 0.15)
                  : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppTheme.primaryAccent : AppTheme.borderDark,
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? Icons.check_circle : Icons.calendar_today,
              size: 13,
              color: isActive ? AppTheme.primaryAccent : AppTheme.textSecondary,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color:
                    isActive ? AppTheme.primaryAccent : AppTheme.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum SubmitHoursSummaryMode { draft, pending, rejected }

class _SummaryConfig {
  const _SummaryConfig({
    required this.color,
    required this.icon,
    required this.title,
  });

  final Color color;
  final IconData icon;
  final String title;

  factory _SummaryConfig.fromMode(SubmitHoursSummaryMode mode) {
    switch (mode) {
      case SubmitHoursSummaryMode.rejected:
        return const _SummaryConfig(
          color: AppTheme.tertiaryAccent,
          icon: Icons.warning_amber_rounded,
          title: 'Rejected entries need attention',
        );
      case SubmitHoursSummaryMode.pending:
        return const _SummaryConfig(
          color: AppTheme.warningAccent,
          icon: Icons.hourglass_empty,
          title: 'Awaiting approval',
        );
      case SubmitHoursSummaryMode.draft:
        return const _SummaryConfig(
          color: AppTheme.primaryAccent,
          icon: Icons.schedule,
          title: 'Ready to submit',
        );
    }
  }
}
