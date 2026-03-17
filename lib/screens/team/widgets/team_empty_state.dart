import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class TeamEmptyState extends StatelessWidget {
  const TeamEmptyState({super.key, required this.onAddMember});

  final VoidCallback onAddMember;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppTheme.successAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.people_outline, size: 64, color: AppTheme.successAccent),
          ),
          const SizedBox(height: 24),
          Text('No team members yet', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Add team members to assign them to projects', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onAddMember,
            icon: const Icon(Icons.person_add),
            label: const Text('Add Member'),
          ),
        ],
      ),
    );
  }
}
