import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/time/grid_row.dart';

Future<void> showWeeklyGridEditMinutesDialog({
  required BuildContext context,
  required GridRow row,
  required int dayIndex,
  required DateTime date,
  required Future<void> Function(int minutes) onSave,
}) async {
  final controller = TextEditingController(
    text: row.dayMinutes[dayIndex] > 0 ? row.dayMinutes[dayIndex].toString() : '',
  );

  await showDialog<void>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text('Edit Hours - ${DateFormat('EEEE').format(date)}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row.description,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Minutes', hintText: 'e.g. 60'),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children:
                    [15, 30, 60, 120]
                        .map(
                          (m) => ChoiceChip(
                            label: Text('${m}m'),
                            selected: controller.text == m.toString(),
                            onSelected: (_) => controller.text = m.toString(),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                final newMinutes = int.tryParse(controller.text) ?? 0;
                Navigator.pop(context);
                await onSave(newMinutes);
              },
              child: const Text('Save'),
            ),
          ],
        ),
  );
}

Future<void> showWeeklyGridAddRowDialog({
  required BuildContext context,
  required List<Project> projects,
  required Future<void> Function(String description, String? projectId) onSave,
}) async {
  final descController = TextEditingController();
  String? selectedProjectId;

  await showDialog<void>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add New Row'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedProjectId,
                  decoration: const InputDecoration(labelText: 'Project'),
                  items: projects.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                  onChanged: (val) => setState(() => selectedProjectId = val),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  final description = descController.text.trim();
                  if (description.isEmpty) return;
                  Navigator.pop(context);
                  await onSave(description, selectedProjectId);
                },
                child: const Text('Add Row'),
              ),
            ],
          );
        },
      );
    },
  );
}
