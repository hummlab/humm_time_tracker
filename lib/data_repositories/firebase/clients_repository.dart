import 'dart:async';

import '../../data_providers/firebase/client_data_provider.dart';
import '../../models/projects/client.dart';
import '../data_repository.dart';

class ClientsRepository extends DataRepository<List<Client>, void> {
  ClientsRepository(this._dataProvider) : super(const []);

  final ClientDataProvider _dataProvider;
  StreamSubscription<List<Client>>? _subscription;

  void start() {
    if (_subscription != null) return;
    _subscription = _dataProvider.watchClients().listen(emit, onError: emitError);
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    emit(const []);
  }

  @override
  Future<List<Client>> fetch(void _) async {
    try {
      final clients = await _dataProvider.watchClients().first;
      emit(clients);
      return clients;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  Future<void> addClient(Client client) async {
    await _dataProvider.addClient(client);
  }

  Future<void> updateClient(Client client) async {
    await _dataProvider.updateClient(client);
  }

  Future<void> deleteClient(String id) async {
    await _dataProvider.deleteClient(id);
  }

  Future<bool> addClientSafe(Client client) async {
    try {
      await _dataProvider.addClient(client);
      return true;
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<bool> updateClientSafe(Client client) async {
    try {
      await _dataProvider.updateClient(client);
      return true;
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<bool> deleteClientSafe(String id) async {
    try {
      await _dataProvider.deleteClient(id);
      return true;
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<Client?> getClientById(String clientId) async {
    return _dataProvider.getClientById(clientId);
  }

  Future<String?> findClientIdByEmail({required String organizationId, required String email}) async {
    return _dataProvider.findClientIdByEmail(organizationId: organizationId, email: email);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
