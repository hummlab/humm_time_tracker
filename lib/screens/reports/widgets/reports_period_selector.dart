import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/screens/reports/cubit/reports_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsPeriodSelector extends StatelessWidget {
  const ReportsPeriodSelector({
    super.key,
    required this.isDesktop,
    required this.selectedPeriod,
    required this.selectedRange,
    required this.onSelectPeriod,
    required this.onSelectCustomRange,
  });

  final bool isDesktop;
  final ReportPeriod selectedPeriod;
  final DateTimeRange selectedRange;
  final ValueChanged<ReportPeriod> onSelectPeriod;
  final VoidCallback onSelectCustomRange;

  @override
  Widget build(BuildContext context) {
    final rangeText =
        '${DateFormat("MMM d, yyyy").format(selectedRange.start)} - ${DateFormat("MMM d, yyyy").format(selectedRange.end)}';

    final quickPeriods =
        ReportPeriod.values
            .where((period) => period != ReportPeriod.custom)
            .toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 16 : 12),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: InkWell(
              onTap: onSelectCustomRange,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppTheme.primaryAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rangeText,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                quickPeriods.map((period) {
                  final isSelected = selectedPeriod == period;
                  return GestureDetector(
                    onTap: () => onSelectPeriod(period),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppTheme.primaryAccent.withValues(alpha: 0.2)
                                : AppTheme.surfaceDark,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppTheme.primaryAccent
                                  : AppTheme.borderDark,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            period.icon,
                            size: 16,
                            color:
                                isSelected
                                    ? AppTheme.primaryAccent
                                    : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            period.displayName,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? AppTheme.primaryAccent
                                      : AppTheme.textSecondary,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                              fontSize: 12,
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
