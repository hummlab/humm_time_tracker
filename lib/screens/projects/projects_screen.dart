import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/screens/projects/cubit/projects_cubit.dart';
import 'package:time_tracker/screens/projects/cubit/projects_state.dart';
import 'package:time_tracker/screens/projects/widgets/project_form_dialog.dart';
import 'package:time_tracker/screens/projects/widgets/projects_empty_state.dart';
import 'package:time_tracker/screens/projects/widgets/projects_grid.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late final ProjectsCubit _cubit;
  String? _lastToastMessage;

  @override
  void initState() {
    super.initState();
    _cubit = ProjectsCubit(AppDependencies.instance.workspaceRepository, AppDependencies.instance.projectsRepository);
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(ProjectsState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(context, message, type: state.toastType ?? AppToastType.info);
    });
    _cubit.clearToast();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return CubitBuilder<ProjectsCubit, ProjectsState>(
      cubit: _cubit,
      builder: (context, state) {
        _handleToast(state);

        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddProjectDialog(context, state),
            icon: const Icon(Icons.add),
            label: const Text('New Project'),
          ),
          body:
              state.cards.isEmpty
                  ? ProjectsEmptyState(onAddProject: () => _showAddProjectDialog(context, state))
                  : ProjectsGrid(
                    cards: state.cards,
                    isDesktop: isDesktop,
                    onTap: (project) {
                      _showEditProjectDialog(context, state, project);
                    },
                    onDelete: (project) {
                      _confirmDelete(context, project);
                    },
                  ),
        );
      },
    );
  }

  void _showAddProjectDialog(BuildContext context, ProjectsState state) {
    _showProjectDialog(context, state, null);
  }

  void _showEditProjectDialog(BuildContext context, ProjectsState state, Project project) {
    _showProjectDialog(context, state, project);
  }

  Future<void> _showProjectDialog(BuildContext context, ProjectsState state, Project? project) async {
    await showDialog<void>(
      context: context,
      builder:
          (context) => ProjectFormDialog(
            cubit: _cubit,
            project: project,
            clients: state.clients,
            teamMembers: state.teamMembers,
          ),
    );
  }

  void _confirmDelete(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Project'),
          content: Text('Are you sure you want to delete "${project.name}"? This cannot be undone.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                _cubit.deleteProject(project);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.tertiaryAccent),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
