import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClickUpApiTokenSection extends StatelessWidget {
  const ClickUpApiTokenSection({
    super.key,
    required this.controller,
    required this.hasToken,
    required this.isSaving,
    required this.onSave,
  });

  final TextEditingController controller;
  final bool hasToken;
  final bool isSaving;
  final ValueChanged<String> onSave;

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
                  color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.key, color: AppTheme.primaryAccent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('API Token', style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      hasToken ? 'Token configured ✓' : 'Enter your ClickUp API token',
                      style: TextStyle(fontSize: 12, color: hasToken ? AppTheme.successAccent : AppTheme.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: hasToken ? 'Enter new token to update' : 'pk_xxxxxxxx...',
                    isDense: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.paste, size: 18),
                      onPressed: () async {
                        final data = await Clipboard.getData('text/plain');
                        if (data?.text != null) {
                          controller.text = data!.text!;
                        }
                      },
                      tooltip: 'Paste from clipboard',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: isSaving ? null : () => onSave(controller.text),
                child:
                    isSaving
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Save'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Get your API token from ClickUp Settings > Apps > API Token',
            style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }
}
