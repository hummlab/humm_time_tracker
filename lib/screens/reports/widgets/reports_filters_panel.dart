import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/screens/reports/widgets/report_filters_dropdowns.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsFiltersPanel extends StatelessWidget {
  const ReportsFiltersPanel({
    super.key,
    required this.isDesktop,
    required this.canChangeMembers,
    required this.hasFilters,
    required this.members,
    required this.projects,
    required this.clients,
    required this.tags,
    required this.selectedMemberIds,
    required this.selectedProjectIds,
    required this.selectedClientIds,
    required this.selectedTagIds,
    required this.onClearFilters,
    required this.onMembersChanged,
    required this.onProjectsChanged,
    required this.onClientsChanged,
    required this.onTagsChanged,
  });

  final bool isDesktop;
  final bool canChangeMembers;
  final bool hasFilters;
  final List<TeamMember> members;
  final List<Project> projects;
  final List<Client> clients;
  final List<Tag> tags;
  final List<String> selectedMemberIds;
  final List<String> selectedProjectIds;
  final List<String> selectedClientIds;
  final List<String> selectedTagIds;
  final VoidCallback onClearFilters;
  final ValueChanged<List<String>> onMembersChanged;
  final ValueChanged<List<String>> onProjectsChanged;
  final ValueChanged<List<String>> onClientsChanged;
  final ValueChanged<List<String>> onTagsChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              const Icon(Icons.filter_list, size: 18, color: AppTheme.primaryAccent),
              const SizedBox(width: 8),
              Text('Filters', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary)),
              const Spacer(),
              if (hasFilters) TextButton(onPressed: onClearFilters, child: const Text('Clear All')),
            ],
          ),
          const SizedBox(height: 16),
          if (isDesktop)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ReportMembersDropdown(
                        members: members,
                        selectedMemberIds: selectedMemberIds,
                        onChanged: canChangeMembers ? onMembersChanged : null,
                        isDisabled: !canChangeMembers,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ReportProjectsDropdown(
                        projects: projects,
                        selectedProjectIds: selectedProjectIds,
                        onChanged: onProjectsChanged,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ReportClientsDropdown(
                        clients: clients,
                        selectedClientIds: selectedClientIds,
                        onChanged: onClientsChanged,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ReportTagsDropdown(tags: tags, selectedTagIds: selectedTagIds, onChanged: onTagsChanged),
                    ),
                  ],
                ),
              ],
            )
          else
            Column(
              children: [
                ReportMembersDropdown(
                  members: members,
                  selectedMemberIds: selectedMemberIds,
                  onChanged: canChangeMembers ? onMembersChanged : null,
                  isDisabled: !canChangeMembers,
                ),
                const SizedBox(height: 12),
                ReportProjectsDropdown(
                  projects: projects,
                  selectedProjectIds: selectedProjectIds,
                  onChanged: onProjectsChanged,
                ),
                const SizedBox(height: 12),
                ReportClientsDropdown(
                  clients: clients,
                  selectedClientIds: selectedClientIds,
                  onChanged: onClientsChanged,
                ),
                const SizedBox(height: 12),
                ReportTagsDropdown(tags: tags, selectedTagIds: selectedTagIds, onChanged: onTagsChanged),
              ],
            ),
        ],
      ),
    );
  }
}
