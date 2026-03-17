import 'package:flutter/material.dart';
import 'package:time_tracker/screens/main/cubit/main_state.dart';
import 'package:time_tracker/screens/main/main_screen.dart';
import 'package:time_tracker/theme/app_theme.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({super.key, required this.navItems, required this.state, required this.onSelectTab});

  final List<NavItem> navItems;
  final MainState state;
  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(top: BorderSide(color: AppTheme.borderDark)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isSelected = state.selectedIndex == index;
              return InkWell(
                onTap: () => onSelectTab(index),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected ? item.selectedIcon : item.icon,
                        color: isSelected ? AppTheme.primaryAccent : AppTheme.textMuted,
                        size: 22,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected ? AppTheme.primaryAccent : AppTheme.textMuted,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
