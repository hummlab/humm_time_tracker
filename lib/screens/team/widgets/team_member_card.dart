import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/screens/team/cubit/team_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({super.key, required this.card, required this.onTap, required this.onDelete});

  final TeamMemberCardData card;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  Color _getRoleColor(TeamMemberRole role) {
    switch (role) {
      case TeamMemberRole.admin:
        return AppTheme.tertiaryAccent;
      case TeamMemberRole.manager:
        return AppTheme.warningAccent;
      case TeamMemberRole.regular:
        return AppTheme.primaryAccent;
      case TeamMemberRole.client:
        return const Color(0xFF64748B);
    }
  }

  IconData _getRoleIcon(TeamMemberRole role) {
    switch (role) {
      case TeamMemberRole.admin:
        return Icons.shield;
      case TeamMemberRole.manager:
        return Icons.manage_accounts;
      case TeamMemberRole.regular:
        return Icons.person;
      case TeamMemberRole.client:
        return Icons.business;
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleColor = _getRoleColor(card.member.role);
    final isClient = card.member.role == TeamMemberRole.client;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardDark,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.borderDark),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: roleColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: card.member.role == TeamMemberRole.admin ? Border.all(color: roleColor, width: 2) : null,
                ),
                child: Center(
                  child: Text(
                    _getInitials(card.member.name),
                    style: TextStyle(color: roleColor, fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      card.member.name,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      card.member.email,
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isClient ? Colors.transparent : roleColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                            border: isClient ? Border.all(color: roleColor.withValues(alpha: 0.5)) : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(_getRoleIcon(card.member.role), size: 12, color: roleColor),
                              const SizedBox(width: 4),
                              Text(
                                card.member.role.displayName,
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: roleColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Tooltip(
                          message: card.projectNames.isEmpty ? 'No projects' : card.projectNames.join('\n'),
                          child: Row(
                            children: [
                              const Icon(Icons.folder_outlined, size: 13, color: AppTheme.textMuted),
                              const SizedBox(width: 4),
                              Text(
                                '${card.projectCount}',
                                style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: AppTheme.textMuted, size: 20),
                padding: EdgeInsets.zero,
                onSelected: (value) {
                  if (value == 'edit') onTap();
                  if (value == 'delete') onDelete();
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 18, color: AppTheme.textSecondary),
                            SizedBox(width: 10),
                            Text('Edit member'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18, color: AppTheme.tertiaryAccent),
                            SizedBox(width: 10),
                            Text('Remove', style: TextStyle(color: AppTheme.tertiaryAccent)),
                          ],
                        ),
                      ),
                    ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
