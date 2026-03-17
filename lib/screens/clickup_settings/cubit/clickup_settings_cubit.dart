import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/integrations/clickup_data_provider.dart';
import 'package:time_tracker/data_repositories/integrations/clickup_repository.dart';
import 'package:time_tracker/data_repositories/firebase/projects_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/integrations/clickup_task.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/widgets/app_toast.dart';

import 'clickup_settings_state.dart';

class ClickupSettingsCubit extends BaseCubit<ClickupSettingsState> {
  ClickupSettingsCubit(this._workspaceRepository, this._projectsRepository) : super(ClickupSettingsState.initial()) {
    _workspaceRepository.addListener(_syncProjects);
    _syncProjects();
    _loadSettings();
  }

  final WorkspaceRepository _workspaceRepository;
  final ProjectsRepository _projectsRepository;
  final ClickUpRepository _clickUpRepository = ClickUpRepository(ClickUpDataProvider());

  void _syncProjects() {
    emit(
      state.copyWith(
        projects: _workspaceRepository.projects,
        listProjectAssignments: _buildListProjectAssignments(_workspaceRepository.projects),
      ),
    );
  }

  Map<String, String> _buildListProjectAssignments(List<Project> projects) {
    final assignments = <String, String>{};
    for (final project in projects) {
      for (final listId in project.clickUpListIds) {
        assignments[listId] = project.id;
      }
    }
    return assignments;
  }

  Future<void> _loadSettings() async {
    emit(state.copyWith(isLoading: true));

    final settings = await _clickUpRepository.getSettings();
    final assignments = _buildListProjectAssignments(_workspaceRepository.projects);

    emit(
      state.copyWith(
        settings: settings,
        selectedWorkspaceId: settings.workspaceId,
        selectedListIds: settings.selectedListIds,
        listProjectAssignments: assignments,
        projects: _workspaceRepository.projects,
        isLoading: false,
      ),
    );

    if (settings.hasApiToken) {
      await _loadWorkspaces();
    }
  }

  Future<void> _loadWorkspaces() async {
    final workspaces = await _clickUpRepository.getWorkspaces();
    emit(state.copyWith(workspaces: workspaces));

    final workspaceId = state.selectedWorkspaceId;
    if (workspaceId != null) {
      await _loadSpaces(workspaceId);
    }
  }

  Future<void> _loadSpaces(String workspaceId) async {
    final spaces = await _clickUpRepository.getSpaces(workspaceId);
    emit(state.copyWith(spaces: spaces));
  }

  Future<void> _loadFoldersAndLists(String spaceId) async {
    final folders = await _clickUpRepository.getFolders(spaceId);
    final folderlessLists = await _clickUpRepository.getFolderlessLists(spaceId);

    final foldersBySpace = Map<String, List<ClickUpFolder>>.from(state.foldersBySpace);
    final folderlessBySpace = Map<String, List<ClickUpList>>.from(state.folderlessListsBySpace);

    foldersBySpace[spaceId] = folders;
    folderlessBySpace[spaceId] = folderlessLists;

    emit(state.copyWith(foldersBySpace: foldersBySpace, folderlessListsBySpace: folderlessBySpace));
  }

  Future<void> saveApiToken(String token) async {
    final trimmed = token.trim();
    if (trimmed.isEmpty) {
      emit(state.copyWith(toastMessage: 'Please enter an API token', toastType: AppToastType.error));
      return;
    }

    emit(state.copyWith(isSaving: true));
    final success = await _clickUpRepository.saveApiToken(trimmed);
    emit(state.copyWith(isSaving: false));

    if (success) {
      emit(state.copyWith(toastMessage: 'API token saved successfully', toastType: AppToastType.success));
      await _loadSettings();
    } else {
      emit(state.copyWith(toastMessage: 'Failed to save API token', toastType: AppToastType.error));
    }
  }

  Future<void> selectWorkspace(String workspaceId) async {
    emit(
      state.copyWith(
        selectedWorkspaceId: workspaceId,
        spaces: [],
        foldersBySpace: {},
        folderlessListsBySpace: {},
        expandedSpaces: {},
        expandedFolders: {},
      ),
    );

    await _clickUpRepository.saveWorkspaceId(workspaceId);
    await _loadSpaces(workspaceId);
  }

  void toggleListSelection(String listId) {
    final selected = Set<String>.from(state.selectedListIds);
    if (selected.contains(listId)) {
      selected.remove(listId);
    } else {
      selected.add(listId);
    }
    emit(state.copyWith(selectedListIds: selected.toList()));
  }

  Future<void> toggleSpaceExpanded(String spaceId) async {
    final expanded = Set<String>.from(state.expandedSpaces);
    final isExpanded = expanded.contains(spaceId);

    if (isExpanded) {
      expanded.remove(spaceId);
    } else {
      expanded.add(spaceId);
    }

    emit(state.copyWith(expandedSpaces: expanded));

    if (!isExpanded && !state.foldersBySpace.containsKey(spaceId)) {
      await _loadFoldersAndLists(spaceId);
    }
  }

  void toggleFolderExpanded(String folderId) {
    final expanded = Set<String>.from(state.expandedFolders);
    if (expanded.contains(folderId)) {
      expanded.remove(folderId);
    } else {
      expanded.add(folderId);
    }
    emit(state.copyWith(expandedFolders: expanded));
  }

  Future<void> saveSelectedLists() async {
    emit(state.copyWith(isSaving: true));
    final success = await _clickUpRepository.saveSelectedLists(state.selectedListIds);
    emit(state.copyWith(isSaving: false));

    if (success) {
      emit(state.copyWith(toastMessage: 'Selected lists saved', toastType: AppToastType.success));
    } else {
      emit(state.copyWith(toastMessage: 'Failed to save selected lists', toastType: AppToastType.error));
    }
  }

  Future<void> syncTasks() async {
    if (state.selectedListIds.isEmpty) {
      emit(state.copyWith(toastMessage: 'Please select at least one list to sync', toastType: AppToastType.error));
      return;
    }

    await saveSelectedLists();

    emit(state.copyWith(isSyncing: true));
    final (success, count, error) = await _clickUpRepository.syncAllTasks();
    emit(state.copyWith(isSyncing: false));

    if (success) {
      emit(state.copyWith(toastMessage: 'Synced $count tasks from ClickUp', toastType: AppToastType.success));

      if (state.settings?.webhookId == null && state.selectedWorkspaceId != null) {
        await _createWebhookAutomatically();
      }

      await _loadSettings();
    } else {
      emit(state.copyWith(toastMessage: error ?? 'Failed to sync tasks', toastType: AppToastType.error));
    }
  }

  Future<void> syncTasksIncremental() async {
    emit(state.copyWith(isSyncing: true));
    final (success, count, error) = await _clickUpRepository.syncTasksIncremental();
    emit(state.copyWith(isSyncing: false));

    if (success) {
      emit(state.copyWith(toastMessage: 'Synced $count updated tasks', toastType: AppToastType.success));
      await _loadSettings();
    } else {
      emit(state.copyWith(toastMessage: error ?? 'Failed to sync tasks', toastType: AppToastType.error));
    }
  }

  String _buildClickUpWebhookUrl() {
    final projectId = Firebase.app().options.projectId;
    return 'https://europe-west1-$projectId.cloudfunctions.net/clickupWebhook';
  }

  Future<void> createWebhookManually() async {
    if (state.selectedWorkspaceId == null) {
      emit(state.copyWith(toastMessage: 'Please select a workspace first', toastType: AppToastType.error));
      return;
    }

    emit(state.copyWith(isSaving: true));
    await _createWebhookAutomatically();
    await _loadSettings();
    emit(state.copyWith(isSaving: false));
  }

  Future<void> _createWebhookAutomatically() async {
    final workspaceId = state.selectedWorkspaceId;
    if (workspaceId == null) return;

    final webhookUrl = _buildClickUpWebhookUrl();
    final success = await _clickUpRepository.createWebhook(workspaceId, webhookUrl);
    if (success) {
      emit(
        state.copyWith(toastMessage: 'Webhook created - real-time updates enabled!', toastType: AppToastType.success),
      );
    }
  }

  Future<void> deleteWebhook() async {
    final webhookId = state.settings?.webhookId;
    if (webhookId == null) return;

    emit(state.copyWith(isSaving: true));
    final success = await _clickUpRepository.deleteWebhook(webhookId);
    emit(state.copyWith(isSaving: false));

    if (success) {
      emit(state.copyWith(toastMessage: 'Webhook removed', toastType: AppToastType.success));
      await _loadSettings();
    } else {
      emit(state.copyWith(toastMessage: 'Failed to remove webhook', toastType: AppToastType.error));
    }
  }

  Future<void> assignProjectToList(String listId, String? projectId) async {
    final oldProjectId = state.listProjectAssignments[listId];
    final assignments = Map<String, String>.from(state.listProjectAssignments);

    if (projectId == null) {
      assignments.remove(listId);
    } else {
      assignments[listId] = projectId;
    }

    emit(state.copyWith(listProjectAssignments: assignments));

    var success = true;

    if (oldProjectId != null) {
      final oldProject = _workspaceRepository.getProjectById(oldProjectId);
      if (oldProject != null) {
        final updatedListIds = oldProject.clickUpListIds.where((id) => id != listId).toList();
        final updatedProject = oldProject.copyWith(clickUpListIds: updatedListIds);
        final updated = await _projectsRepository.updateProjectSafe(updatedProject);
        if (!updated) success = false;
      }
    }

    if (projectId != null) {
      final newProject = _workspaceRepository.getProjectById(projectId);
      if (newProject != null && !newProject.clickUpListIds.contains(listId)) {
        final updatedListIds = [...newProject.clickUpListIds, listId];
        final updatedProject = newProject.copyWith(clickUpListIds: updatedListIds);
        final updated = await _projectsRepository.updateProjectSafe(updatedProject);
        if (!updated) success = false;
      }
    }

    if (!success) {
      final revertedAssignments = Map<String, String>.from(state.listProjectAssignments);
      if (oldProjectId != null) {
        revertedAssignments[listId] = oldProjectId;
      } else {
        revertedAssignments.remove(listId);
      }

      emit(
        state.copyWith(
          listProjectAssignments: revertedAssignments,
          toastMessage: 'Failed to update project assignment',
          toastType: AppToastType.error,
        ),
      );
      return;
    }

    emit(state.copyWith(toastMessage: 'Project assignment updated', toastType: AppToastType.success));
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  @override
  void dispose() {
    _workspaceRepository.removeListener(_syncProjects);
    super.dispose();
  }
}
