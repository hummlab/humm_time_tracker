import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/organization.dart';
import 'package:time_tracker/models/org/organization_invite.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClientDashboardHeader extends StatelessWidget {
  const ClientDashboardHeader({
    super.key,
    required this.clientName,
    required this.isPreview,
    required this.isDesktop,
    required this.organizations,
    required this.pendingInvites,
    required this.activeOrganizationId,
    required this.onBack,
    required this.onSwitchOrganization,
    required this.onOpenOrganizationSetup,
    required this.onSignOut,
  });

  final String? clientName;
  final bool isPreview;
  final bool isDesktop;
  final List<Organization> organizations;
  final List<OrganizationInvite> pendingInvites;
  final String? activeOrganizationId;
  final VoidCallback? onBack;
  final ValueChanged<String> onSwitchOrganization;
  final VoidCallback onOpenOrganizationSetup;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final hasMultipleOrganizations = organizations.length > 1;
    final pendingInvitesCount = pendingInvites.length;

    return Container(
      padding: EdgeInsets.all(isDesktop ? 32 : 16),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isPreview) ...[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onBack,
                  color: AppTheme.textSecondary,
                  tooltip: 'Back to Clients',
                ),
                const SizedBox(width: 8),
              ],
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.warningAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.dashboard_outlined, color: AppTheme.warningAccent, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            clientName ?? 'Client Dashboard',
                            style: Theme.of(context).textTheme.headlineSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isPreview) ...[
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryAccent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.secondaryAccent.withValues(alpha: 0.3)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.visibility, size: 12, color: AppTheme.secondaryAccent),
                                SizedBox(width: 4),
                                Text(
                                  'Preview',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.secondaryAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text('Time entries overview', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              if (!isPreview && hasMultipleOrganizations) ...[
                Container(
                  constraints: const BoxConstraints(maxWidth: 220),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderDark),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: activeOrganizationId,
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
              if (!isPreview)
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
                          decoration: BoxDecoration(
                            color: AppTheme.tertiaryAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            pendingInvitesCount > 9 ? '9+' : '$pendingInvitesCount',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                  ],
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.warningAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.warningAccent.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.business, size: 14, color: AppTheme.warningAccent),
                    SizedBox(width: 4),
                    Text(
                      'Client',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.warningAccent),
                    ),
                  ],
                ),
              ),
              if (!isPreview) ...[
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: onSignOut,
                  tooltip: 'Sign Out',
                  color: AppTheme.textSecondary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
