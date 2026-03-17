import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class WeeklyGridEmptyState extends StatelessWidget {
  const WeeklyGridEmptyState({super.key, required this.onAddRow});

  final VoidCallback onAddRow;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.grid_on, size: 64, color: AppTheme.textMuted.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          const Text('No entries for this week', style: TextStyle(color: AppTheme.textMuted)),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: onAddRow, child: const Text('Add your first row')),
        ],
      ),
    );
  }
}
