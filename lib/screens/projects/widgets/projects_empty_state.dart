import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ProjectsEmptyState extends StatelessWidget {
  const ProjectsEmptyState({super.key, required this.onAddProject});

  final VoidCallback onAddProject;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppTheme.secondaryAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.folder_outlined, size: 64, color: AppTheme.secondaryAccent),
          ),
          const SizedBox(height: 24),
          Text('No projects yet', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Create your first project to start tracking time', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onAddProject,
            icon: const Icon(Icons.add),
            label: const Text('Create Project'),
          ),
        ],
      ),
    );
  }
}
