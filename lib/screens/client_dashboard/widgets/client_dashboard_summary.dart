import 'package:flutter/material.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClientDashboardSummary extends StatelessWidget {
  const ClientDashboardSummary({super.key, required this.entries});

  final List<TimeEntry> entries;

  @override
  Widget build(BuildContext context) {
    final totalMinutes = entries.fold<int>(0, (sum, entry) => sum + entry.durationMinutes);
    final totalHours = totalMinutes / 60;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.access_time, color: AppTheme.primaryAccent, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Hours', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  '${totalHours.toStringAsFixed(1)}h',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: AppTheme.primaryAccent, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: AppTheme.surfaceDark, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Text(
                  entries.length.toString(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text('entries', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
