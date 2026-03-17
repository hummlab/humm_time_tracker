import 'package:flutter/material.dart';
import 'package:time_tracker/models/integrations/jira_issue.dart';
import 'package:time_tracker/theme/app_theme.dart';

class JiraProjectsSection extends StatelessWidget {
  const JiraProjectsSection({
    super.key,
    required this.isConfigured,
    required this.projects,
    required this.projectsLoaded,
    required this.selectedProjectIds,
    required this.onToggleProject,
  });

  final bool isConfigured;
  final List<JiraProject> projects;
  final bool projectsLoaded;
  final List<String> selectedProjectIds;
  final ValueChanged<String> onToggleProject;

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
                  color: AppTheme.successAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.work_outline, color: AppTheme.successAccent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Projects', style: Theme.of(context).textTheme.titleMedium),
                    Text('Select Jira projects to sync', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                  ],
                ),
              ),
              if (selectedProjectIds.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAccent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${selectedProjectIds.length} selected',
                    style: const TextStyle(color: AppTheme.primaryAccent, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (!isConfigured)
            Text('Save credentials to load projects', style: TextStyle(fontSize: 12, color: AppTheme.textMuted))
          else if (!projectsLoaded)
            const Center(child: Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator()))
          else if (projects.isEmpty)
            Text('No projects found', style: TextStyle(fontSize: 12, color: AppTheme.textMuted))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                final isSelected = selectedProjectIds.contains(project.id);
                return InkWell(
                  onTap: () => onToggleProject(project.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.1) : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryAccent : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark,
                              width: 2,
                            ),
                          ),
                          child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${project.key} — ${project.name}',
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelected ? AppTheme.primaryAccent : AppTheme.textSecondary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
