import 'package:flutter/material.dart';
import 'package:time_tracker/config/app_config.dart';
import 'package:time_tracker/screens/main/cubit/main_state.dart';
import 'package:time_tracker/screens/main/main_screen.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/models/org/team_member.dart';

class MainNavigationRail extends StatelessWidget {
  const MainNavigationRail({
    super.key,
    required this.navItems,
    required this.state,
    required this.onSelectTab,
    required this.roleColor,
    required this.roleIcon,
  });

  final List<NavItem> navItems;
  final MainState state;
  final ValueChanged<int> onSelectTab;
  final Color roleColor;
  final IconData roleIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(right: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.access_time_filled, color: AppTheme.primaryAccent, size: 24),
                ),
                const SizedBox(width: 12),
                Text('Time Tracker', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final item = navItems[index];
                final isSelected = state.selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onSelectTab(index),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? item.selectedIcon : item.icon,
                              color: isSelected ? AppTheme.primaryAccent : AppTheme.textMuted,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              item.label,
                              style: TextStyle(
                                color: isSelected ? AppTheme.primaryAccent : AppTheme.textSecondary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppTheme.borderDark))),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [roleColor, roleColor.withValues(alpha: 0.7)]),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(roleIcon, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.userEmail ?? '',
                            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            state.userRole.displayName,
                            style: TextStyle(fontSize: 10, color: roleColor, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  AppConfig.fullVersion,
                  style: TextStyle(color: AppTheme.textMuted.withValues(alpha: 0.5), fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
