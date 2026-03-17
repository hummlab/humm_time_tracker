import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCoreDataProvider {
  FirebaseCoreDataProvider({FirebaseFirestore? firestore, FirebaseAuth? auth, FirebaseFunctions? functions})
    : firestore = firestore ?? FirebaseFirestore.instance,
      auth = auth ?? FirebaseAuth.instance,
      functions = functions ?? FirebaseFunctions.instanceFor(region: 'europe-west1');

  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseFunctions functions;

  static String? _activeOrganizationId;

  String? get currentUserId => auth.currentUser?.uid;
  String? get activeOrganizationId => _activeOrganizationId;

  static String? get currentActiveOrganizationId => _activeOrganizationId;

  void setActiveOrganizationId(String? organizationId) {
    _activeOrganizationId = organizationId;
  }

  CollectionReference<Map<String, dynamic>> organizationCollection(String name) {
    final orgId = _activeOrganizationId;
    if (orgId == null || orgId.isEmpty) {
      throw StateError('Active organization is not set');
    }
    return firestore.collection('organizations').doc(orgId).collection(name);
  }
}
