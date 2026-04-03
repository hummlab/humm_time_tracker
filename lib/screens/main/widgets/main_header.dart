import 'package:flutter/material.dart';
import 'package:time_tracker/screens/clickup_settings/clickup_settings_screen.dart';
import 'package:time_tracker/screens/jira_settings/jira_settings_screen.dart';
import 'package:time_tracker/screens/main/cubit/main_state.dart';
import 'package:time_tracker/screens/main/main_screen.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/models/org/organization.dart';
import 'package:time_tracker/models/org/team_member.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
    required this.isDesktop,
    required this.navItems,
    required this.state,
    required this.onSwitchOrganization,
    required this.onOpenOrganizationSetup,
    required this.onSignOut,
    required this.roleColor,
    required this.roleIcon,
  });

  final bool isDesktop;
  final List<NavItem> navItems;
  final MainState state;
  final ValueChanged<String> onSwitchOrganization;
  final VoidCallback onOpenOrganizationSetup;
  final VoidCallback onSignOut;
  final Color roleColor;
  final IconData roleIcon;

  @override
  Widget build(BuildContext context) {
    final organizations = state.organizations;
    final hasMultipleOrganizations = organizations.length > 1;
    final pendingInvitesCount = state.pendingInvitesCount;
    final isCompactPrimaryMobile =
        !isDesktop &&
        (state.selectedIndex == 0 ||
            state.selectedIndex == 1 ||
            state.selectedIndex == 2);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: isCompactPrimaryMobile ? 10 : 16,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child:
          isDesktop
              ? _buildDesktopHeader(
                context,
                hasMultipleOrganizations,
                organizations,
                pendingInvitesCount,
              )
              : _buildMobileHeader(
                context,
                hasMultipleOrganizations,
                organizations,
                pendingInvitesCount,
              ),
    );
  }

  Widget _buildDesktopHeader(
    BuildContext context,
    bool hasMultipleOrganizations,
    List<Organization> organizations,
    int pendingInvitesCount,
  ) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              navItems[state.selectedIndex].label,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              navItems[state.selectedIndex].subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const Spacer(),
        if (hasMultipleOrganizations) ...[
          Container(
            constraints: const BoxConstraints(maxWidth: 240),
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
          ),
          const SizedBox(width: 8),
        ],
        _buildOrganizationsButton(pendingInvitesCount),
        if (state.isAdmin) ...[
          IconButton(
            icon: Image.asset('assets/clickup.png', width: 100, height: 24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ClickUpSettingsScreen(),
                ),
              );
            },
            tooltip: 'ClickUp Integration',
          ),
          IconButton(
            icon: Image.asset('assets/jira.png', width: 100, height: 24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JiraSettingsScreen(),
                ),
              );
            },
            tooltip: 'Jira Integration',
          ),
          const SizedBox(width: 4),
        ],
        _buildRoleChip(),
        const SizedBox(width: 12),
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: onSignOut,
          tooltip: 'Sign Out',
          color: AppTheme.textSecondary,
        ),
      ],
    );
  }

  Widget _buildMobileHeader(
    BuildContext context,
    bool hasMultipleOrganizations,
    List<Organization> organizations,
    int pendingInvitesCount,
  ) {
    final isCompactPrimary =
        state.selectedIndex == 0 || state.selectedIndex == 1;
    final isSubmit = state.selectedIndex == 2;
    if (isCompactPrimary) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              navItems[state.selectedIndex].selectedIcon,
              color: AppTheme.primaryAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            navItems[state.selectedIndex].label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(width: 8),
          _buildRoleChip(),
          const Spacer(),
          _buildOrganizationsButton(pendingInvitesCount),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: onSignOut,
            tooltip: 'Sign Out',
            color: AppTheme.textSecondary,
          ),
        ],
      );
    }

    if (isSubmit) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              navItems[state.selectedIndex].selectedIcon,
              color: AppTheme.primaryAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  navItems[state.selectedIndex].label,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  navItems[state.selectedIndex].subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _buildOrganizationsButton(pendingInvitesCount),
          const SizedBox(width: 12),
          _buildRoleChip(compact: true),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: onSignOut,
            tooltip: 'Sign Out',
            color: AppTheme.textSecondary,
            visualDensity: VisualDensity.compact,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isCompactPrimary ? 8 : 10),
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.access_time_filled,
                color: AppTheme.primaryAccent,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    navItems[state.selectedIndex].label,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (!isCompactPrimary) ...[
                    const SizedBox(height: 2),
                    Text(
                      navItems[state.selectedIndex].subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: isCompactPrimary ? 8 : 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (hasMultipleOrganizations)
              Container(
                constraints: const BoxConstraints(maxWidth: 260),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.borderDark),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: state.activeOrganizationId,
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
                                child: SizedBox(
                                  width: 180,
                                  child: Text(
                                    organization.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.textPrimary,
                                    ),
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
              ),
            _buildOrganizationsButton(pendingInvitesCount),
            if (state.isAdmin) ..._buildAdminIntegrationButtons(context),
            _buildRoleChip(),
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: onSignOut,
              tooltip: 'Sign Out',
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrganizationsButton(int pendingInvitesCount) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(Icons.business_outlined),
          onPressed: onOpenOrganizationSetup,
          tooltip: 'Organizations',
          color: AppTheme.textSecondary,
        ),
        if (pendingInvitesCount > 0)
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.tertiaryAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                pendingInvitesCount > 9 ? '9+' : '$pendingInvitesCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRoleChip({bool compact = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: roleColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: roleColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(roleIcon, size: compact ? 12 : 14, color: roleColor),
          const SizedBox(width: 4),
          Text(
            state.userRole.displayName,
            style: TextStyle(
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w600,
              color: roleColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAdminIntegrationButtons(BuildContext context) {
    return [
      IconButton(
        icon: Image.asset('assets/clickup.png', width: 72, height: 20),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ClickUpSettingsScreen(),
            ),
          );
        },
        tooltip: 'ClickUp Integration',
      ),
      IconButton(
        icon: Image.asset('assets/jira.png', width: 52, height: 18),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JiraSettingsScreen()),
          );
        },
        tooltip: 'Jira Integration',
      ),
    ];
  }
}
