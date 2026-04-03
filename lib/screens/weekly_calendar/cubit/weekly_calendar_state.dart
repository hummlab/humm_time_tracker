import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/time/time_entry.dart';

part 'weekly_calendar_state.freezed.dart';

@freezed
class WeeklyCalendarState with _$WeeklyCalendarState {
  const factory WeeklyCalendarState({
    required DateTime weekStart,
    required List<TimeEntry> weekEntries,
    required int weekTotalMinutes,
    String? currentUserId,
  }) = _WeeklyCalendarState;

  factory WeeklyCalendarState.initial() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final normalized = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return WeeklyCalendarState(
      weekStart: normalized,
      weekEntries: const [],
      weekTotalMinutes: 0,
      currentUserId: null,
    );
  }
}
