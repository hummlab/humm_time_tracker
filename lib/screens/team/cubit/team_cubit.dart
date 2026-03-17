import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_repositories/firebase/team_members_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/widgets/app_toast.dart';
import 'team_state.dart';

class TeamCubit extends BaseCubit<TeamState> {
  TeamCubit(this._workspaceRepository, this._teamMembersRepository, this._authDataProvider)
    : super(TeamState.initial()) {
    _workspaceRepository.addListener(_syncFromSources);
    _authDataProvider.addListener(_syncFromSources);
    _syncFromSources();
  }

  final WorkspaceRepository _workspaceRepository;
  final TeamMembersRepository _teamMembersRepository;
  final AuthDataProvider _authDataProvider;

  void _syncFromSources() {
    final cards = <TeamMemberCardData>[];
    for (final member in _workspaceRepository.teamMembers) {
      final memberProjects =
          _workspaceRepository.projects.where((project) => project.teamMemberIds.contains(member.id)).toList();
      cards.add(
        TeamMemberCardData(
          member: member,
          projectCount: memberProjects.length,
          projectNames: memberProjects.map((project) => project.name).toList(),
        ),
      );
    }

    emit(state.copyWith(cards: cards, isAdmin: _authDataProvider.isAdmin, isManager: _authDataProvider.isManager));
  }

  TeamMemberDialogConfig dialogConfigFor(TeamMember? member) {
    final isAdminUser = _authDataProvider.isAdmin;
    final isEditingAdminMember = member?.role == TeamMemberRole.admin;
    final canChangeRole = isAdminUser || !isEditingAdminMember;
    final canEditName = isAdminUser || !isEditingAdminMember;
    final availableRoles = TeamMemberRole.values.where((role) => isAdminUser || role != TeamMemberRole.admin).toList();

    return TeamMemberDialogConfig(
      canChangeRole: canChangeRole,
      canEditName: canEditName,
      availableRoles: availableRoles,
    );
  }

  Future<bool> saveMember({
    TeamMember? existing,
    required String name,
    required String email,
    required TeamMemberRole role,
  }) async {
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();

    if (trimmedName.isEmpty) {
      emit(state.copyWith(toastMessage: 'Please enter a name', toastType: AppToastType.error));
      return false;
    }

    if (existing == null && trimmedEmail.isEmpty) {
      emit(state.copyWith(toastMessage: 'Please enter an email', toastType: AppToastType.error));
      return false;
    }

    if (existing == null) {
      final currentUserId = _authDataProvider.currentUserId;
      if (currentUserId == null) {
        emit(state.copyWith(toastMessage: 'User is not authenticated', toastType: AppToastType.error));
        return false;
      }

      await _teamMembersRepository.addTeamMember(
        TeamMember(
          id: '',
          name: trimmedName,
          email: trimmedEmail,
          role: role,
          userId: currentUserId,
          firebaseUid: null,
          createdAt: DateTime.now(),
        ),
      );

      emit(state.copyWith(toastMessage: 'Member added and invited', toastType: AppToastType.success));
      return true;
    }

    final updated = existing.copyWith(name: trimmedName, role: role);
    _teamMembersRepository.updateTeamMember(updated);
    _teamMembersRepository.syncUserRoleFromTeamMember(updated);
    return true;
  }

  void deleteMember(TeamMember member) {
    _teamMembersRepository.deleteTeamMember(member.id);
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  @override
  void dispose() {
    _workspaceRepository.removeListener(_syncFromSources);
    _authDataProvider.removeListener(_syncFromSources);
    super.dispose();
  }
}

class TeamMemberDialogConfig {
  TeamMemberDialogConfig({required this.canChangeRole, required this.canEditName, required this.availableRoles});

  final bool canChangeRole;
  final bool canEditName;
  final List<TeamMemberRole> availableRoles;
}
