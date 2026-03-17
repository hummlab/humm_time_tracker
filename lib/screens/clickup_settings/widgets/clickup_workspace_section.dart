import 'package:flutter/material.dart';
import 'package:time_tracker/models/integrations/clickup_task.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClickUpWorkspaceSection extends StatelessWidget {
  const ClickUpWorkspaceSection({
    super.key,
    required this.workspaces,
    required this.selectedWorkspaceId,
    required this.onSelectWorkspace,
  });

  final List<ClickUpWorkspace> workspaces;
  final String? selectedWorkspaceId;
  final ValueChanged<String> onSelectWorkspace;

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
                  color: AppTheme.warningAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.workspaces_outlined, color: AppTheme.warningAccent, size: 20),
              ),
              const SizedBox(width: 12),
              Text('Workspace', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          if (workspaces.isEmpty)
            const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  workspaces.map((workspace) {
                    final isSelected = selectedWorkspaceId == workspace.id;
                    return GestureDetector(
                      onTap: () => onSelectWorkspace(workspace.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.2) : AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected) ...[
                              const Icon(Icons.check_circle, size: 16, color: AppTheme.primaryAccent),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              workspace.name,
                              style: TextStyle(
                                color: isSelected ? AppTheme.primaryAccent : AppTheme.textPrimary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
        ],
      ),
    );
  }
}
