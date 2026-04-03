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
    _cubit = ReportsCubit(
      AppDependencies.instance.workspaceRepository,
      AppDependencies.instance.authDataProvider,
      AppDependencies.instance.timeEntriesRepository,
    );
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
      AppToast.show(
        context,
        message,
        type: state.toastType ?? AppToastType.info,
      );
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

          if (isDesktop) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ReportsExportButton(
                  label: 'Export CSV',
                  icon: Icons.table_view,
                  onTap: _cubit.exportToCsv,
                  colors: [
                    AppTheme.successAccent,
                    AppTheme.successAccent.withValues(alpha: 0.8),
                  ],
                  shadowColor: AppTheme.successAccent.withValues(alpha: 0.4),
                ),
                const SizedBox(height: 10),
                ReportsExportButton(
                  label: 'Export PDF',
                  icon: Icons.picture_as_pdf,
                  onTap: _cubit.exportToPdf,
                  colors: [
                    AppTheme.tertiaryAccent,
                    AppTheme.tertiaryAccent.withValues(alpha: 0.8),
                  ],
                  shadowColor: AppTheme.tertiaryAccent.withValues(alpha: 0.4),
                ),
              ],
            );
          }

          return FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppTheme.cardDark,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder:
                    (context) => SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Container(
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppTheme.borderDark,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            ReportsExportButton(
                              label: 'Export CSV',
                              icon: Icons.table_view,
                              onTap: () {
                                Navigator.pop(context);
                                _cubit.exportToCsv();
                              },
                              colors: [
                                AppTheme.successAccent,
                                AppTheme.successAccent.withValues(alpha: 0.8),
                              ],
                              shadowColor: AppTheme.successAccent.withValues(
                                alpha: 0.4,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ReportsExportButton(
                              label: 'Export PDF',
                              icon: Icons.picture_as_pdf,
                              onTap: () {
                                Navigator.pop(context);
                                _cubit.exportToPdf();
                              },
                              colors: [
                                AppTheme.tertiaryAccent,
                                AppTheme.tertiaryAccent.withValues(alpha: 0.8),
                              ],
                              shadowColor: AppTheme.tertiaryAccent.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              );
            },
            child: const Icon(Icons.ios_share_outlined),
          );
        },
      ),
      body: CubitBuilder<ReportsCubit, ReportsState>(
        cubit: _cubit,
        builder: (context, state) {
          _handleToast(state);
          final hasData = state.totalMatchingEntries > 0;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  isDesktop ? 32 : 16,
                  isDesktop ? 32 : 12,
                  isDesktop ? 32 : 16,
                  isDesktop ? 100 : 132,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportsPeriodSelector(
                      isDesktop: isDesktop,
                      selectedPeriod: state.selectedPeriod,
                      selectedRange: state.selectedRange,
                      onSelectCustomRange:
                          () => _selectCustomRange(state.selectedRange),
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
                      isDesktop: isDesktop,
                      sortBy: state.sortBy,
                      groupBy: state.groupBy,
                      sortDescending: state.sortDescending,
                      onSortByChanged: _cubit.setSortBy,
                      onToggleSortDirection: _cubit.toggleSortDirection,
                      onGroupByChanged: _cubit.setGroupBy,
                    ),
                    const SizedBox(height: 24),
                    ReportsSummaryCards(
                      totalMinutes: state.totalMinutes,
                      uniqueDays: state.uniqueDays,
                    ),
                    const SizedBox(height: 24),
                    if (hasData) ...[
                      ReportsProjectChart(
                        minutesByProject: state.minutesByProject,
                        getProjectById: _cubit.getProjectById,
                      ),
                      const SizedBox(height: 24),
                      ReportsEntriesTable(
                        isDesktop: isDesktop,
                        entries: state.filteredEntries,
                        totalEntriesCount: state.totalMatchingEntries,
                        totalMinutes: state.totalMinutes,
                        groupBy: state.groupBy,
                        getProjectById: _cubit.getProjectById,
                        getClientById: _cubit.getClientById,
                        getTagById: _cubit.getTagById,
                      ),
                      if (state.hasMoreEntries) ...[
                        const SizedBox(height: 12),
                        Center(
                          child: OutlinedButton.icon(
                            onPressed: _cubit.loadMoreEntries,
                            icon: const Icon(Icons.expand_more),
                            label: const Text('Load more'),
                          ),
                        ),
                      ],
                    ] else if (!state.isLoading)
                      const _EmptyReportView(),
                  ],
                ),
              ),
              if (state.isLoading)
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(minHeight: 2),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyReportView extends StatelessWidget {
  const _EmptyReportView();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.insights_outlined,
            size: 32,
            color: AppTheme.textMuted.withValues(alpha: 0.8),
          ),
          const SizedBox(height: 8),
          const Text(
            'No data for selected filters',
            style: TextStyle(color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }
}
