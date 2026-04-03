import 'dart:async';

import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_providers/time/time_data_provider.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';

import 'weekly_calendar_state.dart';

class WeeklyCalendarCubit extends BaseCubit<WeeklyCalendarState> {
  WeeklyCalendarCubit(this._timeDataProvider, this._authDataProvider)
    : super(WeeklyCalendarState.initial()) {
    _timeDataProvider.addListener(_syncFromProvider);
    _authDataProvider.addListener(_syncFromProvider);
    _syncFromProvider();
  }

  final TimeDataProvider _timeDataProvider;
  final AuthDataProvider _authDataProvider;

  DateTime _normalizeWeekStart(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final monday = normalizedDate.subtract(
      Duration(days: normalizedDate.weekday - 1),
    );
    return DateTime(monday.year, monday.month, monday.day);
  }

  void _syncFromProvider() {
    final weekStart = _normalizeWeekStart(state.weekStart);
    if (weekStart != state.weekStart) {
      emit(state.copyWith(weekStart: weekStart));
    }
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

    emit(
      state.copyWith(
        weekEntries: entries,
        weekTotalMinutes: totalMinutes,
        currentUserId: currentUserId,
      ),
    );
  }

  void previousWeek() {
    final newStart = _normalizeWeekStart(
      state.weekStart.subtract(const Duration(days: 7)),
    );
    emit(state.copyWith(weekStart: newStart));
    _syncFromProvider();
  }

  void nextWeek() {
    final newStart = _normalizeWeekStart(
      state.weekStart.add(const Duration(days: 7)),
    );
    emit(state.copyWith(weekStart: newStart));
    _syncFromProvider();
  }

  void setWeekStart(DateTime weekStart) {
    emit(state.copyWith(weekStart: _normalizeWeekStart(weekStart)));
    _syncFromProvider();
  }

  void updateTimeEntry(TimeEntry entry) {
    _applyOptimisticEntryUpdate(entry);
    unawaited(_timeDataProvider.updateTimeEntry(entry));
  }

  void deleteTimeEntry(String id) {
    final updatedWeekEntries =
        state.weekEntries.where((entry) => entry.id != id).toList();
    final weekTotalMinutes = updatedWeekEntries.fold<int>(
      0,
      (sum, e) => sum + e.durationMinutes,
    );
    emit(
      state.copyWith(
        weekEntries: updatedWeekEntries,
        weekTotalMinutes: weekTotalMinutes,
      ),
    );

    unawaited(_timeDataProvider.deleteTimeEntry(id));
  }

  void addTimeEntry(
    String description,
    int durationMinutes,
    DateTime date, {
    String? projectId,
    List<String>? tagIds,
    DateTime? startTime,
  }) {
    final currentUserId = _timeDataProvider.currentUserId;
    if (currentUserId != null) {
      final optimisticEntry = TimeEntry(
        id: 'local_${DateTime.now().microsecondsSinceEpoch}',
        description: description,
        durationMinutes: durationMinutes,
        date: DateTime(date.year, date.month, date.day),
        projectId: projectId,
        tagIds: tagIds ?? const [],
        createdByUserId: currentUserId,
        createdAt: DateTime.now(),
        startTime: startTime,
      );
      final updatedWeekEntries = [...state.weekEntries, optimisticEntry];
      final weekTotalMinutes = updatedWeekEntries.fold<int>(
        0,
        (sum, e) => sum + e.durationMinutes,
      );
      emit(
        state.copyWith(
          weekEntries: updatedWeekEntries,
          weekTotalMinutes: weekTotalMinutes,
        ),
      );
    }

    unawaited(
      _timeDataProvider.addTimeEntry(
        description,
        durationMinutes,
        date,
        projectId: projectId,
        tagIds: tagIds,
        startTime: startTime,
      ),
    );
  }

  bool hasOverlap(TimeEntry candidate) {
    final visibleEntries = _timeDataProvider.timeEntries.where((entry) {
      final currentUserId = _timeDataProvider.currentUserId;
      if (_authDataProvider.hasManagerAccess) {
        return true;
      }
      return entry.createdByUserId == currentUserId;
    });

    for (final entry in visibleEntries) {
      if (entry.id == candidate.id) continue;
      if (entry.date.year != candidate.date.year ||
          entry.date.month != candidate.date.month ||
          entry.date.day != candidate.date.day) {
        continue;
      }

      final entryStart = entry.startTime ?? entry.date;
      final entryEnd = entryStart.add(Duration(minutes: entry.durationMinutes));
      final candidateStart = candidate.startTime ?? candidate.date;
      final candidateEnd = candidateStart.add(
        Duration(minutes: candidate.durationMinutes),
      );

      if (candidateStart.isBefore(entryEnd) &&
          candidateEnd.isAfter(entryStart)) {
        return true;
      }
    }

    return false;
  }

  TimeDataProvider get timeDataProvider => _timeDataProvider;

  List<Project> get projects {
    final TeamMember? currentMember =
        _timeDataProvider.getCurrentUserTeamMember();
    return _timeDataProvider.getProjectsForUser(
      hasManagerAccess: _authDataProvider.hasManagerAccess,
      teamMemberId: currentMember?.id,
    );
  }

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
    _authDataProvider.removeListener(_syncFromProvider);
    super.dispose();
  }

  void _applyOptimisticEntryUpdate(TimeEntry updatedEntry) {
    final updatedWeekEntries =
        state.weekEntries
            .map((entry) => entry.id == updatedEntry.id ? updatedEntry : entry)
            .toList();
    final weekTotalMinutes = updatedWeekEntries.fold<int>(
      0,
      (sum, e) => sum + e.durationMinutes,
    );
    emit(
      state.copyWith(
        weekEntries: updatedWeekEntries,
        weekTotalMinutes: weekTotalMinutes,
      ),
    );
  }
}
