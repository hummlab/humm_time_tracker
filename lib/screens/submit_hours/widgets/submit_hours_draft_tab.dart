import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_models.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_state.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_empty_state.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_entries_list.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_submit_bar.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_summary_bar.dart';
import 'package:time_tracker/theme/app_theme.dart';

class SubmitHoursDraftTab extends StatelessWidget {
  const SubmitHoursDraftTab({
    super.key,
    required this.sections,
    required this.entryCount,
    required this.totalMinutes,
    required this.selectedCount,
    required this.selectedTotalMinutes,
    required this.isSubmitting,
    required this.isDesktop,
    required this.isAllSelected,
    required this.activeQuickSelect,
    required this.getProjectById,
    required this.getTagById,
    required this.isSelected,
    required this.onToggleEntry,
    required this.onToggleSelectAll,
    required this.onSelectThisMonth,
    required this.onSelectLastMonth,
    required this.onSubmit,
  });

  final List<SubmitHoursDateSection> sections;
  final int entryCount;
  final int totalMinutes;
  final int selectedCount;
  final int selectedTotalMinutes;
  final bool isSubmitting;
  final bool isDesktop;
  final bool isAllSelected;
  final SubmitHoursQuickSelectPeriod activeQuickSelect;
  final Project? Function(String? id) getProjectById;
  final Tag? Function(String id) getTagById;
  final bool Function(String id) isSelected;
  final ValueChanged<String> onToggleEntry;
  final VoidCallback onToggleSelectAll;
  final VoidCallback onSelectThisMonth;
  final VoidCallback onSelectLastMonth;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    if (entryCount == 0) {
      return const SubmitHoursEmptyState(
        icon: Icons.check_circle_outline,
        title: 'All caught up!',
        subtitle: 'No draft entries to submit. Log some time first.',
        color: AppTheme.successAccent,
      );
    }

    return Column(
      children: [
        SubmitHoursSummaryBar(
          entryCount: entryCount,
          totalMinutes: totalMinutes,
          mode: SubmitHoursSummaryMode.draft,
          showSelectionControls: true,
          isAllSelected: isAllSelected,
          onToggleSelectAll: onToggleSelectAll,
          activeQuickSelect: activeQuickSelect,
          onSelectThisMonth: onSelectThisMonth,
          onSelectLastMonth: onSelectLastMonth,
        ),
        Expanded(
          child: SubmitHoursEntriesList(
            sections: sections,
            isForReview: false,
            isDesktop: isDesktop,
            getProjectById: getProjectById,
            getTagById: getTagById,
            isSelected: isSelected,
            onToggleEntry: onToggleEntry,
          ),
        ),
        if (selectedCount > 0)
          SubmitHoursSubmitBar(
            selectedCount: selectedCount,
            totalMinutes: selectedTotalMinutes,
            isSubmitting: isSubmitting,
            onSubmit: onSubmit,
          ),
      ],
    );
  }
}
