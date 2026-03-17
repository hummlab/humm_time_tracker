import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClientDashboardErrorState extends StatelessWidget {
  const ClientDashboardErrorState({super.key, required this.error, required this.onRetry});

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppTheme.tertiaryAccent),
            const SizedBox(height: 16),
            Text('An error occurred', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderDark),
              ),
              child: SelectableText(
                error,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace', color: AppTheme.tertiaryAccent),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap and hold to select and copy the error message',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted, fontSize: 11),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Try Again')),
          ],
        ),
      ),
    );
  }
}
