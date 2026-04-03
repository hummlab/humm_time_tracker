import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_providers/time/time_data_provider.dart';
import 'package:time_tracker/models/integrations/clickup_task.dart';
import 'package:time_tracker/models/integrations/jira_issue.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/widgets/app_toast.dart';

import 'time_tracking_state.dart';

class TimeTrackingCubit extends BaseCubit<TimeTrackingState> {
  TimeTrackingCubit(this._timeDataProvider, this._authDataProvider)
    : super(TimeTrackingState.initial()) {
    _timeDataProvider.addListener(_syncFromProvider);
    _authDataProvider.addListener(_syncFromProvider);
    _syncFromProvider();
  }

  final TimeDataProvider _timeDataProvider;
  final AuthDataProvider _authDataProvider;

  void _syncFromProvider() {
    final selectedDate = _timeDataProvider.selectedDate;
    final weekStart = selectedDate.subtract(
      Duration(days: selectedDate.weekday - 1),
    );

    emit(
      state.copyWith(
        selectedDate: selectedDate,
        entriesForDate: _timeDataProvider.getEntriesForDate(selectedDate),
        weekEntries: _timeDataProvider.getEntriesForWeek(weekStart),
        projects: _timeDataProvider.projects,
        tags: _timeDataProvider.tags,
        activeTimer: _timeDataProvider.activeTimer,
        hasActiveTimer: _timeDataProvider.hasActiveTimer,
        currentUserId: _timeDataProvider.currentUserId,
        currentMember: _timeDataProvider.getCurrentUserTeamMember(),
        hasManagerAccess: _authDataProvider.hasManagerAccess,
      ),
    );
  }

  void setSelectedDate(DateTime date) {
    _timeDataProvider.setSelectedDate(date);
  }

  void startEditing(TimeEntry entry) {
    emit(state.copyWith(editingEntry: entry));
  }

  void stopEditing() {
    emit(state.copyWith(editingEntry: null));
  }

  TimeDataProvider get timeDataProvider => _timeDataProvider;
  AuthDataProvider get authDataProvider => _authDataProvider;

  DateTime get selectedDate => state.selectedDate;

  List<Project> get projects => state.projects;

  List<Tag> get tags => state.tags;

  Project? getProjectById(String? id) {
    return _timeDataProvider.getProjectById(id);
  }

  Project? getProjectByClickUpListId(String listId) {
    return _timeDataProvider.getProjectByClickUpListId(listId);
  }

  Tag? getTagById(String id) {
    return _timeDataProvider.getTagById(id);
  }

  TeamMember? getCurrentUserTeamMember() {
    return _timeDataProvider.getCurrentUserTeamMember();
  }

  List<Project> getProjectsForUser({
    required bool hasManagerAccess,
    String? teamMemberId,
  }) {
    return _timeDataProvider.getProjectsForUser(
      hasManagerAccess: hasManagerAccess,
      teamMemberId: teamMemberId,
    );
  }

  void startTimer({
    required String description,
    String? projectId,
    List<String> tagIds = const [],
    int? targetMinutes,
  }) {
    _timeDataProvider.startTimer(
      description: description,
      projectId: projectId,
      tagIds: tagIds,
      targetMinutes: targetMinutes,
    );
  }

  Future<void> stopTimer() async {
    if (state.isStoppingTimer) return;

    emit(state.copyWith(isStoppingTimer: true));
    try {
      await _timeDataProvider.stopTimer();
      emit(
        state.copyWith(
          isStoppingTimer: false,
          toastMessage: 'Timer stopped and entry saved',
          toastType: AppToastType.success,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isStoppingTimer: false,
          toastMessage: 'Failed to stop timer',
          toastType: AppToastType.error,
        ),
      );
    }
  }

  void cancelTimer() {
    _timeDataProvider.cancelTimer();
    emit(
      state.copyWith(
        toastMessage: 'Timer canceled',
        toastType: AppToastType.info,
      ),
    );
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  Future<void> addTimeEntry(
    String description,
    int durationMinutes,
    DateTime date, {
    String? projectId,
    List<String>? tagIds,
    String? clickUpTaskId,
    String? jiraIssueKey,
    DateTime? startTime,
  }) async {
    await _timeDataProvider.addTimeEntry(
      description,
      durationMinutes,
      date,
      projectId: projectId,
      tagIds: tagIds,
      clickUpTaskId: clickUpTaskId,
      jiraIssueKey: jiraIssueKey,
      startTime: startTime,
    );
  }

  Future<void> updateTimeEntry(TimeEntry entry) async {
    await _timeDataProvider.updateTimeEntry(entry);
  }

  Future<void> deleteTimeEntry(String id) async {
    await _timeDataProvider.deleteTimeEntry(id);
  }

  List<ClickUpTask> searchClickUpTasksLocal(String query, {int limit = 4}) {
    return _timeDataProvider.clickUpRepository.searchTasks(query, limit: limit);
  }

  List<JiraIssue> searchJiraIssuesLocal(String query, {int limit = 4}) {
    return _timeDataProvider.jiraRepository.searchIssues(query, limit: limit);
  }

  DateTime get weekStart => state.selectedDate.subtract(
    Duration(days: state.selectedDate.weekday - 1),
  );

  List<TimeEntry> entriesForDate(
    DateTime date, {
    bool currentUserOnly = false,
  }) {
    var entries = _timeDataProvider.getEntriesForDate(date);
    if (currentUserOnly && state.currentUserId != null) {
      entries =
          entries
              .where((entry) => entry.createdByUserId == state.currentUserId)
              .toList();
    }
    return entries;
  }

  Map<DateTime, int> minutesByDateForWeek({bool currentUserOnly = false}) {
    final minutesByDate = <DateTime, int>{};
    for (int i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      final normalized = DateTime(date.year, date.month, date.day);
      final entries = entriesForDate(date, currentUserOnly: currentUserOnly);
      minutesByDate[normalized] = entries.fold(
        0,
        (sum, entry) => sum + entry.durationMinutes,
      );
    }
    return minutesByDate;
  }

  List<TimeEntry> weekEntries({bool currentUserOnly = false}) {
    var entries = state.weekEntries;
    if (currentUserOnly && state.currentUserId != null) {
      entries =
          entries
              .where((entry) => entry.createdByUserId == state.currentUserId)
              .toList();
    }
    return entries;
  }

  @override
  void dispose() {
    _timeDataProvider.removeListener(_syncFromProvider);
    _authDataProvider.removeListener(_syncFromProvider);
    super.dispose();
  }
}
