import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_repositories/firebase/projects_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/widgets/app_toast.dart';
import 'projects_state.dart';

class ProjectsCubit extends BaseCubit<ProjectsState> {
  ProjectsCubit(this._workspaceRepository, this._projectsRepository) : super(ProjectsState.initial()) {
    _workspaceRepository.addListener(_syncFromWorkspace);
    _syncFromWorkspace();
  }

  final WorkspaceRepository _workspaceRepository;
  final ProjectsRepository _projectsRepository;

  void _syncFromWorkspace() {
    final projects = List<Project>.from(_workspaceRepository.projects)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    final cards =
        projects.map((project) {
          final clientName =
              project.clientId == null ? null : _workspaceRepository.getClientById(project.clientId!)?.name;
          final teamMembers =
              project.teamMemberIds.map(_workspaceRepository.getTeamMemberById).whereType<TeamMember>().toList();
          final projectEntries =
              _workspaceRepository.timeEntries.where((entry) => entry.projectId == project.id).toList();
          final totalMinutes = projectEntries.fold<int>(0, (sum, entry) => sum + entry.durationMinutes);
          final thisMonthMinutes = projectEntries
              .where((entry) => !entry.date.isBefore(startOfMonth))
              .fold<int>(0, (sum, entry) => sum + entry.durationMinutes);

          return ProjectCardData(
            project: project,
            clientName: clientName,
            teamMembers: teamMembers,
            totalMinutes: totalMinutes,
            thisMonthMinutes: thisMonthMinutes,
          );
        }).toList();

    emit(
      state.copyWith(
        cards: cards,
        clients: _workspaceRepository.clients,
        teamMembers: _workspaceRepository.teamMembers,
      ),
    );
  }

  Future<bool> saveProject({
    Project? existing,
    required String name,
    String? description,
    String? clientId,
    required List<String> teamMemberIds,
    required String color,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      emit(state.copyWith(toastMessage: 'Please enter a project name', toastType: AppToastType.error));
      return false;
    }

    final trimmedDescription = description?.trim();

    if (existing == null) {
      _projectsRepository.addProject(
        Project(
          id: '',
          name: trimmedName,
          description: trimmedDescription == null || trimmedDescription.isEmpty ? null : trimmedDescription,
          clientId: clientId,
          teamMemberIds: teamMemberIds,
          color: color,
          createdAt: DateTime.now(),
        ),
      );
    } else {
      _projectsRepository.updateProject(
        existing.copyWith(
          name: trimmedName,
          description: trimmedDescription == null || trimmedDescription.isEmpty ? null : trimmedDescription,
          clientId: clientId,
          teamMemberIds: teamMemberIds,
          color: color,
        ),
      );
    }

    return true;
  }

  void deleteProject(Project project) {
    _projectsRepository.deleteProject(project.id);
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  @override
  void dispose() {
    _workspaceRepository.removeListener(_syncFromWorkspace);
    super.dispose();
  }
}
