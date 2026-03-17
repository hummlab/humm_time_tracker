import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/integrations/jira_data_provider.dart';
import 'package:time_tracker/data_providers/time/time_data_provider.dart';
import 'package:time_tracker/data_repositories/integrations/jira_repository.dart';
import 'package:time_tracker/models/integrations/jira_issue.dart';
import 'package:time_tracker/widgets/app_toast.dart';
import 'jira_settings_state.dart';

class JiraSettingsCubit extends BaseCubit<JiraSettingsState> {
  JiraSettingsCubit(this._timeDataProvider) : super(JiraSettingsState.initial()) {
    _loadSettings();
  }

  final TimeDataProvider _timeDataProvider;
  final JiraRepository _jiraRepository = JiraRepository(JiraDataProvider());

  bool _isConfigured(JiraSettings settings) {
    return settings.hasApiToken && (settings.domain?.isNotEmpty ?? false) && (settings.email?.isNotEmpty ?? false);
  }

  String _normalizeDomain(String rawDomain) {
    final trimmed = rawDomain.trim();
    if (trimmed.endsWith('.atlassian.net')) {
      return trimmed.replaceAll('.atlassian.net', '');
    }
    return trimmed;
  }

  Future<void> _loadSettings() async {
    emit(state.copyWith(isLoading: true));
    try {
      final settings = await _jiraRepository.getSettings();
      emit(state.copyWith(settings: settings, selectedProjectIds: settings.selectedProjectIds, isLoading: false));

      if (_isConfigured(settings)) {
        emit(state.copyWith(projectsLoaded: false));
        await _loadProjects();
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          toastMessage: 'Failed to load Jira settings: $e',
          toastType: AppToastType.error,
        ),
      );
    }
  }

  Future<void> _loadProjects() async {
    try {
      final projects = await _jiraRepository.loadProjects();
      emit(state.copyWith(projects: projects, projectsLoaded: true));
    } catch (e) {
      emit(
        state.copyWith(
          projectsLoaded: false,
          toastMessage: 'Failed to load Jira projects: $e',
          toastType: AppToastType.error,
        ),
      );
    }
  }

  Future<void> saveCredentials({required String domain, required String email, required String apiToken}) async {
    final normalizedDomain = _normalizeDomain(domain);
    final trimmedEmail = email.trim();
    final trimmedToken = apiToken.trim();

    if (normalizedDomain.isEmpty || trimmedEmail.isEmpty || trimmedToken.isEmpty) {
      emit(state.copyWith(toastMessage: 'Please enter domain, email, and API token', toastType: AppToastType.error));
      return;
    }

    emit(state.copyWith(isSaving: true));
    try {
      final success = await _jiraRepository.saveSettings(
        domain: normalizedDomain,
        email: trimmedEmail,
        apiToken: trimmedToken,
      );
      if (success) {
        emit(
          state.copyWith(
            isSaving: false,
            shouldClearApiToken: true,
            toastMessage: 'Jira credentials saved',
            toastType: AppToastType.success,
          ),
        );
        await _loadSettings();
      } else {
        emit(
          state.copyWith(
            isSaving: false,
            toastMessage: 'Failed to save Jira credentials',
            toastType: AppToastType.error,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isSaving: false, toastMessage: 'Error: $e', toastType: AppToastType.error));
    }
  }

  Future<void> testConnection({required String domain, required String email, required String apiToken}) async {
    final normalizedDomain = _normalizeDomain(domain);
    final trimmedEmail = email.trim();
    final trimmedToken = apiToken.trim();

    if (normalizedDomain.isEmpty || trimmedEmail.isEmpty || trimmedToken.isEmpty) {
      emit(state.copyWith(toastMessage: 'Please enter domain, email, and API token', toastType: AppToastType.error));
      return;
    }

    emit(state.copyWith(isTesting: true));
    try {
      final success = await _jiraRepository.testConnection(
        domain: normalizedDomain,
        email: trimmedEmail,
        apiToken: trimmedToken,
      );
      emit(
        state.copyWith(
          isTesting: false,
          toastMessage: success ? 'Connection successful' : 'Connection failed',
          toastType: success ? AppToastType.success : AppToastType.error,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isTesting: false, toastMessage: 'Connection failed: $e', toastType: AppToastType.error));
    }
  }

  void toggleProjectSelection(String projectId) {
    final selected = Set<String>.from(state.selectedProjectIds);
    if (selected.contains(projectId)) {
      selected.remove(projectId);
    } else {
      selected.add(projectId);
    }
    emit(state.copyWith(selectedProjectIds: selected.toList()));
  }

  Future<void> saveSelectedProjects() async {
    emit(state.copyWith(isSaving: true));
    try {
      final success = await _jiraRepository.saveSettings(selectedProjectIds: state.selectedProjectIds);
      emit(state.copyWith(isSaving: false));

      if (success) {
        emit(state.copyWith(toastMessage: 'Selected projects saved', toastType: AppToastType.success));
      } else {
        emit(state.copyWith(toastMessage: 'Failed to save selected projects', toastType: AppToastType.error));
      }
    } catch (e) {
      emit(state.copyWith(isSaving: false, toastMessage: 'Error: $e', toastType: AppToastType.error));
    }
  }

  Future<void> syncIssues() async {
    if (state.selectedProjectIds.isEmpty) {
      emit(state.copyWith(toastMessage: 'Please select at least one project to sync', toastType: AppToastType.error));
      return;
    }

    await saveSelectedProjects();
    emit(state.copyWith(isSyncing: true));
    try {
      final (success, count, error) = await _jiraRepository.syncIssues();
      if (success) {
        emit(
          state.copyWith(isSyncing: false, toastMessage: 'Synced $count Jira issues', toastType: AppToastType.success),
        );
        await _loadSettings();
        _timeDataProvider.refreshJiraIssues();
      } else {
        emit(
          state.copyWith(
            isSyncing: false,
            toastMessage: error ?? 'Failed to sync Jira issues',
            toastType: AppToastType.error,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isSyncing: false, toastMessage: 'Error: $e', toastType: AppToastType.error));
    }
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  void clearApiTokenFlag() {
    if (!state.shouldClearApiToken) return;
    emit(state.copyWith(shouldClearApiToken: false));
  }
}
