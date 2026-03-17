import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class JiraCredentialsSection extends StatelessWidget {
  const JiraCredentialsSection({
    super.key,
    required this.domainController,
    required this.emailController,
    required this.apiTokenController,
    required this.hasToken,
    required this.isSaving,
    required this.isTesting,
    required this.onTestConnection,
    required this.onSave,
  });

  final TextEditingController domainController;
  final TextEditingController emailController;
  final TextEditingController apiTokenController;
  final bool hasToken;
  final bool isSaving;
  final bool isTesting;
  final VoidCallback onTestConnection;
  final VoidCallback onSave;

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
                    Text('Credentials', style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      hasToken ? 'Configured ✓' : 'Enter Jira credentials',
                      style: TextStyle(fontSize: 12, color: hasToken ? AppTheme.successAccent : AppTheme.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: domainController,
            decoration: const InputDecoration(
              labelText: 'Domain',
              hintText: 'yourcompany',
              suffixText: '.atlassian.net',
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email', hintText: 'name@company.com', isDense: true),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: apiTokenController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'API Token', hintText: 'Paste your token', isDense: true),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isTesting ? null : onTestConnection,
                  icon:
                      isTesting
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.link, size: 18),
                  label: const Text('Test Connection'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: isSaving ? null : onSave,
                  child:
                      isSaving
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Save'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Create API token in Atlassian profile settings',
            style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }
}
