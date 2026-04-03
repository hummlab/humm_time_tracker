import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_repositories/firebase/time_entries_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_models.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_state.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class SubmitHoursCubit extends BaseCubit<SubmitHoursState> {
  SubmitHoursCubit(
    this._workspaceRepository,
    this._timeEntriesRepository,
    this._authDataProvider,
  ) : super(SubmitHoursState.initial()) {
    _workspaceRepository.addListener(_syncFromSources);
    _authDataProvider.addListener(_syncFromSources);
    _syncFromSources();
  }

  final WorkspaceRepository _workspaceRepository;
  final TimeEntriesRepository _timeEntriesRepository;
  final AuthDataProvider _authDataProvider;

  void _syncFromSources() {
    final userId = _authDataProvider.currentUserId;
    final draftEntries = _workspaceRepository.getDraftEntriesForCurrentUser(
      userId,
    );
    final pendingEntries = _workspaceRepository.getPendingEntriesForCurrentUser(
      userId,
    );
    final rejectedEntries = _workspaceRepository
        .getRejectedEntriesForCurrentUser(userId);

    final selectedEntryIds = _filterSelectedToDraft(draftEntries);
    final selectedTotalMinutes = _selectedTotalMinutes(
      draftEntries,
      selectedEntryIds,
    );

    emit(
      state.copyWith(
        draftEntries: draftEntries,
        pendingEntries: pendingEntries,
        rejectedEntries: rejectedEntries,
        draftSections: _buildDateSections(draftEntries),
        pendingSections: _buildDateSections(pendingEntries),
        rejectedSections: _buildDateSections(rejectedEntries),
        selectedEntryIds: selectedEntryIds,
        totalDraftMinutes: _totalMinutes(draftEntries),
        totalPendingMinutes: _totalMinutes(pendingEntries),
        totalRejectedMinutes: _totalMinutes(rejectedEntries),
        selectedTotalMinutes: selectedTotalMinutes,
      ),
    );
  }

  List<String> _filterSelectedToDraft(List<TimeEntry> draftEntries) {
    if (state.selectedEntryIds.isEmpty) return state.selectedEntryIds;
    final draftIds = draftEntries.map((e) => e.id).toSet();
    return state.selectedEntryIds.where(draftIds.contains).toList();
  }

  List<SubmitHoursDateSection> _buildDateSections(List<TimeEntry> entries) {
    final groupedByDate = <DateTime, List<TimeEntry>>{};
    for (final entry in entries) {
      final dateKey = DateTime(
        entry.date.year,
        entry.date.month,
        entry.date.day,
      );
      groupedByDate.putIfAbsent(dateKey, () => []).add(entry);
    }

    final sortedDates =
        groupedByDate.keys.toList()..sort((a, b) => b.compareTo(a));

    return sortedDates.map((date) {
      final dateEntries = groupedByDate[date] ?? [];
      return SubmitHoursDateSection(
        date: date,
        entries: dateEntries,
        totalMinutes: _totalMinutes(dateEntries),
      );
    }).toList();
  }

  int _totalMinutes(List<TimeEntry> entries) {
    return entries.fold(0, (sum, e) => sum + e.durationMinutes);
  }

  int _selectedTotalMinutes(
    List<TimeEntry> draftEntries,
    List<String> selectedEntryIds,
  ) {
    if (selectedEntryIds.isEmpty) return 0;
    final selectedSet = selectedEntryIds.toSet();
    return draftEntries
        .where((e) => selectedSet.contains(e.id))
        .fold(0, (sum, e) => sum + e.durationMinutes);
  }

  void toggleEntrySelection(String entryId) {
    final selected = Set<String>.from(state.selectedEntryIds);
    _clearQuickSelectIfManualChange();
    if (selected.contains(entryId)) {
      selected.remove(entryId);
    } else {
      selected.add(entryId);
    }
    final selectedList = selected.toList();
    emit(
      state.copyWith(
        selectedEntryIds: selectedList,
        selectedTotalMinutes: _selectedTotalMinutes(
          state.draftEntries,
          selectedList,
        ),
      ),
    );
  }

  void toggleSelectAllDraft() {
    if (state.draftEntries.isEmpty) return;
    _clearQuickSelectIfManualChange();

    if (state.selectedEntryIds.length == state.draftEntries.length) {
      emit(state.copyWith(selectedEntryIds: [], selectedTotalMinutes: 0));
      return;
    }

    final ids = state.draftEntries.map((e) => e.id).toSet().toList();
    emit(
      state.copyWith(
        selectedEntryIds: ids,
        selectedTotalMinutes: _selectedTotalMinutes(state.draftEntries, ids),
      ),
    );
  }

  void selectThisMonth() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    _selectEntriesInRange(
      startOfMonth,
      endOfMonth,
      SubmitHoursQuickSelectPeriod.thisMonth,
    );
  }

  void selectLastMonth() {
    final now = DateTime.now();
    final startOfLastMonth = DateTime(now.year, now.month - 1, 1);
    final endOfLastMonth = DateTime(now.year, now.month, 0, 23, 59, 59);
    _selectEntriesInRange(
      startOfLastMonth,
      endOfLastMonth,
      SubmitHoursQuickSelectPeriod.lastMonth,
    );
  }

  void _selectEntriesInRange(
    DateTime start,
    DateTime end,
    SubmitHoursQuickSelectPeriod period,
  ) {
    final entriesInRange =
        state.draftEntries.where((e) {
          return !e.date.isBefore(start) && !e.date.isAfter(end);
        }).toList();

    final newSelection = entriesInRange.map((e) => e.id).toList();
    final activePeriod =
        newSelection.isNotEmpty ? period : SubmitHoursQuickSelectPeriod.none;

    emit(
      state.copyWith(
        selectedEntryIds: newSelection,
        activeQuickSelect: activePeriod,
        selectedTotalMinutes: _selectedTotalMinutes(
          state.draftEntries,
          newSelection,
        ),
        toastMessage: newSelection.isEmpty ? 'No entries in this period' : null,
        toastType: newSelection.isEmpty ? AppToastType.info : null,
      ),
    );
  }

  void _clearQuickSelectIfManualChange() {
    if (state.activeQuickSelect == SubmitHoursQuickSelectPeriod.none) return;
    emit(state.copyWith(activeQuickSelect: SubmitHoursQuickSelectPeriod.none));
  }

  Future<void> submitSelected() async {
    if (state.selectedEntryIds.isEmpty || state.isSubmitting) return;

    emit(
      state.copyWith(isSubmitting: true, toastMessage: null, toastType: null),
    );

    final result = await _timeEntriesRepository.updateTimeEntriesStatusSafe(
      state.selectedEntryIds,
      TimeEntryStatus.pending,
    );

    if (!result.isSuccess) {
      emit(
        state.copyWith(
          isSubmitting: false,
          toastMessage: 'Error submitting entries: ${result.error}',
          toastType: AppToastType.error,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        selectedEntryIds: [],
        activeQuickSelect: SubmitHoursQuickSelectPeriod.none,
        selectedTotalMinutes: 0,
        toastMessage:
            '${state.selectedEntryIds.length} entries submitted for approval',
        toastType: AppToastType.success,
      ),
    );
  }

  Project? getProjectById(String? id) {
    if (id == null) return null;
    return _workspaceRepository.getProjectById(id);
  }

  Tag? getTagById(String id) {
    return _workspaceRepository.getTagById(id);
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  @override
  void dispose() {
    _workspaceRepository.removeListener(_syncFromSources);
    _authDataProvider.removeListener(_syncFromSources);
    super.dispose();
  }
}
