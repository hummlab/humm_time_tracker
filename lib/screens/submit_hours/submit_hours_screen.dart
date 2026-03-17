import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_cubit.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_state.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_tab_bar.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_draft_tab.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_pending_tab.dart';
import 'package:time_tracker/screens/submit_hours/widgets/submit_hours_rejected_tab.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class SubmitHoursScreen extends StatefulWidget {
  const SubmitHoursScreen({super.key});

  @override
  State<SubmitHoursScreen> createState() => _SubmitHoursScreenState();
}

class _SubmitHoursScreenState extends State<SubmitHoursScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final SubmitHoursCubit _cubit;
  String? _lastToastMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _cubit = SubmitHoursCubit(
      AppDependencies.instance.workspaceRepository,
      AppDependencies.instance.timeEntriesRepository,
      AppDependencies.instance.authDataProvider,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(SubmitHoursState state) {
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

    return CubitBuilder<SubmitHoursCubit, SubmitHoursState>(
      cubit: _cubit,
      builder: (context, state) {
        _handleToast(state);

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SubmitHoursTabBar(
                controller: _tabController,
                draftCount: state.draftEntries.length,
                pendingCount: state.pendingEntries.length,
                rejectedCount: state.rejectedEntries.length,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SubmitHoursDraftTab(
                      sections: state.draftSections,
                      entryCount: state.draftEntries.length,
                      totalMinutes: state.totalDraftMinutes,
                      selectedCount: state.selectedEntryIds.length,
                      selectedTotalMinutes: state.selectedTotalMinutes,
                      isSubmitting: state.isSubmitting,
                      isDesktop: isDesktop,
                      isAllSelected:
                          state.draftEntries.isNotEmpty && state.selectedEntryIds.length == state.draftEntries.length,
                      activeQuickSelect: state.activeQuickSelect,
                      getProjectById: _cubit.getProjectById,
                      getTagById: _cubit.getTagById,
                      isSelected: (id) => state.selectedEntryIds.contains(id),
                      onToggleEntry: _cubit.toggleEntrySelection,
                      onToggleSelectAll: _cubit.toggleSelectAllDraft,
                      onSelectThisMonth: _cubit.selectThisMonth,
                      onSelectLastMonth: _cubit.selectLastMonth,
                      onSubmit: _cubit.submitSelected,
                    ),
                    SubmitHoursPendingTab(
                      sections: state.pendingSections,
                      entryCount: state.pendingEntries.length,
                      totalMinutes: state.totalPendingMinutes,
                      isDesktop: isDesktop,
                      activeQuickSelect: state.activeQuickSelect,
                      getProjectById: _cubit.getProjectById,
                      getTagById: _cubit.getTagById,
                    ),
                    SubmitHoursRejectedTab(
                      sections: state.rejectedSections,
                      entryCount: state.rejectedEntries.length,
                      totalMinutes: state.totalRejectedMinutes,
                      isDesktop: isDesktop,
                      activeQuickSelect: state.activeQuickSelect,
                      getProjectById: _cubit.getProjectById,
                      getTagById: _cubit.getTagById,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
