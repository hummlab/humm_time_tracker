import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/theme/app_theme.dart';

Future<void> showClientDialog({
  required BuildContext context,
  required Client? client,
  required Future<bool> Function({required Client? existing, required String name, required List<String> linkedEmails})
  onSave,
}) async {
  final nameController = TextEditingController(text: client?.name ?? '');
  final emailController = TextEditingController();
  var linkedEmails = List<String>.from(client?.linkedEmails ?? []);

  await showDialog<bool>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          void addEmail(String value) {
            final email = value.trim().toLowerCase();
            if (email.isNotEmpty && email.contains('@')) {
              setState(() {
                if (!linkedEmails.contains(email)) {
                  linkedEmails.add(email);
                }
                emailController.clear();
              });
            }
          }

          return AlertDialog(
            title: Text(client == null ? 'New Client' : 'Edit Client'),
            content: SizedBox(
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Client Name',
                        prefixIcon: Icon(Icons.business_outlined),
                      ),
                      autofocus: true,
                    ),
                    const SizedBox(height: 24),
                    Text('Client Portal Access', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Add email addresses that can access the client dashboard',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'client@example.com',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSubmitted: addEmail,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          color: AppTheme.primaryAccent,
                          onPressed: () => addEmail(emailController.text),
                        ),
                      ],
                    ),
                    if (linkedEmails.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            linkedEmails.map((email) {
                              return Chip(
                                avatar: const Icon(Icons.person, size: 16),
                                label: Text(email),
                                deleteIcon: const Icon(Icons.close, size: 16),
                                onDeleted: () {
                                  setState(() {
                                    linkedEmails.remove(email);
                                  });
                                },
                              );
                            }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  final success = await onSave(existing: client, name: nameController.text, linkedEmails: linkedEmails);
                  if (!context.mounted) return;
                  if (success) {
                    Navigator.pop(context, true);
                  }
                },
                child: Text(client == null ? 'Create' : 'Save'),
              ),
            ],
          );
        },
      );
    },
  );

  nameController.dispose();
  emailController.dispose();
}

Future<void> showDeleteClientDialog({
  required BuildContext context,
  required Client client,
  required Future<void> Function(Client client) onDelete,
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Client'),
        content: Text('Are you sure you want to delete "${client.name}"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await onDelete(client);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.tertiaryAccent),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
