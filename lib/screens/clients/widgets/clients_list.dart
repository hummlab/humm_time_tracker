import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/screens/clients/widgets/client_card.dart';

class ClientsList extends StatelessWidget {
  const ClientsList({
    super.key,
    required this.clients,
    required this.isDesktop,
    required this.projectCountFor,
    required this.onEditClient,
    required this.onDeleteClient,
    required this.onPreviewDashboard,
  });

  final List<Client> clients;
  final bool isDesktop;
  final int Function(String clientId) projectCountFor;
  final ValueChanged<Client> onEditClient;
  final ValueChanged<Client> onDeleteClient;
  final ValueChanged<Client> onPreviewDashboard;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(isDesktop ? 32 : 16),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        final projectCount = projectCountFor(client.id);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ClientCard(
            client: client,
            projectCount: projectCount,
            onTap: () => onEditClient(client),
            onDelete: () => onDeleteClient(client),
            onPreviewDashboard: () => onPreviewDashboard(client),
          ),
        );
      },
    );
  }
}
