import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/time/time_data_provider.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'weekly_calendar_state.dart';

class WeeklyCalendarCubit extends BaseCubit<WeeklyCalendarState> {
  WeeklyCalendarCubit(this._timeDataProvider) : super(WeeklyCalendarState.initial()) {
    _timeDataProvider.addListener(_syncFromProvider);
    _syncFromProvider();
  }

  final TimeDataProvider _timeDataProvider;

  void _syncFromProvider() {
    final weekStart = state.weekStart;
    final weekEnd = weekStart.add(const Duration(days: 7));
    final currentUserId = _timeDataProvider.currentUserId;

    final entries =
        _timeDataProvider.timeEntries
            .where(
              (e) =>
                  e.createdByUserId == currentUserId &&
                  e.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
                  e.date.isBefore(weekEnd),
            )
            .toList();

    final totalMinutes = entries.fold(0, (sum, e) => sum + e.durationMinutes);

    emit(state.copyWith(weekEntries: entries, weekTotalMinutes: totalMinutes, currentUserId: currentUserId));
  }

  void previousWeek() {
    final newStart = state.weekStart.subtract(const Duration(days: 7));
    emit(state.copyWith(weekStart: newStart));
    _syncFromProvider();
  }

  void nextWeek() {
    final newStart = state.weekStart.add(const Duration(days: 7));
    emit(state.copyWith(weekStart: newStart));
    _syncFromProvider();
  }

  void setWeekStart(DateTime weekStart) {
    emit(state.copyWith(weekStart: weekStart));
    _syncFromProvider();
  }

  void updateTimeEntry(TimeEntry entry) {
    _timeDataProvider.updateTimeEntry(entry);
  }

  void deleteTimeEntry(String id) {
    _timeDataProvider.deleteTimeEntry(id);
  }

  void addTimeEntry(
    String description,
    int durationMinutes,
    DateTime date, {
    String? projectId,
    List<String>? tagIds,
    DateTime? startTime,
  }) {
    _timeDataProvider.addTimeEntry(
      description,
      durationMinutes,
      date,
      projectId: projectId,
      tagIds: tagIds,
      startTime: startTime,
    );
  }

  bool hasOverlap(TimeEntry candidate) {
    for (final entry in _timeDataProvider.timeEntries) {
      if (entry.id == candidate.id) continue;
      if (entry.date.year != candidate.date.year ||
          entry.date.month != candidate.date.month ||
          entry.date.day != candidate.date.day) {
        continue;
      }

      final entryStart = entry.startTime ?? entry.date;
      final entryEnd = entryStart.add(Duration(minutes: entry.durationMinutes));
      final candidateStart = candidate.startTime ?? candidate.date;
      final candidateEnd = candidateStart.add(Duration(minutes: candidate.durationMinutes));

      if (candidateStart.isBefore(entryEnd) && candidateEnd.isAfter(entryStart)) {
        return true;
      }
    }

    return false;
  }

  TimeDataProvider get timeDataProvider => _timeDataProvider;

  List<Project> get projects => _timeDataProvider.projects;

  List<Tag> get tags => _timeDataProvider.tags;

  Project? getProjectById(String? id) {
    return _timeDataProvider.getProjectById(id);
  }

  Tag? getTagById(String id) {
    return _timeDataProvider.getTagById(id);
  }

  @override
  void dispose() {
    _timeDataProvider.removeListener(_syncFromProvider);
    super.dispose();
  }
}
