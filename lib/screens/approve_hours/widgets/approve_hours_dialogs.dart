import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';

Future<String?> showApproveHoursRejectDialog(BuildContext context, {required int selectedCount}) async {
  final reasonController = TextEditingController();

  return showDialog<String>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Reject Entries'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rejecting $selectedCount entries. Please provide a reason:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Rejection Reason',
                    hintText: 'e.g., Missing project, incorrect duration...',
                  ),
                  maxLines: 3,
                  autofocus: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (reasonController.text.trim().isEmpty) {
                  AppToast.show(context, 'Please provide a rejection reason', type: AppToastType.error);
                  return;
                }
                Navigator.pop(context, reasonController.text.trim());
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.tertiaryAccent),
              child: const Text('Reject'),
            ),
          ],
        ),
  );
}
