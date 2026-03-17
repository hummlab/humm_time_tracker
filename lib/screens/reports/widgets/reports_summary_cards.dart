import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsSummaryCards extends StatelessWidget {
  const ReportsSummaryCards({super.key, required this.totalMinutes, required this.uniqueDays});

  final int totalMinutes;
  final int uniqueDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _StatCard(
            label: 'Total Time',
            value: _formatMinutes(totalMinutes),
            icon: Icons.access_time,
            color: AppTheme.primaryAccent,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _StatCard(
            label: 'Days Worked',
            value: '$uniqueDays',
            icon: Icons.calendar_today,
            color: AppTheme.successAccent,
          ),
        ),
      ],
    );
  }

  String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) return '${hours}h ${mins}m';
    if (hours > 0) return '${hours}h';
    return '${mins}m';
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}
