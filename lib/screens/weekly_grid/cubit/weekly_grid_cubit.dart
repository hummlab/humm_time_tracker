import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_repositories/firebase/time_entries_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/time/grid_row.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'weekly_grid_state.dart';

class WeeklyGridCubit extends BaseCubit<WeeklyGridState> {
  WeeklyGridCubit(this._workspaceRepository, this._timeEntriesRepository, this._authDataProvider)
    : super(WeeklyGridState.initial()) {
    _workspaceRepository.addListener(_syncFromSources);
    _authDataProvider.addListener(_syncFromSources);
    _syncFromSources();
  }

  final WorkspaceRepository _workspaceRepository;
  final TimeEntriesRepository _timeEntriesRepository;
  final AuthDataProvider _authDataProvider;

  void _syncFromSources() {
    final currentUserId = _authDataProvider.currentUserId;
    final weekStart = state.weekStart;

    emit(
      state.copyWith(
        currentUserId: currentUserId,
        projects: _workspaceRepository.projects,
        rows: _workspaceRepository.getWeekGridData(weekStart, currentUserId: currentUserId),
      ),
    );
  }

  void previousWeek() {
    final newStart = state.weekStart.subtract(const Duration(days: 7));
    emit(state.copyWith(weekStart: newStart));
    _syncFromSources();
  }

  void nextWeek() {
    final newStart = state.weekStart.add(const Duration(days: 7));
    emit(state.copyWith(weekStart: newStart));
    _syncFromSources();
  }

  void goToToday() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final normalized = DateTime(weekStart.year, weekStart.month, weekStart.day);
    emit(state.copyWith(weekStart: normalized));
    _syncFromSources();
  }

  Project? getProjectById(String? id) {
    if (id == null) return null;
    return _workspaceRepository.getProjectById(id);
  }

  Future<void> updateCellMinutes({required GridRow row, required int dayIndex, required int newMinutes}) async {
    if (newMinutes == row.dayMinutes[dayIndex]) return;

    final existingEntryIds = row.dayEntryIds[dayIndex];
    if (existingEntryIds.isNotEmpty) {
      for (final id in existingEntryIds) {
        await _timeEntriesRepository.deleteTimeEntry(id);
      }
    }

    if (newMinutes <= 0) return;
    final userId = state.currentUserId;
    if (userId == null) return;

    final date = state.weekStart.add(Duration(days: dayIndex));
    await _timeEntriesRepository.addTimeEntry(
      TimeEntry(
        id: '',
        description: row.description,
        durationMinutes: newMinutes,
        date: date,
        projectId: row.projectId,
        tagIds: row.tagIds,
        createdByUserId: userId,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> addRow({required String description, String? projectId}) async {
    if (description.trim().isEmpty) return;
    final userId = state.currentUserId;
    if (userId == null) return;

    await _timeEntriesRepository.addTimeEntry(
      TimeEntry(
        id: '',
        description: description.trim(),
        durationMinutes: 0,
        date: state.weekStart,
        projectId: projectId,
        tagIds: const [],
        createdByUserId: userId,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _workspaceRepository.removeListener(_syncFromSources);
    _authDataProvider.removeListener(_syncFromSources);
    super.dispose();
  }
}
