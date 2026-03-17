import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/projects/client.dart';
import 'firebase_core_data_provider.dart';

class ClientDataProvider {
  ClientDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  CollectionReference<Map<String, dynamic>> get _clientsCollection => _core.organizationCollection('clients');

  Stream<List<Client>> watchClients() {
    return _clientsCollection.snapshots().map((snapshot) {
      final clients = snapshot.docs.map((doc) => Client.fromFirestore(doc)).toList();
      clients.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return clients;
    });
  }

  Future<void> addClient(Client client) async {
    await _clientsCollection.add(client.toFirestore());
  }

  Future<void> updateClient(Client client) async {
    await _clientsCollection.doc(client.id).update(client.toFirestore());
  }

  Future<void> deleteClient(String id) async {
    await _clientsCollection.doc(id).delete();
  }

  Future<Client?> getClientById(String clientId) async {
    final doc = await _clientsCollection.doc(clientId).get();
    if (!doc.exists) return null;
    return Client.fromFirestore(doc);
  }

  Future<String?> findClientIdByEmail({required String organizationId, required String email}) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) {
      return null;
    }

    final clientsRef = _core.firestore.collection('organizations').doc(organizationId).collection('clients');

    final directMatch = await clientsRef.where('linkedEmails', arrayContains: normalizedEmail).limit(1).get();
    if (directMatch.docs.isNotEmpty) {
      return directMatch.docs.first.id;
    }

    final allClients = await clientsRef.get();
    for (final doc in allClients.docs) {
      final data = doc.data();
      final linkedEmails =
          (data['linkedEmails'] as List<Object?>? ?? const [])
              .whereType<String>()
              .map((e) => e.trim().toLowerCase())
              .toSet();
      final primaryEmail = (data['email'] as String?)?.trim().toLowerCase();

      if (linkedEmails.contains(normalizedEmail) || primaryEmail == normalizedEmail) {
        return doc.id;
      }
    }

    return null;
  }
}
