import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/main/cubit/main_cubit.dart';
import 'package:time_tracker/screens/main/cubit/main_state.dart';

import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/screens/approve_hours/approve_hours_screen.dart';
import 'package:time_tracker/screens/client_dashboard/client_dashboard_screen.dart';
import 'package:time_tracker/screens/clients/clients_screen.dart';
import 'package:time_tracker/screens/organization_setup/organization_setup_screen.dart';
import 'package:time_tracker/screens/projects/projects_screen.dart';
import 'package:time_tracker/screens/reports/reports_screen.dart';
import 'package:time_tracker/screens/submit_hours/submit_hours_screen.dart';
import 'package:time_tracker/screens/tags/tags_screen.dart';
import 'package:time_tracker/screens/team/team_screen.dart';
import 'package:time_tracker/screens/weekly_calendar/weekly_calendar_screen.dart';
import 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';
import 'package:time_tracker/screens/main/widgets/main_bottom_nav.dart';
import 'package:time_tracker/screens/main/widgets/main_header.dart';
import 'package:time_tracker/screens/main/widgets/main_navigation_rail.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainCubit _cubit;

  Future<void> _switchOrganization(String organizationId) async {
    await _cubit.switchOrganization(organizationId);
  }

  Future<void> _openOrganizationSetup() async {
    final beforeOrgId = _cubit.state.activeOrganizationId;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrganizationSetupScreen()),
    );
    if (!mounted) return;

    await _cubit.refreshOrganizationsAndReload(beforeOrgId);
  }

  List<NavItem> _getNavItems(bool hasManagerAccess) {
    final items = <NavItem>[
      NavItem(
        icon: Icons.access_time_outlined,
        selectedIcon: Icons.access_time_filled,
        label: 'Time',
        subtitle: 'Track and manage your time',
      ),
      NavItem(
        icon: Icons.calendar_view_week_outlined,
        selectedIcon: Icons.calendar_view_week,
        label: 'Calendar',
        subtitle: 'Visual week view',
      ),
      // Submit Hours tab available for all users
      NavItem(
        icon: Icons.send_outlined,
        selectedIcon: Icons.send,
        label: 'Submit',
        subtitle: 'Submit hours for approval',
      ),
    ];

    if (hasManagerAccess) {
      items.addAll([
        NavItem(
          icon: Icons.fact_check_outlined,
          selectedIcon: Icons.fact_check,
          label: 'Approve',
          subtitle: 'Approve team hours',
        ),
        NavItem(
          icon: Icons.folder_outlined,
          selectedIcon: Icons.folder,
          label: 'Projects',
          subtitle: 'Manage your projects',
        ),
        NavItem(
          icon: Icons.business_outlined,
          selectedIcon: Icons.business,
          label: 'Clients',
          subtitle: 'Manage your clients',
        ),
        NavItem(
          icon: Icons.people_outline,
          selectedIcon: Icons.people,
          label: 'Team',
          subtitle: 'Manage team members',
        ),
      ]);
    }

    items.add(
      NavItem(
        icon: Icons.label_outline,
        selectedIcon: Icons.label,
        label: 'Tags',
        subtitle: 'Organize with tags',
      ),
    );

    // Reports tab available for all users
    items.add(
      NavItem(
        icon: Icons.analytics_outlined,
        selectedIcon: Icons.analytics,
        label: 'Reports',
        subtitle: 'View analytics and reports',
      ),
    );

    return items;
  }

  List<Widget> _getScreens(bool hasManagerAccess) {
    final screens = <Widget>[
      const TimeTrackingScreen(),
      const WeeklyCalendarScreen(),
      // Submit Hours screen available for all users
      const SubmitHoursScreen(),
    ];

    if (hasManagerAccess) {
      screens.addAll([
        const ApproveHoursScreen(),
        const ProjectsScreen(),
        const ClientsScreen(),
        const TeamScreen(),
      ]);
    }

    screens.add(const TagsScreen());

    // Reports screen available for all users
    screens.add(const ReportsScreen());

    return screens;
  }

  @override
  void initState() {
    super.initState();
    _cubit = MainCubit(
      AppDependencies.instance.authDataProvider,
      AppDependencies.instance.timeDataProvider,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.initTimeData();
    });
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;
    return CubitBuilder<MainCubit, MainState>(
      cubit: _cubit,
      builder: (context, state) {
        if (state.isClient) {
          return const ClientDashboardScreen();
        }

        final navItems = _getNavItems(state.hasManagerAccess);
        final screens = _getScreens(state.hasManagerAccess);
        final hiddenMobileTabs = MainBottomNav.hiddenIndices(navItems);

        var selectedIndex = state.selectedIndex;
        if (selectedIndex >= navItems.length) {
          selectedIndex = 0;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _cubit.selectTab(0);
          });
        }

        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Row(
              children: [
                if (isDesktop)
                  MainNavigationRail(
                    navItems: navItems,
                    state: state,
                    onSelectTab: _cubit.selectTab,
                    roleColor: _getRoleColor(state),
                    roleIcon: _getRoleIcon(state),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (isDesktop)
                        MainHeader(
                          isDesktop: true,
                          navItems: navItems,
                          state: state,
                          onSwitchOrganization: _switchOrganization,
                          onOpenOrganizationSetup: _openOrganizationSetup,
                          onSignOut: _cubit.signOut,
                          roleColor: _getRoleColor(state),
                          roleIcon: _getRoleIcon(state),
                        )
                      else
                        _MobileOrganizationBar(
                          state: state,
                          navItems: navItems,
                          hiddenTabIndices: hiddenMobileTabs,
                          onSelectTab: _cubit.selectTab,
                          onSwitchOrganization: _switchOrganization,
                          onOpenOrganizationSetup: _openOrganizationSetup,
                          onSignOut: _cubit.signOut,
                        ),
                      Expanded(child: screens[selectedIndex]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar:
              isDesktop
                  ? null
                  : MainBottomNav(
                    navItems: navItems,
                    state: state,
                    onSelectTab: _cubit.selectTab,
                  ),
        );
      },
    );
  }

  Color _getRoleColor(MainState state) {
    if (state.isAdmin) return AppTheme.tertiaryAccent;
    if (state.isManager) return AppTheme.warningAccent;
    return AppTheme.primaryAccent;
  }

  IconData _getRoleIcon(MainState state) {
    if (state.isAdmin) return Icons.admin_panel_settings;
    if (state.isManager) return Icons.manage_accounts;
    return Icons.person;
  }
}

class _MobileOrganizationBar extends StatelessWidget {
  const _MobileOrganizationBar({
    required this.state,
    required this.navItems,
    required this.hiddenTabIndices,
    required this.onSelectTab,
    required this.onSwitchOrganization,
    required this.onOpenOrganizationSetup,
    required this.onSignOut,
  });

  final MainState state;
  final List<NavItem> navItems;
  final List<int> hiddenTabIndices;
  final ValueChanged<int> onSelectTab;
  final ValueChanged<String> onSwitchOrganization;
  final VoidCallback onOpenOrganizationSetup;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final organizations = state.organizations;
    final hasMultipleOrganizations = organizations.length > 1;
    String? activeOrganizationName;
    for (final organization in organizations) {
      if (organization.id == state.activeOrganizationId) {
        activeOrganizationName = organization.name;
        break;
      }
    }

    final organizationsMenuLabel =
        state.pendingInvitesCount > 0
            ? 'Organizations (${state.pendingInvitesCount})'
            : 'Organizations';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child:
                hasMultipleOrganizations
                    ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceDark,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.borderDark),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: state.activeOrganizationId,
                          isExpanded: true,
                          isDense: true,
                          dropdownColor: AppTheme.cardDark,
                          icon: const Icon(
                            Icons.expand_more,
                            size: 18,
                            color: AppTheme.textSecondary,
                          ),
                          items:
                              organizations
                                  .map(
                                    (organization) => DropdownMenuItem<String>(
                                      value: organization.id,
                                      child: Text(
                                        organization.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            onSwitchOrganization(value);
                          },
                        ),
                      ),
                    )
                    : Text(
                      activeOrganizationName ?? 'Organization',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
          ),
          PopupMenuButton<_MobileMenuAction>(
            tooltip: 'More',
            color: AppTheme.cardDark,
            icon: const Icon(Icons.more_vert, color: AppTheme.textSecondary),
            onSelected: (action) {
              switch (action) {
                case _MobileMenuAction.manageOrganizations:
                  onOpenOrganizationSetup();
                  break;
                case _MobileMenuAction.signOut:
                  onSignOut();
                  break;
                case _MobileMenuAction.hiddenTab:
                  break;
              }
            },
            itemBuilder: (context) {
              final items = <PopupMenuEntry<_MobileMenuAction>>[
                PopupMenuItem(
                  value: _MobileMenuAction.manageOrganizations,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.business_outlined,
                        size: 16,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(organizationsMenuLabel),
                    ],
                  ),
                ),
              ];

              if (hiddenTabIndices.isNotEmpty) {
                items.add(const PopupMenuDivider(height: 6));
                for (final index in hiddenTabIndices) {
                  final item = navItems[index];
                  items.add(
                    PopupMenuItem(
                      value: _MobileMenuAction.hiddenTab,
                      onTap: () => onSelectTab(index),
                      child: Row(
                        children: [
                          Icon(
                            state.selectedIndex == index
                                ? item.selectedIcon
                                : item.icon,
                            size: 16,
                            color:
                                state.selectedIndex == index
                                    ? AppTheme.primaryAccent
                                    : AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(item.label)),
                        ],
                      ),
                    ),
                  );
                }
              }

              items.add(const PopupMenuDivider(height: 6));
              items.add(
                const PopupMenuItem(
                  value: _MobileMenuAction.signOut,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        size: 16,
                        color: AppTheme.textSecondary,
                      ),
                      SizedBox(width: 8),
                      Text('Sign out'),
                    ],
                  ),
                ),
              );

              return items;
            },
          ),
        ],
      ),
    );
  }
}

enum _MobileMenuAction { manageOrganizations, hiddenTab, signOut }

class NavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String subtitle;

  NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.subtitle,
  });
}
