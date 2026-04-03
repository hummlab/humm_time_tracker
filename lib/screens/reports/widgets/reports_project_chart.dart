import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportsProjectChart extends StatelessWidget {
  const ReportsProjectChart({
    super.key,
    required this.minutesByProject,
    required this.getProjectById,
  });

  final Map<String, int> minutesByProject;
  final Project? Function(String? id) getProjectById;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final totalMinutes = minutesByProject.values.fold<int>(
      0,
      (sum, value) => sum + value,
    );
    if (minutesByProject.isEmpty) {
      return Container(
        height: isDesktop ? 190 : 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text(
            'No data for selected filters',
            style: TextStyle(color: AppTheme.textMuted),
          ),
        ),
      );
    }

    final entries =
        minutesByProject.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
    final sections =
        entries.map((entry) {
          final project =
              entry.key != 'unassigned' ? getProjectById(entry.key) : null;
          final color =
              project != null
                  ? AppTheme.colorFromHex(project.color)
                  : AppTheme.textMuted;
          return PieChartSectionData(
            value: entry.value.toDouble(),
            title: '',
            color: color,
            radius: isDesktop ? 54 : 48,
          );
        }).toList();

    return Container(
      padding: EdgeInsets.all(isDesktop ? 16 : 12),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time by Project',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 170,
                  height: 170,
                  child: _DonutChart(
                    sections: sections,
                    totalFormatted: _formatMinutes(totalMinutes),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _ChartLegend(
                    entries: entries,
                    totalMinutes: totalMinutes,
                    getProjectById: getProjectById,
                  ),
                ),
              ],
            )
          else ...[
            SizedBox(
              height: 150,
              child: Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: _DonutChart(
                    sections: sections,
                    totalFormatted: _formatMinutes(totalMinutes),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _ChartLegend(
              entries: entries,
              totalMinutes: totalMinutes,
              getProjectById: getProjectById,
            ),
          ],
        ],
      ),
    );
  }

  String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) return '${hours}h ${mins}m';
    if (hours > 0) return '${hours}h';
    return '${mins}m';
  }
}

class _DonutChart extends StatelessWidget {
  const _DonutChart({required this.sections, required this.totalFormatted});

  final List<PieChartSectionData> sections;
  final String totalFormatted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sections: sections,
            sectionsSpace: 2,
            centerSpaceRadius: 34,
          ),
        ),
        Text(
          totalFormatted,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend({
    required this.entries,
    required this.totalMinutes,
    required this.getProjectById,
  });

  final List<MapEntry<String, int>> entries;
  final int totalMinutes;
  final Project? Function(String? id) getProjectById;

  @override
  Widget build(BuildContext context) {
    final visible = entries.take(5).toList();
    return Column(
      children: [
        for (final entry in visible)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        entry.key != 'unassigned' &&
                                getProjectById(entry.key) != null
                            ? AppTheme.colorFromHex(
                              getProjectById(entry.key)!.color,
                            )
                            : AppTheme.textMuted,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    entry.key != 'unassigned'
                        ? (getProjectById(entry.key)?.name ?? 'Unknown')
                        : 'Unassigned',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  totalMinutes == 0
                      ? '0%'
                      : '${((entry.value / totalMinutes) * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
