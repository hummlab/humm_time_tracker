import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_repositories/firebase/time_entries_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/approve_hours/cubit/approve_hours_models.dart';
import 'package:time_tracker/screens/approve_hours/cubit/approve_hours_state.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class ApproveHoursCubit extends BaseCubit<ApproveHoursState> {
  ApproveHoursCubit(this._workspaceRepository, this._timeEntriesRepository, this._authDataProvider)
    : super(ApproveHoursState.initial()) {
    _workspaceRepository.addListener(_syncFromSources);
    _authDataProvider.addListener(_syncFromSources);
    _syncFromSources();
  }

  final WorkspaceRepository _workspaceRepository;
  final TimeEntriesRepository _timeEntriesRepository;
  final AuthDataProvider _authDataProvider;

  void _syncFromSources() {
    final pendingEntries = _workspaceRepository.getPendingEntries();
    final usersWithPending = _getUniqueUsers(pendingEntries);
    final pendingCountsByUserId = _buildPendingCountsByUserId(pendingEntries);
    final filteredEntries = _applyFilter(pendingEntries, state.filterByUserId);
    final userSections = _buildUserSections(filteredEntries);
    final totalMinutes = filteredEntries.fold(0, (sum, e) => sum + e.durationMinutes);

    emit(
      state.copyWith(
        pendingEntries: pendingEntries,
        filteredEntries: filteredEntries,
        usersWithPending: usersWithPending,
        pendingCountsByUserId: pendingCountsByUserId,
        userSections: userSections,
        totalMinutes: totalMinutes,
      ),
    );
  }

  List<TimeEntry> _applyFilter(List<TimeEntry> entries, String? filterByUserId) {
    if (filterByUserId == null) return entries;
    return entries.where((e) => e.createdByUserId == filterByUserId).toList();
  }

  List<TeamMember> _getUniqueUsers(List<TimeEntry> entries) {
    final userIds = entries.map((e) => e.createdByUserId).toSet();
    final users = <TeamMember>[];

    for (final userId in userIds) {
      final member = _workspaceRepository.teamMembers.firstWhere(
        (m) => m.firebaseUid == userId,
        orElse: () {
          return TeamMember(
            id: userId,
            name: 'Unknown User',
            email: '',
            userId: userId,
            firebaseUid: userId,
            createdAt: DateTime.now(),
          );
        },
      );
      users.add(member);
    }

    users.sort((a, b) => a.name.compareTo(b.name));
    return users;
  }

  Map<String, int> _buildPendingCountsByUserId(List<TimeEntry> entries) {
    final counts = <String, int>{};
    for (final entry in entries) {
      counts.update(entry.createdByUserId, (value) => value + 1, ifAbsent: () => 1);
    }
    return counts;
  }

  List<ApproveHoursUserSection> _buildUserSections(List<TimeEntry> entries) {
    final groupedByUser = <String, List<TimeEntry>>{};
    for (final entry in entries) {
      groupedByUser.putIfAbsent(entry.createdByUserId, () => []).add(entry);
    }

    final sections = <ApproveHoursUserSection>[];
    for (final userId in groupedByUser.keys) {
      final userEntries = groupedByUser[userId] ?? [];
      final member = _workspaceRepository.teamMembers.firstWhere(
        (m) => m.firebaseUid == userId,
        orElse: () {
          return TeamMember(
            id: userId,
            name: 'Unknown User',
            email: '',
            userId: userId,
            firebaseUid: userId,
            createdAt: DateTime.now(),
          );
        },
      );

      final dateSections = _buildDateSections(userEntries);
      final totalMinutes = userEntries.fold(0, (sum, e) => sum + e.durationMinutes);

      sections.add(
        ApproveHoursUserSection(
          member: member,
          entries: userEntries,
          dateSections: dateSections,
          totalMinutes: totalMinutes,
        ),
      );
    }

    return sections;
  }

  List<ApproveHoursDateSection> _buildDateSections(List<TimeEntry> entries) {
    final groupedByDate = <DateTime, List<TimeEntry>>{};
    for (final entry in entries) {
      final dateKey = DateTime(entry.date.year, entry.date.month, entry.date.day);
      groupedByDate.putIfAbsent(dateKey, () => []).add(entry);
    }

    final sortedDates = groupedByDate.keys.toList()..sort((a, b) => b.compareTo(a));

    return sortedDates.map((date) {
      final dateEntries = groupedByDate[date] ?? [];
      final totalMinutes = dateEntries.fold(0, (sum, e) => sum + e.durationMinutes);
      return ApproveHoursDateSection(date: date, entries: dateEntries, totalMinutes: totalMinutes);
    }).toList();
  }

  void setFilterByUserId(String? userId) {
    final filteredEntries = _applyFilter(state.pendingEntries, userId);
    emit(
      state.copyWith(
        filterByUserId: userId,
        filteredEntries: filteredEntries,
        userSections: _buildUserSections(filteredEntries),
        totalMinutes: filteredEntries.fold(0, (sum, e) => sum + e.durationMinutes),
      ),
    );
  }

  void toggleEntrySelection(String entryId) {
    final selected = Set<String>.from(state.selectedEntryIds);
    if (selected.contains(entryId)) {
      selected.remove(entryId);
    } else {
      selected.add(entryId);
    }
    emit(state.copyWith(selectedEntryIds: selected.toList()));
  }

  void toggleSelectAll() {
    final entries = state.filteredEntries;
    if (entries.isEmpty) return;

    if (state.selectedEntryIds.length == entries.length) {
      emit(state.copyWith(selectedEntryIds: []));
      return;
    }

    final ids = entries.map((e) => e.id).toSet().toList();
    emit(state.copyWith(selectedEntryIds: ids));
  }

  Project? getProjectById(String? id) {
    if (id == null) return null;
    return _workspaceRepository.getProjectById(id);
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  Future<void> approveSelected() async {
    if (state.selectedEntryIds.isEmpty || state.isProcessing) return;

    emit(state.copyWith(isProcessing: true, toastMessage: null, toastType: null));

    final currentUserId = _authDataProvider.currentUserId;
    final result = await _timeEntriesRepository.updateTimeEntriesStatusSafe(
      state.selectedEntryIds,
      TimeEntryStatus.approved,
      approvedByUserId: currentUserId,
    );

    if (!result.isSuccess) {
      emit(
        state.copyWith(
          isProcessing: false,
          toastMessage: 'Error approving entries: ${result.error}',
          toastType: AppToastType.error,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isProcessing: false,
        selectedEntryIds: [],
        toastMessage: '${state.selectedEntryIds.length} entries approved',
        toastType: AppToastType.success,
      ),
    );
  }

  Future<void> rejectSelected(String reason) async {
    if (state.selectedEntryIds.isEmpty || state.isProcessing) return;

    emit(state.copyWith(isProcessing: true, toastMessage: null, toastType: null));

    final currentUserId = _authDataProvider.currentUserId;
    final result = await _timeEntriesRepository.updateTimeEntriesStatusSafe(
      state.selectedEntryIds,
      TimeEntryStatus.rejected,
      approvedByUserId: currentUserId,
      rejectionReason: reason,
    );

    if (!result.isSuccess) {
      emit(
        state.copyWith(
          isProcessing: false,
          toastMessage: 'Error rejecting entries: ${result.error}',
          toastType: AppToastType.error,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isProcessing: false,
        selectedEntryIds: [],
        toastMessage: '${state.selectedEntryIds.length} entries rejected',
        toastType: AppToastType.info,
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
