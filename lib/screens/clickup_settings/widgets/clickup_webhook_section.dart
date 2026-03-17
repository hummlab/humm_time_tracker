import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClickUpWebhookSection extends StatelessWidget {
  const ClickUpWebhookSection({
    super.key,
    required this.hasWebhook,
    required this.selectedWorkspaceId,
    required this.onEnable,
    required this.onRemove,
  });

  final bool hasWebhook;
  final String? selectedWorkspaceId;
  final VoidCallback onEnable;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: hasWebhook ? AppTheme.successAccent.withValues(alpha: 0.3) : AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      hasWebhook
                          ? AppTheme.successAccent.withValues(alpha: 0.1)
                          : AppTheme.warningAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  hasWebhook ? Icons.sync : Icons.sync_disabled,
                  color: hasWebhook ? AppTheme.successAccent : AppTheme.warningAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Real-time Webhook', style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      hasWebhook
                          ? 'Auto-sync enabled - new tasks appear instantly'
                          : 'Enable to get instant task updates',
                      style: TextStyle(fontSize: 12, color: hasWebhook ? AppTheme.successAccent : AppTheme.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (hasWebhook) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.successAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppTheme.successAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: AppTheme.successAccent.withValues(alpha: 0.5), blurRadius: 6, spreadRadius: 1),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Webhook active - listening for task changes',
                      style: TextStyle(fontSize: 12, color: AppTheme.successAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: onRemove,
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.tertiaryAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('Remove', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: selectedWorkspaceId != null ? onEnable : null,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Enable Webhook'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryAccent,
                      side: BorderSide(color: AppTheme.primaryAccent.withValues(alpha: 0.5)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Webhook will auto-sync tasks when they are created or updated in ClickUp',
              style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
