import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClientDashboardMonthSelector extends StatelessWidget {
  const ClientDashboardMonthSelector({
    super.key,
    required this.selectedMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onPickMonth,
  });

  final DateTime selectedMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final VoidCallback onPickMonth;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentMonth = selectedMonth.year == now.year && selectedMonth.month == now.month;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: onPreviousMonth, color: AppTheme.textSecondary),
          const SizedBox(width: 16),
          InkWell(
            onTap: onPickMonth,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, size: 20, color: AppTheme.primaryAccent),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('MMMM yyyy').format(selectedMonth),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppTheme.primaryAccent, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_drop_down, size: 20, color: AppTheme.primaryAccent),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: isCurrentMonth ? null : onNextMonth,
            color: isCurrentMonth ? AppTheme.textMuted : AppTheme.textSecondary,
          ),
        ],
      ),
    );
  }
}
