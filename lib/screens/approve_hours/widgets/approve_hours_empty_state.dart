import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ApproveHoursEmptyState extends StatelessWidget {
  const ApproveHoursEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppTheme.successAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.check_circle_outline, size: 64, color: AppTheme.successAccent),
          ),
          const SizedBox(height: 24),
          Text('All caught up!', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('No pending time entries to review.', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
