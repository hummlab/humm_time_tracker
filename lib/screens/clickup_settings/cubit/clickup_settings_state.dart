import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/integrations/clickup_task.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'clickup_settings_state.freezed.dart';

@freezed
class ClickupSettingsState with _$ClickupSettingsState {
  const factory ClickupSettingsState({
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isSyncing,
    ClickUpSettings? settings,
    @Default([]) List<ClickUpWorkspace> workspaces,
    @Default([]) List<ClickUpSpace> spaces,
    @Default({}) Map<String, List<ClickUpFolder>> foldersBySpace,
    @Default({}) Map<String, List<ClickUpList>> folderlessListsBySpace,
    String? selectedWorkspaceId,
    @Default([]) List<String> selectedListIds,
    @Default({}) Map<String, String> listProjectAssignments,
    @Default(<String>{}) Set<String> expandedSpaces,
    @Default(<String>{}) Set<String> expandedFolders,
    @Default([]) List<Project> projects,
    String? toastMessage,
    AppToastType? toastType,
  }) = _ClickupSettingsState;

  factory ClickupSettingsState.initial() => const ClickupSettingsState();
}
