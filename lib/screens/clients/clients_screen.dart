import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/screens/client_dashboard/client_dashboard_screen.dart';
import 'package:time_tracker/screens/clients/cubit/clients_cubit.dart';
import 'package:time_tracker/screens/clients/cubit/clients_state.dart';
import 'package:time_tracker/screens/clients/widgets/client_dialogs.dart';
import 'package:time_tracker/screens/clients/widgets/clients_empty_state.dart';
import 'package:time_tracker/screens/clients/widgets/clients_list.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late final ClientsCubit _cubit;
  String? _lastToastMessage;

  @override
  void initState() {
    super.initState();
    _cubit = ClientsCubit(
      AppDependencies.instance.workspaceRepository,
      AppDependencies.instance.clientsRepository,
    );
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(ClientsState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(
        context,
        message,
        type: state.toastType ?? AppToastType.info,
      );
    });
    _cubit.clearToast();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return CubitBuilder<ClientsCubit, ClientsState>(
      cubit: _cubit,
      builder: (context, state) {
        _handleToast(state);

        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddClientDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('New Client'),
          ),
          body:
              state.clients.isEmpty
                  ? ClientsEmptyState(
                    onAddClient: () => _showAddClientDialog(context),
                  )
                  : ClientsList(
                    clients: state.clients,
                    isDesktop: isDesktop,
                    projectCountFor: _cubit.projectCountFor,
                    onEditClient:
                        (client) => _showEditClientDialog(context, client),
                    onDeleteClient: (client) => _confirmDelete(context, client),
                    onPreviewDashboard:
                        (client) => _openDashboardPreview(context, client),
                  ),
        );
      },
    );
  }

  void _showAddClientDialog(BuildContext context) {
    _showClientDialog(context, null);
  }

  void _showEditClientDialog(BuildContext context, Client client) {
    _showClientDialog(context, client);
  }

  Future<void> _showClientDialog(BuildContext context, Client? client) async {
    await showClientDialog(
      context: context,
      client: client,
      onSave: _cubit.saveClient,
    );
  }

  void _confirmDelete(BuildContext context, Client client) {
    showDeleteClientDialog(
      context: context,
      client: client,
      onDelete: _cubit.deleteClient,
    );
  }

  void _openDashboardPreview(BuildContext context, Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ClientDashboardScreen(clientId: client.id, isPreview: true),
      ),
    );
  }
}
