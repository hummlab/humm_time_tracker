import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/integrations/jira_issue.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'jira_settings_state.freezed.dart';

@freezed
class JiraSettingsState with _$JiraSettingsState {
  const factory JiraSettingsState({
    JiraSettings? settings,
    @Default([]) List<JiraProject> projects,
    @Default([]) List<String> selectedProjectIds,
    @Default(false) bool projectsLoaded,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isTesting,
    @Default(false) bool isSyncing,
    @Default(false) bool shouldClearApiToken,
    String? toastMessage,
    AppToastType? toastType,
  }) = _JiraSettingsState;

  factory JiraSettingsState.initial() => const JiraSettingsState();
}
