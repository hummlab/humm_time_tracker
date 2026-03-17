import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ApproveHoursFiltersBar extends StatelessWidget {
  const ApproveHoursFiltersBar({
    super.key,
    required this.users,
    required this.totalCount,
    required this.selectedUserId,
    required this.pendingCountsByUserId,
    required this.onSelectUser,
  });

  final List<TeamMember> users;
  final int totalCount;
  final String? selectedUserId;
  final Map<String, int> pendingCountsByUserId;
  final ValueChanged<String?> onSelectUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_list, color: AppTheme.textMuted, size: 20),
          const SizedBox(width: 12),
          Text('Filter by user:', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All ($totalCount)',
                    isSelected: selectedUserId == null,
                    onTap: () => onSelectUser(null),
                  ),
                  const SizedBox(width: 8),
                  ...users.map((user) {
                    final userId = user.firebaseUid ?? user.id;
                    final count = pendingCountsByUserId[userId] ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _FilterChip(
                        label: '${user.name} ($count)',
                        isSelected: selectedUserId == userId,
                        onTap: () => onSelectUser(userId),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.2) : AppTheme.cardDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryAccent : AppTheme.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
