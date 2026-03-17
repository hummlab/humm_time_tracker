import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/theme/app_theme.dart';

class WeeklyGridHeader extends StatelessWidget {
  const WeeklyGridHeader({
    super.key,
    required this.weekStart,
    required this.onPreviousWeek,
    required this.onNextWeek,
    required this.onGoToToday,
    required this.onAddRow,
  });

  final DateTime weekStart;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;
  final VoidCallback onGoToToday;
  final VoidCallback onAddRow;

  @override
  Widget build(BuildContext context) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final monthFormat = DateFormat('MMM');
    final dayFormat = DateFormat('d');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppTheme.cardDark,
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: onPreviousWeek, color: AppTheme.textSecondary),
          TextButton(
            onPressed: onGoToToday,
            child: Text(
              '${monthFormat.format(weekStart)} ${dayFormat.format(weekStart)} '
              '– ${monthFormat.format(weekEnd)} ${dayFormat.format(weekEnd)}, '
              '${weekStart.year}',
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(icon: const Icon(Icons.chevron_right), onPressed: onNextWeek, color: AppTheme.textSecondary),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: onAddRow,
            icon: const Icon(Icons.add),
            label: const Text('Add Row'),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryAccent),
          ),
        ],
      ),
    );
  }
}
