import 'package:flutter/material.dart';
import 'package:time_tracker/screens/clickup_settings/clickup_settings_screen.dart';
import 'package:time_tracker/screens/jira_settings/jira_settings_screen.dart';
import 'package:time_tracker/screens/main/cubit/main_state.dart';
import 'package:time_tracker/screens/main/main_screen.dart';
import 'package:time_tracker/theme/app_theme.dart';
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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 16, vertical: 16),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Row(
        children: [
          if (!isDesktop) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.access_time_filled, color: AppTheme.primaryAccent, size: 24),
            ),
            const SizedBox(width: 12),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(navItems[state.selectedIndex].label, style: Theme.of(context).textTheme.headlineSmall),
              Text(navItems[state.selectedIndex].subtitle, style: Theme.of(context).textTheme.bodySmall),
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
                  icon: const Icon(Icons.expand_more, size: 18, color: AppTheme.textSecondary),
                  items:
                      organizations
                          .map(
                            (organization) => DropdownMenuItem<String>(
                              value: organization.id,
                              child: Text(
                                organization.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary),
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
          Stack(
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
                    decoration: BoxDecoration(color: AppTheme.tertiaryAccent, borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      pendingInvitesCount > 9 ? '9+' : '$pendingInvitesCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
            ],
          ),
          if (state.isAdmin) ...[
            IconButton(
              icon: Image.asset('assets/clickup.png', width: 100, height: 24),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClickUpSettingsScreen()));
              },
              tooltip: 'ClickUp Integration',
            ),
            IconButton(
              icon: Image.asset('assets/jira.png', width: 100, height: 24),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const JiraSettingsScreen()));
              },
              tooltip: 'Jira Integration',
            ),
            const SizedBox(width: 4),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: roleColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: roleColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(roleIcon, size: 14, color: roleColor),
                const SizedBox(width: 4),
                Text(
                  state.userRole.displayName,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: roleColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: onSignOut,
            tooltip: 'Sign Out',
            color: AppTheme.textSecondary,
          ),
        ],
      ),
    );
  }
}
