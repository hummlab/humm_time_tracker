import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/theme/app_theme.dart';

Future<void> showTagDialog({
  required BuildContext context,
  required List<String> tagColors,
  required Tag? tag,
  required Future<bool> Function({required Tag? existing, required String name, required String color}) onSave,
}) async {
  final nameController = TextEditingController(text: tag?.name ?? '');
  var selectedColor = tag?.color ?? tagColors.first;

  await showDialog<void>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(tag == null ? 'New Tag' : 'Edit Tag'),
            content: SizedBox(
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Tag Name', prefixIcon: Icon(Icons.label_outline)),
                  ),
                  const SizedBox(height: 20),
                  Text('Color', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        tagColors.map((color) {
                          final isSelected = selectedColor == color;
                          return GestureDetector(
                            onTap:
                                () => setDialogState(() {
                                  selectedColor = color;
                                }),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppTheme.colorFromHex(color),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? AppTheme.textPrimary : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  final success = await onSave(existing: tag, name: nameController.text, color: selectedColor);
                  if (!context.mounted) return;
                  if (success) {
                    Navigator.pop(context);
                  }
                },
                child: Text(tag == null ? 'Create' : 'Save'),
              ),
            ],
          );
        },
      );
    },
  );

  nameController.dispose();
}

Future<void> showDeleteTagDialog({
  required BuildContext context,
  required Tag tag,
  required Future<void> Function(Tag tag) onDelete,
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Tag'),
        content: Text('Are you sure you want to delete "${tag.name}"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await onDelete(tag);
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
