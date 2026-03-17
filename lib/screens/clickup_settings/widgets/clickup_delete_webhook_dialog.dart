import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

Future<bool?> showClickUpDeleteWebhookDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: AppTheme.cardDark,
          title: const Text('Remove Webhook?'),
          content: const Text(
            'This will disable real-time task updates. '
            'You will need to manually sync to get new tasks.',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: AppTheme.tertiaryAccent),
              child: const Text('Remove'),
            ),
          ],
        ),
  );
}
