import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class SubmitHoursSubmitBar extends StatelessWidget {
  const SubmitHoursSubmitBar({
    super.key,
    required this.selectedCount,
    required this.totalMinutes,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final int selectedCount;
  final int totalMinutes;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(top: BorderSide(color: AppTheme.borderDark)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$selectedCount entries selected',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_formatDuration(totalMinutes)} total',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: isSubmitting ? null : onSubmit,
              icon:
                  isSubmitting
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryDark),
                      )
                      : const Icon(Icons.send),
              label: const Text('Submit for Approval'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    }
    if (hours > 0) {
      return '${hours}h';
    }
    return '${minutes}m';
  }
}
