import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClickUpSyncStatusSection extends StatelessWidget {
  const ClickUpSyncStatusSection({
    super.key,
    required this.lastSyncAt,
    required this.lastSyncTaskCount,
    required this.selectedListCount,
  });

  final DateTime? lastSyncAt;
  final int lastSyncTaskCount;
  final int selectedListCount;

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
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.info_outline, color: AppTheme.secondaryAccent, size: 20),
              ),
              const SizedBox(width: 12),
              Text('Sync Status', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          _StatRow(label: 'Last Sync', value: lastSyncAt != null ? _formatDateTime(lastSyncAt!) : 'Never'),
          const SizedBox(height: 8),
          _StatRow(label: 'Tasks Synced', value: '$lastSyncTaskCount'),
          const SizedBox(height: 8),
          _StatRow(label: 'Selected Lists', value: '$selectedListCount'),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inDays < 1) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
        Text(value, style: TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
