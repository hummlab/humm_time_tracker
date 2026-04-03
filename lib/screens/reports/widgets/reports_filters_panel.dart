import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/screens/reports/widgets/report_filters_dropdowns.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsFiltersPanel extends StatefulWidget {
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
  State<ReportsFiltersPanel> createState() => _ReportsFiltersPanelState();
}

class _ReportsFiltersPanelState extends State<ReportsFiltersPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final filtersContent =
        widget.isDesktop
            ? Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ReportMembersDropdown(
                        members: widget.members,
                        selectedMemberIds: widget.selectedMemberIds,
                        onChanged:
                            widget.canChangeMembers
                                ? widget.onMembersChanged
                                : null,
                        isDisabled: !widget.canChangeMembers,
                        compact: false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ReportProjectsDropdown(
                        projects: widget.projects,
                        selectedProjectIds: widget.selectedProjectIds,
                        onChanged: widget.onProjectsChanged,
                        compact: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ReportClientsDropdown(
                        clients: widget.clients,
                        selectedClientIds: widget.selectedClientIds,
                        onChanged: widget.onClientsChanged,
                        compact: false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ReportTagsDropdown(
                        tags: widget.tags,
                        selectedTagIds: widget.selectedTagIds,
                        onChanged: widget.onTagsChanged,
                        compact: false,
                      ),
                    ),
                  ],
                ),
              ],
            )
            : Column(
              children: [
                ReportMembersDropdown(
                  members: widget.members,
                  selectedMemberIds: widget.selectedMemberIds,
                  onChanged:
                      widget.canChangeMembers ? widget.onMembersChanged : null,
                  isDisabled: !widget.canChangeMembers,
                  compact: true,
                ),
                const SizedBox(height: 8),
                ReportProjectsDropdown(
                  projects: widget.projects,
                  selectedProjectIds: widget.selectedProjectIds,
                  onChanged: widget.onProjectsChanged,
                  compact: true,
                ),
                const SizedBox(height: 8),
                ReportClientsDropdown(
                  clients: widget.clients,
                  selectedClientIds: widget.selectedClientIds,
                  onChanged: widget.onClientsChanged,
                  compact: true,
                ),
                const SizedBox(height: 8),
                ReportTagsDropdown(
                  tags: widget.tags,
                  selectedTagIds: widget.selectedTagIds,
                  onChanged: widget.onTagsChanged,
                  compact: true,
                ),
              ],
            );

    return Container(
      padding: EdgeInsets.all(widget.isDesktop ? 16 : 10),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isDesktop) ...[
            _FiltersHeader(
              hasFilters: widget.hasFilters,
              onClearFilters: widget.onClearFilters,
            ),
            const SizedBox(height: 12),
            filtersContent,
          ] else
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 6),
              childrenPadding: const EdgeInsets.fromLTRB(6, 0, 6, 6),
              dense: true,
              trailing: const SizedBox.shrink(),
              shape: const Border(),
              collapsedShape: const Border(),
              onExpansionChanged:
                  (value) => setState(() => _isExpanded = value),
              initiallyExpanded: false,
              title: _FiltersHeader(
                hasFilters: widget.hasFilters,
                onClearFilters: widget.onClearFilters,
                compact: true,
                isExpanded: _isExpanded,
              ),
              children: [filtersContent],
            ),
        ],
      ),
    );
  }
}

class _FiltersHeader extends StatelessWidget {
  const _FiltersHeader({
    required this.hasFilters,
    required this.onClearFilters,
    this.compact = false,
    this.isExpanded = false,
  });

  final bool hasFilters;
  final VoidCallback onClearFilters;
  final bool compact;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.filter_list, size: 16, color: AppTheme.primaryAccent),
        const SizedBox(width: 8),
        Text(
          'Filters',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary),
        ),
        if (compact && hasFilters) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'active',
              style: TextStyle(
                color: AppTheme.primaryAccent,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        const Spacer(),
        if (hasFilters)
          TextButton(
            onPressed: onClearFilters,
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            child: const Text('Clear'),
          ),
        if (compact)
          Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppTheme.textMuted,
          ),
      ],
    );
  }
}
