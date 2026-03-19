part of 'auth_data_provider.dart';

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

extension AuthProviderActions on AuthDataProvider {
  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
      case 'invalid-email':
        return 'Invalid email or password';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Try again later';
      case 'email-already-in-use':
        return 'This email is already in use';
      case 'weak-password':
        return 'Password is too weak';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled';
      default:
        return e.message ?? 'Authentication failed';
    }
  }

  Future<void> refreshInvites() async {
    _isLoadingInvites = true;
    notifyListeners();
    await _refreshInvitesInternal();
    _isLoadingInvites = false;
    notifyListeners();
  }

  Future<bool> acceptOrganizationInvite(OrganizationInvite invite) async {
    final user = _user;
    final appUser = _appUser;
    if (user == null || appUser == null) {
      _error = 'User is not authenticated';
      notifyListeners();
      return false;
    }

    _isLoadingInvites = true;
    _error = null;
    notifyListeners();
    await _firebaseService.acceptOrganizationInvite(organizationId: invite.organizationId, inviteId: invite.id);

    final updatedOrgIds =
        appUser.organizationIds.contains(invite.organizationId)
            ? appUser.organizationIds
            : [...appUser.organizationIds, invite.organizationId];

    _appUser = appUser.copyWith(organizationIds: updatedOrgIds, activeOrganizationId: invite.organizationId);
    await setActiveOrganization(invite.organizationId, notify: false);
    await _refreshOrganizationsInternal();
    await _refreshInvitesInternal();
    notifyListeners();
    _isLoadingInvites = false;
    notifyListeners();
    return true;
  }

  Future<void> refreshOrganizations() async {
    final appUser = _appUser;
    if (appUser == null) return;

    _isLoadingOrganizations = true;
    notifyListeners();
    await _refreshOrganizationsInternal();
    await _refreshInvitesInternal();
    if (_organizations.isNotEmpty && (appUser.activeOrganizationId == null || appUser.activeOrganizationId!.isEmpty)) {
      final fallbackOrgId = appUser.defaultOrganizationId ?? _organizations.first.id;
      await setActiveOrganization(fallbackOrgId, notify: false);
    }
    _isLoadingOrganizations = false;
    notifyListeners();
  }

  Future<bool> createOrganization(String name) async {
    final user = _user;
    final appUser = _appUser;
    if (user == null || appUser == null) {
      _error = 'User is not authenticated';
      notifyListeners();
      return false;
    }

    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      _error = 'Organization name is required';
      notifyListeners();
      return false;
    }

    _isLoadingOrganizations = true;
    _error = null;
    notifyListeners();

    final organization = await _firebaseService.createOrganization(
      name: trimmedName,
      ownerUserId: user.uid,
      ownerEmail: user.email ?? appUser.email,
    );

    final updatedOrgIds =
        appUser.organizationIds.contains(organization.id)
            ? appUser.organizationIds
            : [...appUser.organizationIds, organization.id];
    _appUser = appUser.copyWith(
      organizationIds: updatedOrgIds,
      defaultOrganizationId: appUser.defaultOrganizationId ?? organization.id,
      activeOrganizationId: organization.id,
      role: TeamMemberRole.admin,
    );
    await _refreshOrganizationsInternal();
    notifyListeners();
    _isLoadingOrganizations = false;
    notifyListeners();
    return true;
  }

  Future<void> setActiveOrganization(String organizationId, {bool notify = true}) async {
    final user = _user;
    final appUser = _appUser;
    if (user == null || appUser == null) return;

    await _firebaseService.setActiveOrganizationForUser(user.uid, organizationId);
    _firebaseService.setActiveOrganizationId(organizationId);

    final member = await _firebaseService.getOrganizationMember(organizationId, user.uid);
    final mappedRole = _mapRole(member?.role);
    var updatedUser = appUser.copyWith(activeOrganizationId: organizationId, role: mappedRole ?? appUser.role);

    if (mappedRole == TeamMemberRole.client && (updatedUser.clientId == null || updatedUser.clientId!.isEmpty)) {
      final resolvedClientId = await _firebaseService.findClientIdByEmail(
        organizationId: organizationId,
        email: updatedUser.email,
      );
      if (resolvedClientId != null && resolvedClientId.isNotEmpty) {
        await _firestore.collection('users').doc(user.uid).set({'clientId': resolvedClientId}, SetOptions(merge: true));
        updatedUser = updatedUser.copyWith(clientId: resolvedClientId);
      } else {}
    }

    _appUser = updatedUser;

    if (notify) {
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    _accessDenied = false;
    notifyListeners();
    try {
      await _firebaseService.signInWithEmail(email, password);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _mapAuthError(e);
      return false;
    } catch (_) {
      _error = 'Authentication failed';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String password) async {
    _isLoading = true;
    _error = null;
    _accessDenied = false;
    notifyListeners();
    try {
      await _firebaseService.signUpWithEmail(email, password);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _mapAuthError(e);
      return false;
    } catch (_) {
      _error = 'Failed to create account';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
    _firebaseService.setActiveOrganizationId(null);
    _appUser = null;
    _organizations = [];
    _pendingInvites = [];
    _accessDenied = false;
    notifyListeners();
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _firebaseService.sendPasswordResetEmail(email);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _mapAuthError(e);
      return false;
    } catch (_) {
      _error = 'Failed to send reset email';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
