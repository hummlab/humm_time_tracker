import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ApproveHoursActionBar extends StatelessWidget {
  const ApproveHoursActionBar({
    super.key,
    required this.selectedCount,
    required this.isProcessing,
    required this.onReject,
    required this.onApprove,
  });

  final int selectedCount;
  final bool isProcessing;
  final VoidCallback onReject;
  final VoidCallback onApprove;

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
            Expanded(child: Text('$selectedCount entries selected', style: Theme.of(context).textTheme.bodyMedium)),
            OutlinedButton.icon(
              onPressed: isProcessing ? null : onReject,
              icon: const Icon(Icons.close, size: 18),
              label: const Text('Reject'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.tertiaryAccent,
                side: const BorderSide(color: AppTheme.tertiaryAccent),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: isProcessing ? null : onApprove,
              icon:
                  isProcessing
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryDark),
                      )
                      : const Icon(Icons.check),
              label: const Text('Approve'),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.successAccent),
            ),
          ],
        ),
      ),
    );
  }
}
