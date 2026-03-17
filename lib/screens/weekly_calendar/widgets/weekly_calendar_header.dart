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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppTheme.cardDark,
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onPreviousWeek,
            color: AppTheme.textSecondary,
            visualDensity: VisualDensity.compact,
          ),
          Text(
            '${DateFormat('MMM d').format(weekStart)} – ${DateFormat('MMM d, yyyy').format(weekEnd)}',
            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: onNextWeek,
            color: AppTheme.textSecondary,
            visualDensity: VisualDensity.compact,
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WEEK TOTAL',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textMuted,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                '${weekHours}h ${weekMinutes}m',
                style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
