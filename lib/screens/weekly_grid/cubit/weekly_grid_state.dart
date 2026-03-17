import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/time/grid_row.dart';

part 'weekly_grid_state.freezed.dart';

@freezed
class WeeklyGridState with _$WeeklyGridState {
  const factory WeeklyGridState({
    required DateTime weekStart,
    required List<GridRow> rows,
    required List<Project> projects,
    String? currentUserId,
  }) = _WeeklyGridState;

  factory WeeklyGridState.initial() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final normalized = DateTime(weekStart.year, weekStart.month, weekStart.day);

    return WeeklyGridState(weekStart: normalized, rows: const [], projects: const [], currentUserId: null);
  }
}
