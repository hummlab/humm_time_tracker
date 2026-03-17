import 'package:flutter/material.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/clickup_settings/cubit/clickup_settings_cubit.dart';
import 'package:time_tracker/screens/clickup_settings/cubit/clickup_settings_state.dart';

class ClickUpQuickSyncAction extends StatelessWidget {
  const ClickUpQuickSyncAction({super.key, required this.cubit, required this.onQuickSync});

  final ClickupSettingsCubit cubit;
  final VoidCallback onQuickSync;

  @override
  Widget build(BuildContext context) {
    return CubitBuilder<ClickupSettingsCubit, ClickupSettingsState>(
      cubit: cubit,
      builder: (context, state) {
        if (state.settings?.hasApiToken != true) {
          return const SizedBox.shrink();
        }

        return Row(
          children: [
            TextButton.icon(
              onPressed: state.isSyncing ? null : onQuickSync,
              icon: const Icon(Icons.sync, size: 18),
              label: const Text('Quick Sync'),
            ),
            const SizedBox(width: 8),
          ],
        );
      },
    );
  }
}
