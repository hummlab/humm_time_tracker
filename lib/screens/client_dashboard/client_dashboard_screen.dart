import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/data_providers/firebase/firebase_data_provider.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/client_dashboard/cubit/client_dashboard_cubit.dart';
import 'package:time_tracker/screens/client_dashboard/cubit/client_dashboard_state.dart';
import 'package:time_tracker/screens/organization_setup/organization_setup_screen.dart';
import 'package:time_tracker/screens/client_dashboard/widgets/client_dashboard_entries_list.dart';
import 'package:time_tracker/screens/client_dashboard/widgets/client_dashboard_error_state.dart';
import 'package:time_tracker/screens/client_dashboard/widgets/client_dashboard_header.dart';
import 'package:time_tracker/screens/client_dashboard/widgets/client_dashboard_month_selector.dart';
import 'package:time_tracker/screens/client_dashboard/widgets/client_dashboard_summary.dart';
import 'package:time_tracker/screens/client_dashboard/widgets/client_dashboard_tag_filter.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClientDashboardScreen extends StatefulWidget {
  /// If provided, shows dashboard for this client (preview mode for admin/manager)
  /// If null, uses clientId from AuthDataProvider (actual client user)
  final String? clientId;

  /// If true, shows back button and "Preview Mode" badge
  final bool isPreview;

  const ClientDashboardScreen({super.key, this.clientId, this.isPreview = false});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  late final ClientDashboardCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ClientDashboardCubit(
      authDataProvider: AppDependencies.instance.authDataProvider,
      firebaseDataProvider: FirebaseDataProvider(),
      clientIdOverride: widget.clientId,
      isPreview: widget.isPreview,
    );
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  Future<void> _openOrganizationSetup() async {
    if (widget.isPreview) return;
    final beforeOrgId = _cubit.state.activeOrganizationId;
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const OrganizationSetupScreen()));
    if (!mounted) return;
    await _cubit.openOrganizationSetupReturned(beforeOrgId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return CubitBuilder<ClientDashboardCubit, ClientDashboardState>(
      cubit: _cubit,
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.primaryDark, Color(0xFF0D1B2A), Color(0xFF1B263B)],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  ClientDashboardHeader(
                    clientName: state.client?.name,
                    isPreview: widget.isPreview,
                    isDesktop: isDesktop,
                    organizations: state.organizations,
                    pendingInvites: state.pendingInvites,
                    activeOrganizationId: state.activeOrganizationId,
                    onBack: widget.isPreview ? () => Navigator.pop(context) : null,
                    onSwitchOrganization: _cubit.switchOrganization,
                    onOpenOrganizationSetup: _openOrganizationSetup,
                    onSignOut: _cubit.signOut,
                  ),
                  Expanded(
                    child:
                        state.isLoading
                            ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryAccent))
                            : state.error != null
                            ? ClientDashboardErrorState(error: state.error!, onRetry: _cubit.loadData)
                            : _ClientDashboardBody(
                              state: state,
                              isDesktop: isDesktop,
                              onPreviousMonth: _cubit.previousMonth,
                              onNextMonth: _cubit.nextMonth,
                              onToggleTag: _cubit.toggleTag,
                              onClearTags: _cubit.clearTags,
                              onPickMonth: () {
                                _showMonthPicker(context, state.selectedMonth);
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showMonthPicker(BuildContext context, DateTime selectedMonth) {
    final now = DateTime.now();
    int selectedYear = selectedMonth.year;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Month'),
              content: SizedBox(
                width: 320,
                height: 400,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppTheme.borderDark))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () {
                              setDialogState(() {
                                selectedYear--;
                              });
                            },
                          ),
                          Text(
                            '$selectedYear',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed:
                                selectedYear >= now.year
                                    ? null
                                    : () {
                                      setDialogState(() {
                                        selectedYear++;
                                      });
                                    },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          final month = index + 1;
                          final monthDate = DateTime(selectedYear, month);
                          final isFuture = monthDate.isAfter(DateTime(now.year, now.month + 1, 0));
                          final isSelected = selectedMonth.year == selectedYear && selectedMonth.month == month;
                          final monthName = DateFormat('MMM').format(monthDate);

                          return InkWell(
                            onTap:
                                isFuture
                                    ? null
                                    : () {
                                      Navigator.pop(context);
                                      _cubit.setMonth(DateTime(selectedYear, month));
                                    },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppTheme.primaryAccent
                                        : isFuture
                                        ? AppTheme.surfaceDark.withValues(alpha: 0.5)
                                        : AppTheme.surfaceDark,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark),
                              ),
                              child: Center(
                                child: Text(
                                  monthName,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? AppTheme.primaryDark
                                            : isFuture
                                            ? AppTheme.textMuted
                                            : AppTheme.textPrimary,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))],
            );
          },
        );
      },
    );
  }
}

class _ClientDashboardBody extends StatelessWidget {
  const _ClientDashboardBody({
    required this.state,
    required this.isDesktop,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onToggleTag,
    required this.onClearTags,
    required this.onPickMonth,
  });

  final ClientDashboardState state;
  final bool isDesktop;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<String> onToggleTag;
  final VoidCallback onClearTags;
  final VoidCallback onPickMonth;

  @override
  Widget build(BuildContext context) {
    final filteredEntries = List.of(state.filteredEntries)..sort((a, b) => b.date.compareTo(a.date));

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(isDesktop ? 24 : 16),
          child: Column(
            children: [
              ClientDashboardMonthSelector(
                selectedMonth: state.selectedMonth,
                onPreviousMonth: onPreviousMonth,
                onNextMonth: onNextMonth,
                onPickMonth: onPickMonth,
              ),
              const SizedBox(height: 16),
              ClientDashboardSummary(entries: filteredEntries),
              if (state.usedTags.isNotEmpty) ...[
                const SizedBox(height: 16),
                ClientDashboardTagFilter(
                  tags: state.usedTags,
                  selectedTagIds: state.selectedTagIds,
                  onToggleTag: onToggleTag,
                  onClearTags: onClearTags,
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: ClientDashboardEntriesList(
            entries: filteredEntries,
            projects: state.projects,
            tags: state.tags,
            hasTagFilter: state.selectedTagIds.isNotEmpty,
            isDesktop: isDesktop,
          ),
        ),
      ],
    );
  }
}
