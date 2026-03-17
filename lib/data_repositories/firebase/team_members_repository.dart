import 'dart:async';

import '../../data_providers/firebase/organization_data_provider.dart';
import '../../data_providers/firebase/team_member_data_provider.dart';
import '../../models/org/team_member.dart';
import '../data_repository.dart';

class TeamMembersRepository extends DataRepository<List<TeamMember>, void> {
  TeamMembersRepository(this._dataProvider, this._organizationProvider) : super(const []);

  final TeamMemberDataProvider _dataProvider;
  final OrganizationDataProvider _organizationProvider;
  StreamSubscription<List<TeamMember>>? _subscription;

  void start() {
    if (_subscription != null) return;
    _subscription = _dataProvider.watchTeamMembers().listen(
      (members) => emit(_dedupeTeamMembers(members)),
      onError: emitError,
    );
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    emit(const []);
  }

  @override
  Future<List<TeamMember>> fetch(void _) async {
    try {
      final members = await _dataProvider.watchTeamMembers().first;
      emit(members);
      return members;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  Future<void> addTeamMember(TeamMember member) async {
    await _dataProvider.addTeamMember(member);
    if (member.email.isNotEmpty) {
      await _organizationProvider.inviteOrganizationMember(email: member.email, role: member.role);
    }
  }

  Future<void> updateTeamMember(TeamMember member) async {
    await _dataProvider.updateTeamMember(member);
  }

  Future<void> syncUserRoleFromTeamMember(TeamMember member) async {
    await _dataProvider.syncUserRoleFromTeamMember(member);
  }

  Future<void> deleteTeamMember(String id) async {
    await _dataProvider.deleteTeamMember(id);
  }

  List<TeamMember> _dedupeTeamMembers(List<TeamMember> members) {
    if (members.isEmpty) {
      return members;
    }

    String groupKey(TeamMember member) {
      final firebaseUid = (member.firebaseUid ?? '').trim();
      if (firebaseUid.isNotEmpty) {
        return 'uid:$firebaseUid';
      }
      final email = member.email.trim().toLowerCase();
      if (email.isNotEmpty) {
        return 'email:$email';
      }
      return 'id:${member.id}';
    }

    int rolePriority(TeamMemberRole role) {
      switch (role) {
        case TeamMemberRole.admin:
          return 4;
        case TeamMemberRole.manager:
          return 3;
        case TeamMemberRole.regular:
          return 2;
        case TeamMemberRole.client:
          return 1;
      }
    }

    TeamMember mergeMember(TeamMember current, TeamMember candidate) {
      final preferredId =
          (candidate.firebaseUid != null && candidate.id == candidate.firebaseUid)
              ? candidate.id
              : ((current.firebaseUid != null && current.id == current.firebaseUid) ? current.id : current.id);
      final preferredRole = rolePriority(candidate.role) > rolePriority(current.role) ? candidate.role : current.role;

      return TeamMember(
        id: preferredId,
        name: candidate.name.trim().length > current.name.trim().length ? candidate.name : current.name,
        email: candidate.email.trim().length > current.email.trim().length ? candidate.email : current.email,
        role: preferredRole,
        userId: candidate.userId.isNotEmpty ? candidate.userId : current.userId,
        firebaseUid: candidate.firebaseUid ?? current.firebaseUid,
        createdAt: current.createdAt.isBefore(candidate.createdAt) ? current.createdAt : candidate.createdAt,
      );
    }

    final Map<String, TeamMember> grouped = {};
    for (final member in members) {
      final key = groupKey(member);
      if (grouped.containsKey(key)) {
        grouped[key] = mergeMember(grouped[key]!, member);
      } else {
        grouped[key] = member;
      }
    }

    return grouped.values.toList();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
