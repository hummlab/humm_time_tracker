import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../models/org/organization.dart';
import '../../models/org/organization_invite.dart';
import '../../models/org/organization_member.dart';
import '../../models/org/team_member.dart';
import 'firebase_core_data_provider.dart';

class OrganizationDataProvider {
  OrganizationDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  FirebaseFirestore get _firestore => _core.firestore;
  FirebaseFunctions get _functions => _core.functions;

  Future<List<Organization>> getOrganizationsByIds(List<String> organizationIds) async {
    if (organizationIds.isEmpty) {
      return [];
    }

    final List<Organization> organizations = [];
    for (var i = 0; i < organizationIds.length; i += 10) {
      final batch = organizationIds.skip(i).take(10).toList();
      final snapshot = await _firestore.collection('organizations').where(FieldPath.documentId, whereIn: batch).get();
      organizations.addAll(snapshot.docs.map((doc) => Organization.fromFirestore(doc)));
    }
    organizations.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return organizations;
  }

  Future<Organization> createOrganization({
    required String name,
    required String ownerUserId,
    required String ownerEmail,
  }) async {
    final now = DateTime.now();
    final orgRef = _firestore.collection('organizations').doc();
    final memberRef = orgRef.collection('members').doc(ownerUserId);
    final userRef = _firestore.collection('users').doc(ownerUserId);
    final organization = Organization(
      id: orgRef.id,
      name: name,
      ownerUserId: ownerUserId,
      createdAt: now,
      updatedAt: now,
    );
    final ownerMember = OrganizationMember(
      id: ownerUserId,
      userId: ownerUserId,
      email: ownerEmail,
      role: OrganizationRole.owner,
      createdAt: now,
      isActive: true,
    );

    await orgRef.set(organization.toFirestore());
    await memberRef.set(ownerMember.toFirestore());
    await userRef.set({
      'organizationIds': FieldValue.arrayUnion([orgRef.id]),
      'defaultOrganizationId': orgRef.id,
      'activeOrganizationId': orgRef.id,
    }, SetOptions(merge: true));

    _core.setActiveOrganizationId(orgRef.id);
    return organization;
  }

  Future<void> setActiveOrganizationForUser(String userId, String organizationId) async {
    await _firestore.collection('users').doc(userId).set({
      'activeOrganizationId': organizationId,
    }, SetOptions(merge: true));
    _core.setActiveOrganizationId(organizationId);
  }

  Future<OrganizationMember?> getOrganizationMember(String organizationId, String userId) async {
    final memberDoc =
        await _firestore.collection('organizations').doc(organizationId).collection('members').doc(userId).get();
    if (!memberDoc.exists) {
      return null;
    }
    return OrganizationMember.fromFirestore(memberDoc);
  }

  String _mapTeamRoleToOrganizationRole(TeamMemberRole role) {
    switch (role) {
      case TeamMemberRole.admin:
        return OrganizationRole.admin.value;
      case TeamMemberRole.manager:
        return OrganizationRole.manager.value;
      case TeamMemberRole.client:
        return OrganizationRole.client.value;
      case TeamMemberRole.regular:
        return OrganizationRole.member.value;
    }
  }

  Future<void> inviteOrganizationMember({required String email, required TeamMemberRole role}) async {
    final organizationId = _core.activeOrganizationId;
    if (organizationId == null || organizationId.isEmpty) {
      throw StateError('Active organization is not set');
    }

    final callable = _functions.httpsCallable('inviteOrganizationMember');
    await callable.call({
      'organizationId': organizationId,
      'email': email,
      'role': _mapTeamRoleToOrganizationRole(role),
    });
  }

  Future<List<OrganizationInvite>> getMyPendingOrganizationInvites() async {
    final callable = _functions.httpsCallable('listMyOrganizationInvites');
    final result = await callable.call();
    if (result.data['success'] != true) {
      return [];
    }
    final invites = (result.data['invites'] as List<Object?>? ?? const []);
    return invites.whereType<Map<String, dynamic>>().map(OrganizationInvite.fromFunctionMap).toList();
  }

  Future<void> acceptOrganizationInvite({required String organizationId, required String inviteId}) async {
    final callable = _functions.httpsCallable('acceptOrganizationInvite');
    final result = await callable.call({'organizationId': organizationId, 'inviteId': inviteId});
    if (result.data['success'] != true) {
      final error = result.data['error'] ?? 'Failed to accept invite';
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> resolveMyOrganizations({bool persistToUserDoc = true}) async {
    final callable = _functions.httpsCallable('resolveMyOrganizations');
    final result = await callable.call({'persistToUserDoc': persistToUserDoc});
    return (result.data as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
  }
}
