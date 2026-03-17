import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsProjectChart extends StatelessWidget {
  const ReportsProjectChart({super.key, required this.minutesByProject, required this.getProjectById});

  final Map<String, int> minutesByProject;
  final Project? Function(String? id) getProjectById;

  @override
  Widget build(BuildContext context) {
    if (minutesByProject.isEmpty) {
      return Container(
        height: 250,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderDark),
        ),
        child: const Center(child: Text('No data for selected filters', style: TextStyle(color: AppTheme.textMuted))),
      );
    }

    final sections =
        minutesByProject.entries.map((entry) {
          final project = entry.key != 'unassigned' ? getProjectById(entry.key) : null;
          final color = project != null ? AppTheme.colorFromHex(project.color) : AppTheme.textMuted;
          return PieChartSectionData(value: entry.value.toDouble(), title: '', color: color, radius: 80);
        }).toList();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Time by Project', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(PieChartData(sections: sections, sectionsSpace: 2, centerSpaceRadius: 40)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
