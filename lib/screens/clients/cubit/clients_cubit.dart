import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_repositories/firebase/clients_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/widgets/app_toast.dart';

import 'clients_state.dart';

class ClientsCubit extends BaseCubit<ClientsState> {
  ClientsCubit(this._workspaceRepository, this._clientsRepository)
    : super(ClientsState.initial()) {
    _workspaceRepository.addListener(_syncFromSources);
    _syncFromSources();
  }

  final WorkspaceRepository _workspaceRepository;
  final ClientsRepository _clientsRepository;

  void _syncFromSources() {
    final clients = _workspaceRepository.clients;
    final projects = _workspaceRepository.projects;
    final counts = <String, int>{};

    for (final client in clients) {
      counts[client.id] = projects.where((p) => p.clientId == client.id).length;
    }

    emit(state.copyWith(clients: clients, projectCountsByClientId: counts));
  }

  int projectCountFor(String clientId) {
    return state.projectCountsByClientId[clientId] ?? 0;
  }

  Future<bool> saveClient({
    Client? existing,
    required String name,
    required List<String> linkedEmails,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      emit(
        state.copyWith(
          toastMessage: 'Please enter a client name',
          toastType: AppToastType.error,
        ),
      );
      return false;
    }

    emit(state.copyWith(isProcessing: true));

    final success =
        existing == null
            ? await _clientsRepository.addClientSafe(
              Client(
                id: '',
                name: trimmedName,
                createdAt: DateTime.now(),
                linkedEmails: linkedEmails,
              ),
            )
            : await _clientsRepository.updateClientSafe(
              existing.copyWith(name: trimmedName, linkedEmails: linkedEmails),
            );

    emit(state.copyWith(isProcessing: false));

    if (!success) {
      emit(
        state.copyWith(
          toastMessage:
              existing == null
                  ? 'Failed to create client'
                  : 'Failed to update client',
          toastType: AppToastType.error,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> deleteClient(Client client) async {
    emit(state.copyWith(isProcessing: true));
    final success = await _clientsRepository.deleteClientSafe(client.id);
    emit(state.copyWith(isProcessing: false));

    if (!success) {
      emit(
        state.copyWith(
          toastMessage: 'Failed to delete client',
          toastType: AppToastType.error,
        ),
      );
    }
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  @override
  void dispose() {
    _workspaceRepository.removeListener(_syncFromSources);
    super.dispose();
  }
}
