import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/time/grid_row.dart';
import 'package:time_tracker/theme/app_theme.dart';

class WeeklyGridTable extends StatelessWidget {
  const WeeklyGridTable({
    super.key,
    required this.weekStart,
    required this.rows,
    required this.getProjectById,
    required this.onEditCell,
  });

  final DateTime weekStart;
  final List<GridRow> rows;
  final Project? Function(String? id) getProjectById;
  final void Function(GridRow row, int dayIndex) onEditCell;

  @override
  Widget build(BuildContext context) {
    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));

    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 24,
            dataRowMinHeight: 60,
            dataRowMaxHeight: 80,
            headingRowColor: WidgetStateProperty.all(AppTheme.surfaceDark),
            columns: [
              const DataColumn(label: Text('PROJECT / DESCRIPTION', style: TextStyle(color: AppTheme.textMuted))),
              ...days.map(
                (day) => DataColumn(
                  label: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E').format(day).toUpperCase(),
                        style: const TextStyle(fontSize: 10, color: AppTheme.textMuted),
                      ),
                      Text(
                        DateFormat('d').format(day),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const DataColumn(label: Text('TOTAL', style: TextStyle(color: AppTheme.textMuted))),
            ],
            rows: [...rows.map((row) => _buildDataRow(row)), _buildTotalRow(rows)],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(GridRow row) {
    final project = getProjectById(row.projectId);
    final projectColor = project != null ? AppTheme.colorFromHex(project.color) : AppTheme.textMuted;

    return DataRow(
      cells: [
        DataCell(
          Container(
            width: 250,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (project != null)
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(color: projectColor, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        project.name,
                        style: TextStyle(color: projectColor, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                Text(
                  row.description,
                  style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
        ...List.generate(
          7,
          (i) => DataCell(
            GestureDetector(
              onTap: () => onEditCell(row, i),
              child: Container(
                width: 60,
                alignment: Alignment.center,
                child: Text(
                  _formatDuration(row.dayMinutes[i]),
                  style: TextStyle(
                    color: row.dayMinutes[i] > 0 ? AppTheme.primaryAccent : AppTheme.textMuted,
                    fontWeight: row.dayMinutes[i] > 0 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatDuration(row.totalMinutes),
              style: const TextStyle(color: AppTheme.primaryAccent, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildTotalRow(List<GridRow> rows) {
    final totals = List.filled(7, 0);
    for (final row in rows) {
      for (int i = 0; i < 7; i++) {
        totals[i] += row.dayMinutes[i];
      }
    }
    final grandTotal = totals.fold(0, (a, b) => a + b);

    return DataRow(
      color: WidgetStateProperty.all(AppTheme.surfaceDark.withValues(alpha: 0.5)),
      cells: [
        const DataCell(
          Text('WEEK TOTAL', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textSecondary)),
        ),
        ...totals.map(
          (t) => DataCell(
            Center(
              child: Text(
                _formatDuration(t),
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textSecondary),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.successAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatDuration(grandTotal),
              style: const TextStyle(color: AppTheme.successAccent, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDuration(int minutes) {
    if (minutes == 0) return '-';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0) {
      return '${hours}h${mins > 0 ? ' ${mins}m' : ''}';
    }
    return '${mins}m';
  }
}
