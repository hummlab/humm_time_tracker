import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/theme/app_theme.dart';

class WeeklyCalendarHeader extends StatelessWidget {
  const WeeklyCalendarHeader({
    super.key,
    required this.weekStart,
    required this.onPreviousWeek,
    required this.onNextWeek,
    required this.weekHours,
    required this.weekMinutes,
  });

  final DateTime weekStart;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;
  final int weekHours;
  final int weekMinutes;

  @override
  Widget build(BuildContext context) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final isNarrow = MediaQuery.of(context).size.width < 720;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: AppTheme.cardDark,
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 20),
            onPressed: onPreviousWeek,
            color: AppTheme.textSecondary,
            visualDensity: VisualDensity.compact,
          ),
          Expanded(
            child: Text(
              '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: isNarrow ? 12 : 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: onNextWeek,
            color: AppTheme.textSecondary,
            visualDensity: VisualDensity.compact,
          ),
          Text(
            '${weekHours}h ${weekMinutes}m',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isNarrow ? 11 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
