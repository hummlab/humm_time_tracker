import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/approve_hours/cubit/approve_hours_cubit.dart';
import 'package:time_tracker/screens/approve_hours/cubit/approve_hours_state.dart';
import 'package:time_tracker/screens/approve_hours/widgets/approve_hours_dialogs.dart';
import 'package:time_tracker/screens/approve_hours/widgets/approve_hours_empty_state.dart';
import 'package:time_tracker/screens/approve_hours/widgets/approve_hours_view.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class ApproveHoursScreen extends StatefulWidget {
  const ApproveHoursScreen({super.key});

  @override
  State<ApproveHoursScreen> createState() => _ApproveHoursScreenState();
}

class _ApproveHoursScreenState extends State<ApproveHoursScreen> {
  late final ApproveHoursCubit _cubit;
  String? _lastToastMessage;

  @override
  void initState() {
    super.initState();
    _cubit = ApproveHoursCubit(
      AppDependencies.instance.workspaceRepository,
      AppDependencies.instance.timeEntriesRepository,
      AppDependencies.instance.authDataProvider,
    );
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(ApproveHoursState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(context, message, type: state.toastType ?? AppToastType.info);
    });
    _cubit.clearToast();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return CubitBuilder<ApproveHoursCubit, ApproveHoursState>(
      cubit: _cubit,
      builder: (context, state) {
        _handleToast(state);

        if (state.pendingEntries.isEmpty) {
          return const Scaffold(backgroundColor: Colors.transparent, body: ApproveHoursEmptyState());
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: ApproveHoursView(
            state: state,
            isDesktop: isDesktop,
            onSelectUser: _cubit.setFilterByUserId,
            onToggleSelectAll: _cubit.toggleSelectAll,
            onToggleEntry: _cubit.toggleEntrySelection,
            getProjectById: _cubit.getProjectById,
            onApproveSelected: _cubit.approveSelected,
            onRejectSelected: () => _onReject(context, state),
          ),
        );
      },
    );
  }

  Future<void> _onReject(BuildContext context, ApproveHoursState state) async {
    final reason = await showApproveHoursRejectDialog(context, selectedCount: state.selectedEntryIds.length);
    if (!context.mounted || reason == null || reason.isEmpty) return;
    await _cubit.rejectSelected(reason);
  }
}
