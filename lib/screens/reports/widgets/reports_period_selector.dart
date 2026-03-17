import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/screens/reports/cubit/reports_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsPeriodSelector extends StatelessWidget {
  const ReportsPeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.selectedRange,
    required this.onSelectPeriod,
  });

  final ReportPeriod selectedPeriod;
  final DateTimeRange selectedRange;
  final ValueChanged<ReportPeriod> onSelectPeriod;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.date_range, size: 18, color: AppTheme.primaryAccent),
              const SizedBox(width: 8),
              Text(
                'Report Period',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: AppTheme.primaryAccent),
                    const SizedBox(width: 6),
                    Text(
                      '${DateFormat('MMM d, yyyy').format(selectedRange.start)} - ${DateFormat('MMM d, yyyy').format(selectedRange.end)}',
                      style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                ReportPeriod.values.map((period) {
                  final isSelected = selectedPeriod == period;
                  return GestureDetector(
                    onTap: () => onSelectPeriod(period),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.2) : AppTheme.surfaceDark,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(period.icon, size: 18, color: isSelected ? AppTheme.primaryAccent : AppTheme.textMuted),
                          const SizedBox(width: 8),
                          Text(
                            period.displayName,
                            style: TextStyle(
                              color: isSelected ? AppTheme.primaryAccent : AppTheme.textSecondary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
