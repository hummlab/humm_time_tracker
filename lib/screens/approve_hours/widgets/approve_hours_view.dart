import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/screens/approve_hours/cubit/approve_hours_state.dart';
import 'package:time_tracker/screens/approve_hours/widgets/approve_hours_action_bar.dart';
import 'package:time_tracker/screens/approve_hours/widgets/approve_hours_entries_list.dart';
import 'package:time_tracker/screens/approve_hours/widgets/approve_hours_filters_bar.dart';
import 'package:time_tracker/screens/approve_hours/widgets/approve_hours_summary_bar.dart';

class ApproveHoursView extends StatelessWidget {
  const ApproveHoursView({
    super.key,
    required this.state,
    required this.isDesktop,
    required this.onSelectUser,
    required this.onToggleSelectAll,
    required this.onToggleEntry,
    required this.getProjectById,
    required this.onApproveSelected,
    required this.onRejectSelected,
  });

  final ApproveHoursState state;
  final bool isDesktop;
  final ValueChanged<String?> onSelectUser;
  final VoidCallback onToggleSelectAll;
  final ValueChanged<String> onToggleEntry;
  final Project? Function(String? id) getProjectById;
  final VoidCallback onApproveSelected;
  final VoidCallback onRejectSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ApproveHoursFiltersBar(
          users: state.usersWithPending,
          totalCount: state.pendingEntries.length,
          selectedUserId: state.filterByUserId,
          pendingCountsByUserId: state.pendingCountsByUserId,
          onSelectUser: onSelectUser,
        ),
        ApproveHoursSummaryBar(
          entryCount: state.filteredEntries.length,
          totalMinutes: state.totalMinutes,
          selectedCount: state.selectedEntryIds.length,
          onToggleSelectAll: onToggleSelectAll,
        ),
        Expanded(
          child: ApproveHoursEntriesList(
            sections: state.userSections,
            getProjectById: getProjectById,
            isSelected: (entryId) => state.selectedEntryIds.contains(entryId),
            onToggleEntry: onToggleEntry,
            isDesktop: isDesktop,
          ),
        ),
        if (state.selectedEntryIds.isNotEmpty)
          ApproveHoursActionBar(
            selectedCount: state.selectedEntryIds.length,
            isProcessing: state.isProcessing,
            onReject: onRejectSelected,
            onApprove: onApproveSelected,
          ),
      ],
    );
  }
}
