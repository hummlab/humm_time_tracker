import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClientsEmptyState extends StatelessWidget {
  const ClientsEmptyState({super.key, required this.onAddClient});

  final VoidCallback onAddClient;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppTheme.warningAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.business_outlined, size: 64, color: AppTheme.warningAccent),
          ),
          const SizedBox(height: 24),
          Text('No clients yet', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Add clients to organize your projects', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          ElevatedButton.icon(onPressed: onAddClient, icon: const Icon(Icons.add), label: const Text('Add Client')),
        ],
      ),
    );
  }
}
