import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_models.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_state.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_empty_state.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_entries_list.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_summary_bar.dart';
import 'package:time_tracker/theme/app_theme.dart';

class SubmitHoursRejectedTab extends StatelessWidget {
  const SubmitHoursRejectedTab({
    super.key,
    required this.sections,
    required this.entryCount,
    required this.totalMinutes,
    required this.isDesktop,
    required this.activeQuickSelect,
    required this.getProjectById,
    required this.getTagById,
  });

  final List<SubmitHoursDateSection> sections;
  final int entryCount;
  final int totalMinutes;
  final bool isDesktop;
  final SubmitHoursQuickSelectPeriod activeQuickSelect;
  final Project? Function(String? id) getProjectById;
  final Tag? Function(String id) getTagById;

  @override
  Widget build(BuildContext context) {
    if (entryCount == 0) {
      return const SubmitHoursEmptyState(
        icon: Icons.thumb_up_outlined,
        title: 'No rejected entries',
        subtitle: 'All your submissions have been approved.',
        color: AppTheme.successAccent,
      );
    }

    return Column(
      children: [
        SubmitHoursSummaryBar(
          entryCount: entryCount,
          totalMinutes: totalMinutes,
          mode: SubmitHoursSummaryMode.rejected,
          showSelectionControls: false,
          isAllSelected: false,
          onToggleSelectAll: () {},
          activeQuickSelect: activeQuickSelect,
          onSelectThisMonth: () {},
          onSelectLastMonth: () {},
        ),
        Expanded(
          child: SubmitHoursEntriesList(
            sections: sections,
            isForReview: true,
            isDesktop: isDesktop,
            getProjectById: getProjectById,
            getTagById: getTagById,
            isSelected: (_) => false,
            onToggleEntry: (_) {},
          ),
        ),
      ],
    );
  }
}
