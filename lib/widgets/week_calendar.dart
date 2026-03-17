import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

class WeekCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Map<DateTime, int> minutesByDate;

  const WeekCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.minutesByDate = const {},
  });

  DateTime get _weekStart {
    final weekday = selectedDate.weekday;
    return selectedDate.subtract(Duration(days: weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    final days = List.generate(7, (index) => _weekStart.add(Duration(days: index)));
    final today = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => onDateSelected(selectedDate.subtract(const Duration(days: 7))),
                color: AppTheme.textSecondary,
              ),
              Text(
                '${DateFormat('MMM d').format(_weekStart)} - ${DateFormat('MMM d, yyyy').format(_weekStart.add(const Duration(days: 6)))}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => onDateSelected(selectedDate.add(const Duration(days: 7))),
                color: AppTheme.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children:
                days.map((day) {
                  final isSelected =
                      day.year == selectedDate.year && day.month == selectedDate.month && day.day == selectedDate.day;
                  final isToday = day.year == today.year && day.month == today.month && day.day == today.day;
                  final dateKey = DateTime(day.year, day.month, day.day);
                  final minutes = minutesByDate[dateKey] ?? 0;
                  final hasEntries = minutes > 0;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onDateSelected(day),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppTheme.primaryAccent.withValues(alpha: 0.2)
                                  : isToday
                                  ? AppTheme.secondaryAccent.withValues(alpha: 0.1)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppTheme.primaryAccent
                                    : isToday
                                    ? AppTheme.secondaryAccent.withValues(alpha: 0.5)
                                    : Colors.transparent,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              DateFormat('E').format(day).substring(0, 2),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? AppTheme.primaryAccent : AppTheme.textMuted,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${day.day}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected || isToday ? FontWeight.w700 : FontWeight.w500,
                                color:
                                    isSelected
                                        ? AppTheme.primaryAccent
                                        : isToday
                                        ? AppTheme.secondaryAccent
                                        : AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            if (hasEntries)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.successAccent.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _formatMinutes(minutes),
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.successAccent,
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(color: AppTheme.borderDark, shape: BoxShape.circle),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) {
      return '${hours}h${mins}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${mins}m';
    }
  }
}
