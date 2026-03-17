import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/models/integrations/jira_issue.dart';
import 'package:time_tracker/screens/jira_settings/cubit/jira_settings_cubit.dart';
import 'package:time_tracker/screens/jira_settings/cubit/jira_settings_state.dart';
import 'package:time_tracker/screens/jira_settings/widgets/jira_credentials_section.dart';
import 'package:time_tracker/screens/jira_settings/widgets/jira_projects_section.dart';
import 'package:time_tracker/screens/jira_settings/widgets/jira_sync_button.dart';
import 'package:time_tracker/screens/jira_settings/widgets/jira_sync_status_section.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class JiraSettingsScreen extends StatefulWidget {
  const JiraSettingsScreen({super.key});

  @override
  State<JiraSettingsScreen> createState() => _JiraSettingsScreenState();
}

class _JiraSettingsScreenState extends State<JiraSettingsScreen> {
  late final JiraSettingsCubit _cubit;
  final _domainController = TextEditingController();
  final _emailController = TextEditingController();
  final _apiTokenController = TextEditingController();
  String? _lastToastMessage;
  JiraSettings? _lastSettings;

  @override
  void initState() {
    super.initState();
    _cubit = JiraSettingsCubit(AppDependencies.instance.timeDataProvider);
  }

  @override
  void dispose() {
    _domainController.dispose();
    _emailController.dispose();
    _apiTokenController.dispose();
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(JiraSettingsState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(context, message, type: state.toastType ?? AppToastType.info);
    });
    _cubit.clearToast();
  }

  void _syncControllers(JiraSettingsState state) {
    final settings = state.settings;
    if (settings != null && settings != _lastSettings) {
      if (_domainController.text.isEmpty && settings.domain != null) {
        _domainController.text = settings.domain!;
      }
      if (_emailController.text.isEmpty && settings.email != null) {
        _emailController.text = settings.email!;
      }
      _lastSettings = settings;
    }

    if (state.shouldClearApiToken) {
      _apiTokenController.clear();
      _cubit.clearApiTokenFlag();
    }
  }

  bool _isConfigured(JiraSettings? settings) {
    if (settings == null) return false;
    return settings.hasApiToken && (settings.domain?.isNotEmpty ?? false) && (settings.email?.isNotEmpty ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: AppBar(title: const Text('Jira Integration'), backgroundColor: AppTheme.cardDark),
      body: CubitBuilder<JiraSettingsCubit, JiraSettingsState>(
        cubit: _cubit,
        builder: (context, state) {
          _handleToast(state);
          _syncControllers(state);

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JiraCredentialsSection(
                  domainController: _domainController,
                  emailController: _emailController,
                  apiTokenController: _apiTokenController,
                  hasToken: state.settings?.hasApiToken == true,
                  isSaving: state.isSaving,
                  isTesting: state.isTesting,
                  onTestConnection: () {
                    _cubit.testConnection(
                      domain: _domainController.text,
                      email: _emailController.text,
                      apiToken: _apiTokenController.text,
                    );
                  },
                  onSave: () {
                    _cubit.saveCredentials(
                      domain: _domainController.text,
                      email: _emailController.text,
                      apiToken: _apiTokenController.text,
                    );
                  },
                ),
                const SizedBox(height: 24),
                JiraSyncStatusSection(
                  lastSyncAt: state.settings?.lastSyncAt,
                  lastSyncIssueCount: state.settings?.lastSyncIssueCount ?? 0,
                  selectedProjectCount: state.selectedProjectIds.length,
                ),
                const SizedBox(height: 24),
                JiraProjectsSection(
                  isConfigured: _isConfigured(state.settings),
                  projects: state.projects,
                  projectsLoaded: state.projectsLoaded,
                  selectedProjectIds: state.selectedProjectIds,
                  onToggleProject: _cubit.toggleProjectSelection,
                ),
                const SizedBox(height: 24),
                JiraSyncButton(
                  isSyncing: state.isSyncing,
                  selectedProjectCount: state.selectedProjectIds.length,
                  onSync: _cubit.syncIssues,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
