import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_core_data_provider.dart';

class FirebaseAuthDataProvider {
  FirebaseAuthDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  String? get currentUserId => _core.currentUserId;

  Stream<User?> get authStateChanges => _core.auth.authStateChanges();

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return _core.auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return _core.auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _core.auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _core.auth.sendPasswordResetEmail(email: email);
  }
}
