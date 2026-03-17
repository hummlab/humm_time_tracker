import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/clickup_settings/cubit/clickup_settings_cubit.dart';
import 'package:time_tracker/screens/clickup_settings/cubit/clickup_settings_state.dart';
import 'package:time_tracker/screens/clickup_settings/widgets/clickup_api_token_section.dart';
import 'package:time_tracker/screens/clickup_settings/widgets/clickup_delete_webhook_dialog.dart';
import 'package:time_tracker/screens/clickup_settings/widgets/clickup_quick_sync_action.dart';
import 'package:time_tracker/screens/clickup_settings/widgets/clickup_spaces_section.dart';
import 'package:time_tracker/screens/clickup_settings/widgets/clickup_sync_button.dart';
import 'package:time_tracker/screens/clickup_settings/widgets/clickup_sync_status_section.dart';
import 'package:time_tracker/screens/clickup_settings/widgets/clickup_webhook_section.dart';
import 'package:time_tracker/screens/clickup_settings/widgets/clickup_workspace_section.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class ClickUpSettingsScreen extends StatefulWidget {
  const ClickUpSettingsScreen({super.key});

  @override
  State<ClickUpSettingsScreen> createState() => _ClickUpSettingsScreenState();
}

class _ClickUpSettingsScreenState extends State<ClickUpSettingsScreen> {
  late final ClickupSettingsCubit _cubit;
  final _apiTokenController = TextEditingController();
  String? _lastToastMessage;

  @override
  void initState() {
    super.initState();
    _cubit = ClickupSettingsCubit(
      AppDependencies.instance.workspaceRepository,
      AppDependencies.instance.projectsRepository,
    );
  }

  @override
  void dispose() {
    _apiTokenController.dispose();
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(ClickupSettingsState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(context, message, type: state.toastType ?? AppToastType.info);
    });
    _cubit.clearToast();
  }

  Future<void> _confirmDeleteWebhook() async {
    final confirm = await showClickUpDeleteWebhookDialog(context);
    if (confirm == true) {
      await _cubit.deleteWebhook();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: AppBar(
        title: const Text('ClickUp Integration'),
        backgroundColor: AppTheme.cardDark,
        actions: [ClickUpQuickSyncAction(cubit: _cubit, onQuickSync: _cubit.syncTasksIncremental)],
      ),
      body: CubitBuilder<ClickupSettingsCubit, ClickupSettingsState>(
        cubit: _cubit,
        builder: (context, state) {
          _handleToast(state);

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClickUpApiTokenSection(
                  controller: _apiTokenController,
                  hasToken: state.settings?.hasApiToken == true,
                  isSaving: state.isSaving,
                  onSave: _cubit.saveApiToken,
                ),
                if (state.settings?.hasApiToken == true) ...[
                  const SizedBox(height: 24),
                  ClickUpSyncStatusSection(
                    lastSyncAt: state.settings?.lastSyncAt,
                    lastSyncTaskCount: state.settings?.lastSyncTaskCount ?? 0,
                    selectedListCount: state.selectedListIds.length,
                  ),
                  const SizedBox(height: 24),
                  ClickUpWebhookSection(
                    hasWebhook: state.settings?.webhookId != null,
                    selectedWorkspaceId: state.selectedWorkspaceId,
                    onEnable: _cubit.createWebhookManually,
                    onRemove: _confirmDeleteWebhook,
                  ),
                  const SizedBox(height: 24),
                  ClickUpWorkspaceSection(
                    workspaces: state.workspaces,
                    selectedWorkspaceId: state.selectedWorkspaceId,
                    onSelectWorkspace: _cubit.selectWorkspace,
                  ),
                  if (state.selectedWorkspaceId != null) ...[
                    const SizedBox(height: 24),
                    ClickUpSpacesSection(
                      spaces: state.spaces,
                      foldersBySpace: state.foldersBySpace,
                      folderlessListsBySpace: state.folderlessListsBySpace,
                      expandedSpaces: state.expandedSpaces,
                      expandedFolders: state.expandedFolders,
                      selectedListIds: state.selectedListIds,
                      listProjectAssignments: state.listProjectAssignments,
                      projects: state.projects,
                      onToggleSpace: _cubit.toggleSpaceExpanded,
                      onToggleFolder: _cubit.toggleFolderExpanded,
                      onToggleList: _cubit.toggleListSelection,
                      onAssignProject: _cubit.assignProjectToList,
                    ),
                  ],
                  const SizedBox(height: 24),
                  ClickUpSyncButton(
                    isSyncing: state.isSyncing,
                    selectedListCount: state.selectedListIds.length,
                    onSync: _cubit.syncTasks,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
