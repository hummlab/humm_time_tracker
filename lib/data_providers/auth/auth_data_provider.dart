import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/auth/app_user.dart';
import '../../models/org/organization.dart';
import '../../models/org/organization_invite.dart';
import '../../models/org/organization_member.dart';
import '../../models/org/team_member.dart';
import '../firebase/firebase_data_provider.dart';

part 'auth_data_provider_access.dart';
part 'auth_data_provider_actions.dart';

class AuthDataProvider extends ChangeNotifier {
  final FirebaseDataProvider _firebaseService = FirebaseDataProvider();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  AppUser? _appUser;
  bool _isLoading = false;
  bool _isCheckingAccess = false;
  bool _isLoadingOrganizations = false;
  bool _isLoadingInvites = false;
  String? _error;
  bool _accessDenied = false;
  List<Organization> _organizations = [];
  List<OrganizationInvite> _pendingInvites = [];

  User? get user => _user;
  AppUser? get appUser => _appUser;
  bool get isLoading => _isLoading;
  bool get isCheckingAccess => _isCheckingAccess;
  bool get isLoadingOrganizations => _isLoadingOrganizations;
  bool get isLoadingInvites => _isLoadingInvites;
  String? get error => _error;
  bool get isAuthenticated => _user != null && _appUser != null && !_accessDenied;
  bool get accessDenied => _accessDenied;
  List<Organization> get organizations => _organizations;
  List<OrganizationInvite> get pendingInvites => _pendingInvites;
  String? get activeOrganizationId => _appUser?.activeOrganizationId;
  bool get needsOrganizationSetup =>
      _appUser != null && (_appUser!.activeOrganizationId == null || _appUser!.activeOrganizationId!.isEmpty);

  // Role-based access
  TeamMemberRole get userRole => _appUser?.role ?? TeamMemberRole.regular;
  bool get isAdmin => _appUser?.isAdmin ?? false;
  bool get isManager => _appUser?.isManager ?? false;
  bool get isClient => _appUser?.isClient ?? false;
  bool get hasManagerAccess => _appUser?.hasManagerAccess ?? false;

  /// Returns the current user's Firebase UID
  String? get currentUserId => _appUser?.id;

  /// Returns the client ID if the user is a client
  String? get clientId => _appUser?.clientId;

  AuthDataProvider() {
    _firebaseService.authStateChanges.listen((user) async {
      _user = user;
      if (user != null) {
        _isCheckingAccess = true;
        notifyListeners();
        await _loadUserRole(user.uid, user.email ?? '');
        _isCheckingAccess = false;
      } else {
        _appUser = null;
        _accessDenied = false;
      }
      notifyListeners();
    });
  }
}
