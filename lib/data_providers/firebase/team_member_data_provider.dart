import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/org/team_member.dart';
import 'firebase_core_data_provider.dart';

class TeamMemberDataProvider {
  TeamMemberDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  CollectionReference<Map<String, dynamic>> get _teamMembersCollection => _core.organizationCollection('teamMembers');
  CollectionReference<Map<String, dynamic>> get _usersCollection => _core.firestore.collection('users');

  Stream<List<TeamMember>> watchTeamMembers() {
    return _teamMembersCollection.snapshots().map((snapshot) {
      final members = snapshot.docs.map((doc) => TeamMember.fromFirestore(doc)).toList();
      members.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return members;
    });
  }

  Future<void> addTeamMember(TeamMember member) async {
    await _teamMembersCollection.add(member.toFirestore());
  }

  Future<void> updateTeamMember(TeamMember member) async {
    await _teamMembersCollection.doc(member.id).update(member.toFirestore());
  }

  Future<void> deleteTeamMember(String id) async {
    await _teamMembersCollection.doc(id).delete();
  }

  Future<void> syncUserRoleFromTeamMember(TeamMember member) async {
    final firebaseUid = member.firebaseUid;
    if (firebaseUid == null || firebaseUid.isEmpty) {
      return;
    }

    await _usersCollection.doc(firebaseUid).set({'role': member.role.value}, SetOptions(merge: true));
  }
}
