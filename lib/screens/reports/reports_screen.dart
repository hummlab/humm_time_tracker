import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/reports/cubit/reports_cubit.dart';
import 'package:time_tracker/screens/reports/cubit/reports_state.dart';
import 'package:time_tracker/screens/reports/widgets/reports_entries_table.dart';
import 'package:time_tracker/screens/reports/widgets/reports_export_button.dart';
import 'package:time_tracker/screens/reports/widgets/reports_filters_panel.dart';
import 'package:time_tracker/screens/reports/widgets/reports_period_selector.dart';
import 'package:time_tracker/screens/reports/widgets/reports_project_chart.dart';
import 'package:time_tracker/screens/reports/widgets/reports_sorting_options.dart';
import 'package:time_tracker/screens/reports/widgets/reports_summary_cards.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late final ReportsCubit _cubit;
  String? _lastToastMessage;

  @override
  void initState() {
    super.initState();
    _cubit = ReportsCubit(AppDependencies.instance.workspaceRepository, AppDependencies.instance.authDataProvider);
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(ReportsState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(context, message, type: state.toastType ?? AppToastType.info);
    });
    _cubit.clearToast();
  }

  Future<void> _selectCustomRange(DateTimeRange currentRange) async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: currentRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.primaryAccent,
              onPrimary: AppTheme.primaryDark,
              surface: AppTheme.cardDark,
              onSurface: AppTheme.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (range != null) {
      _cubit.setCustomRange(range);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: CubitBuilder<ReportsCubit, ReportsState>(
        cubit: _cubit,
        builder: (context, state) {
          _handleToast(state);

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ReportsExportButton(
                label: 'Export CSV',
                icon: Icons.table_view,
                onTap: _cubit.exportToCsv,
                colors: [AppTheme.successAccent, AppTheme.successAccent.withValues(alpha: 0.8)],
                shadowColor: AppTheme.successAccent.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 10),
              ReportsExportButton(
                label: 'Export PDF',
                icon: Icons.picture_as_pdf,
                onTap: _cubit.exportToPdf,
                colors: [AppTheme.tertiaryAccent, AppTheme.tertiaryAccent.withValues(alpha: 0.8)],
                shadowColor: AppTheme.tertiaryAccent.withValues(alpha: 0.4),
              ),
            ],
          );
        },
      ),
      body: CubitBuilder<ReportsCubit, ReportsState>(
        cubit: _cubit,
        builder: (context, state) {
          _handleToast(state);

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(isDesktop ? 32 : 16, isDesktop ? 32 : 16, isDesktop ? 32 : 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReportsPeriodSelector(
                  selectedPeriod: state.selectedPeriod,
                  selectedRange: state.selectedRange,
                  onSelectPeriod: (period) {
                    if (period == ReportPeriod.custom) {
                      _selectCustomRange(state.selectedRange);
                    } else {
                      _cubit.setPeriod(period);
                    }
                  },
                ),
                const SizedBox(height: 16),
                ReportsFiltersPanel(
                  isDesktop: isDesktop,
                  canChangeMembers: state.canChangeMembers,
                  hasFilters: state.hasFilters,
                  members: state.filteredMembers,
                  projects: state.filteredProjects,
                  clients: state.filteredClients,
                  tags: state.tags,
                  selectedMemberIds: state.selectedMemberIds,
                  selectedProjectIds: state.selectedProjectIds,
                  selectedClientIds: state.selectedClientIds,
                  selectedTagIds: state.selectedTagIds,
                  onClearFilters: _cubit.clearFilters,
                  onMembersChanged: _cubit.setSelectedMemberIds,
                  onProjectsChanged: _cubit.setSelectedProjectIds,
                  onClientsChanged: _cubit.setSelectedClientIds,
                  onTagsChanged: _cubit.setSelectedTagIds,
                ),
                const SizedBox(height: 16),
                ReportsSortingOptions(
                  sortBy: state.sortBy,
                  groupBy: state.groupBy,
                  sortDescending: state.sortDescending,
                  onSortByChanged: _cubit.setSortBy,
                  onToggleSortDirection: _cubit.toggleSortDirection,
                  onGroupByChanged: _cubit.setGroupBy,
                ),
                const SizedBox(height: 24),
                if (isDesktop)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ReportsSummaryCards(totalMinutes: state.totalMinutes, uniqueDays: state.uniqueDays),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 3,
                          child: ReportsProjectChart(
                            minutesByProject: state.minutesByProject,
                            getProjectById: _cubit.getProjectById,
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  ReportsSummaryCards(totalMinutes: state.totalMinutes, uniqueDays: state.uniqueDays),
                  const SizedBox(height: 24),
                  ReportsProjectChart(minutesByProject: state.minutesByProject, getProjectById: _cubit.getProjectById),
                ],
                const SizedBox(height: 24),
                ReportsEntriesTable(
                  entries: state.filteredEntries,
                  groupBy: state.groupBy,
                  getProjectById: _cubit.getProjectById,
                  getClientById: _cubit.getClientById,
                  getTagById: _cubit.getTagById,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
