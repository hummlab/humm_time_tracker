import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClickUpSyncButton extends StatelessWidget {
  const ClickUpSyncButton({super.key, required this.isSyncing, required this.selectedListCount, required this.onSync});

  final bool isSyncing;
  final int selectedListCount;
  final VoidCallback onSync;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: isSyncing || selectedListCount == 0 ? null : onSync,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon:
                isSyncing
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                    : const Icon(Icons.sync),
            label: Text(isSyncing ? 'Syncing...' : 'Sync Tasks ($selectedListCount lists)'),
          ),
          const SizedBox(height: 12),
          Text(
            'This will fetch all tasks from the selected lists and store them in the database. '
            'This may take a while depending on the number of tasks.',
            style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
