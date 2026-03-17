import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_providers/firebase/firebase_data_provider.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'client_dashboard_state.dart';

class ClientDashboardCubit extends BaseCubit<ClientDashboardState> {
  ClientDashboardCubit({
    required AuthDataProvider authDataProvider,
    required FirebaseDataProvider firebaseDataProvider,
    String? clientIdOverride,
    required bool isPreview,
  }) : _authDataProvider = authDataProvider,
       _firebaseDataProvider = firebaseDataProvider,
       _clientIdOverride = clientIdOverride,
       super(ClientDashboardState.initial().copyWith(isPreview: isPreview)) {
    _authDataProvider.addListener(_syncFromAuth);
    _syncFromAuth();
    loadData();
  }

  final AuthDataProvider _authDataProvider;
  final FirebaseDataProvider _firebaseDataProvider;
  final String? _clientIdOverride;

  String? get _effectiveClientId {
    return _clientIdOverride ?? _authDataProvider.clientId;
  }

  void _syncFromAuth() {
    emit(
      state.copyWith(
        organizations: _authDataProvider.organizations,
        pendingInvites: _authDataProvider.pendingInvites,
        activeOrganizationId: _authDataProvider.activeOrganizationId,
      ),
    );
  }

  Future<void> loadData() async {
    final clientId = _effectiveClientId;
    if (clientId == null) {
      emit(state.copyWith(error: 'Client ID not found', isLoading: false));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));
    try {
      final client = await _firebaseDataProvider.getClientById(clientId);
      final projects = await _firebaseDataProvider.getProjectsForClient(clientId);
      final entries = await _firebaseDataProvider.getTimeEntriesForClientMonth(
        clientId,
        state.selectedMonth.year,
        state.selectedMonth.month,
      );
      final tagsStream = _firebaseDataProvider.getTags();
      final tags = await tagsStream.first;

      final usedTags = _buildUsedTags(entries, tags);
      final filteredEntries = _filterEntries(entries, state.selectedTagIds);

      emit(
        state.copyWith(
          client: client,
          projects: projects,
          timeEntries: entries,
          tags: tags,
          usedTags: usedTags,
          filteredEntries: filteredEntries,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Error loading data: $e', isLoading: false));
    }
  }

  Future<void> switchOrganization(String organizationId) async {
    if (state.isPreview) return;
    if (organizationId == _authDataProvider.activeOrganizationId) {
      return;
    }
    await _authDataProvider.setActiveOrganization(organizationId);
    await _authDataProvider.refreshOrganizations();
    await loadData();
  }

  Future<void> openOrganizationSetupReturned(String? beforeOrgId) async {
    if (state.isPreview) return;
    await _authDataProvider.refreshOrganizations();
    final afterOrgId = _authDataProvider.activeOrganizationId;
    if (beforeOrgId != afterOrgId) {
      await loadData();
    }
  }

  Future<void> signOut() async {
    if (state.isSigningOut || state.isPreview) return;
    emit(state.copyWith(isSigningOut: true));
    try {
      await _authDataProvider.signOut();
    } finally {
      emit(state.copyWith(isSigningOut: false));
    }
  }

  void previousMonth() {
    final next = DateTime(state.selectedMonth.year, state.selectedMonth.month - 1);
    emit(state.copyWith(selectedMonth: next));
    loadData();
  }

  void nextMonth() {
    final now = DateTime.now();
    final next = DateTime(state.selectedMonth.year, state.selectedMonth.month + 1);
    if (next.isAfter(DateTime(now.year, now.month + 1, 0))) {
      return;
    }
    emit(state.copyWith(selectedMonth: next));
    loadData();
  }

  void setMonth(DateTime date) {
    emit(state.copyWith(selectedMonth: date));
    loadData();
  }

  void toggleTag(String tagId) {
    final selected = Set<String>.from(state.selectedTagIds);
    if (selected.contains(tagId)) {
      selected.remove(tagId);
    } else {
      selected.add(tagId);
    }
    final filteredEntries = _filterEntries(state.timeEntries, selected.toList());
    emit(state.copyWith(selectedTagIds: selected.toList(), filteredEntries: filteredEntries));
  }

  void clearTags() {
    emit(state.copyWith(selectedTagIds: const [], filteredEntries: state.timeEntries));
  }

  List<Tag> _buildUsedTags(List<TimeEntry> entries, List<Tag> tags) {
    final usedTagIds = <String>{};
    for (final entry in entries) {
      usedTagIds.addAll(entry.tagIds);
    }
    return tags.where((tag) => usedTagIds.contains(tag.id)).toList();
  }

  List<TimeEntry> _filterEntries(List<TimeEntry> entries, List<String> selectedTagIds) {
    if (selectedTagIds.isEmpty) {
      return List<TimeEntry>.from(entries);
    }
    return entries.where((entry) => entry.tagIds.any((tagId) => selectedTagIds.contains(tagId))).toList();
  }

  @override
  void dispose() {
    _authDataProvider.removeListener(_syncFromAuth);
    super.dispose();
  }
}
