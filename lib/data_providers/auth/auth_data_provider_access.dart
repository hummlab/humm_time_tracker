part of 'auth_data_provider.dart';

extension AuthProviderAccess on AuthDataProvider {
  Future<void> _loadUserRole(String uid, String email) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      _appUser = AppUser.fromFirestore(userDoc);
    } else {
      _appUser = AppUser(
        id: uid,
        email: email,
        role: TeamMemberRole.regular,
        createdAt: DateTime.now(),
        organizationIds: const [],
      );
      await _firestore.collection('users').doc(uid).set(_appUser!.toFirestore());
    }

    if (_appUser == null) {
      _accessDenied = true;
      return;
    }

    if (_appUser!.organizationIds.isEmpty) {
      final resolved = await _firebaseService.resolveMyOrganizations(persistToUserDoc: true);
      final recoveredIds = (resolved['organizationIds'] as List<Object?>? ?? const []).whereType<String>().toList();
      final resolvedDefaultOrg = resolved['defaultOrganizationId'] as String?;
      final resolvedActiveOrg = resolved['activeOrganizationId'] as String?;
      if (recoveredIds.isNotEmpty) {
        _appUser = _appUser!.copyWith(
          organizationIds: recoveredIds,
          defaultOrganizationId: _appUser!.defaultOrganizationId ?? resolvedDefaultOrg,
          activeOrganizationId: _appUser!.activeOrganizationId ?? resolvedActiveOrg,
        );
      }
    }

    await _refreshOrganizationsInternal();

    final appUser = _appUser!;
    String? activeOrganizationId = appUser.activeOrganizationId;
    if ((activeOrganizationId != null && activeOrganizationId.isNotEmpty) &&
        !appUser.organizationIds.contains(activeOrganizationId)) {
      activeOrganizationId = null;
      await _firestore.collection('users').doc(uid).set({'activeOrganizationId': null}, SetOptions(merge: true));
      _appUser = appUser.copyWith(activeOrganizationId: null);
    }

    if ((activeOrganizationId == null || activeOrganizationId.isEmpty) && appUser.organizationIds.isNotEmpty) {
      activeOrganizationId = appUser.defaultOrganizationId ?? appUser.organizationIds.first;
      await _firestore.collection('users').doc(uid).set({
        'activeOrganizationId': activeOrganizationId,
      }, SetOptions(merge: true));
      _appUser = appUser.copyWith(activeOrganizationId: activeOrganizationId);
    }

    _firebaseService.setActiveOrganizationId(_appUser?.activeOrganizationId);

    final currentOrgId = _appUser?.activeOrganizationId;
    if (currentOrgId != null && currentOrgId.isNotEmpty) {
      final member = await _firebaseService.getOrganizationMember(currentOrgId, uid);
      final mappedRole = _mapRole(member?.role);
      if (mappedRole != null && _appUser != null) {
        _appUser = _appUser!.copyWith(role: mappedRole);

        if (mappedRole == TeamMemberRole.client &&
            currentOrgId.isNotEmpty &&
            (_appUser!.clientId == null || _appUser!.clientId!.isEmpty)) {
          final resolvedClientId = await _firebaseService.findClientIdByEmail(
            organizationId: currentOrgId,
            email: _appUser!.email,
          );
          if (resolvedClientId != null && resolvedClientId.isNotEmpty) {
            await _firestore.collection('users').doc(uid).set({'clientId': resolvedClientId}, SetOptions(merge: true));
            _appUser = _appUser!.copyWith(clientId: resolvedClientId);
          }
        }
      }
    }

    await _refreshInvitesInternal();
    _accessDenied = false;
  }

  Future<void> _refreshOrganizationsInternal() async {
    final appUser = _appUser;
    if (appUser == null) {
      _organizations = [];
      return;
    }
    _organizations = await _firebaseService.getOrganizationsByIds(appUser.organizationIds);
  }

  Future<void> _refreshInvitesInternal() async {
    _pendingInvites = await _firebaseService.getMyPendingOrganizationInvites();
  }

  TeamMemberRole? _mapRole(OrganizationRole? role) {
    switch (role) {
      case OrganizationRole.owner:
      case OrganizationRole.admin:
        return TeamMemberRole.admin;
      case OrganizationRole.manager:
        return TeamMemberRole.manager;
      case OrganizationRole.client:
        return TeamMemberRole.client;
      case OrganizationRole.member:
        return TeamMemberRole.regular;
      case null:
        return null;
    }
  }
}
