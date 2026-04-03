import 'package:flutter/material.dart';
import 'package:time_tracker/screens/main/cubit/main_state.dart';
import 'package:time_tracker/screens/main/main_screen.dart';
import 'package:time_tracker/theme/app_theme.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({
    super.key,
    required this.navItems,
    required this.state,
    required this.onSelectTab,
  });

  static const int maxVisibleItems = 5;
  static const int maxPrimaryItemsWhenOverflow = 4;

  final List<NavItem> navItems;
  final MainState state;
  final ValueChanged<int> onSelectTab;

  static List<int> primaryIndices(List<NavItem> items) {
    if (items.length <= maxVisibleItems) {
      return List<int>.generate(items.length, (index) => index);
    }

    const priorityLabels = <String>[
      'Time',
      'Calendar',
      'Approve',
      'Projects',
      'Submit',
    ];

    final result = <int>[];

    for (final label in priorityLabels) {
      final index = items.indexWhere((item) => item.label == label);
      if (index >= 0 && !result.contains(index)) {
        result.add(index);
      }
      if (result.length == maxPrimaryItemsWhenOverflow) {
        return result;
      }
    }

    for (var index = 0; index < items.length; index++) {
      if (!result.contains(index)) {
        result.add(index);
      }
      if (result.length == maxPrimaryItemsWhenOverflow) {
        break;
      }
    }

    return result;
  }

  static List<int> hiddenIndices(List<NavItem> items) {
    if (items.length <= maxVisibleItems) {
      return const [];
    }

    final primary = primaryIndices(items).toSet();
    return List<int>.generate(
      items.length,
      (index) => index,
    ).where((index) => !primary.contains(index)).toList();
  }

  void _openMoreMenu(BuildContext context, List<int> hidden) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppTheme.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.borderDark,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 10),
                ...hidden.map((index) {
                  final item = navItems[index];
                  final isSelected = state.selectedIndex == index;
                  return ListTile(
                    dense: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: Icon(
                      isSelected ? item.selectedIcon : item.icon,
                      color:
                          isSelected
                              ? AppTheme.primaryAccent
                              : AppTheme.textSecondary,
                    ),
                    title: Text(item.label),
                    trailing:
                        isSelected
                            ? const Icon(
                              Icons.check,
                              color: AppTheme.primaryAccent,
                              size: 18,
                            )
                            : null,
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onSelectTab(index);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = primaryIndices(navItems);
    final hidden = hiddenIndices(navItems);
    final selectedInMore = hidden.contains(state.selectedIndex);

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(top: BorderSide(color: AppTheme.borderDark)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Row(
            children: [
              ...primary.map((index) {
                final item = navItems[index];
                final isSelected = state.selectedIndex == index;
                return Expanded(
                  child: _NavButton(
                    icon: isSelected ? item.selectedIcon : item.icon,
                    label: item.label,
                    isSelected: isSelected,
                    onTap: () => onSelectTab(index),
                  ),
                );
              }),
              if (hidden.isNotEmpty)
                Expanded(
                  child: _NavButton(
                    icon: selectedInMore ? Icons.more_horiz : Icons.more_horiz,
                    label: 'More',
                    isSelected: selectedInMore,
                    onTap: () => _openMoreMenu(context, hidden),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppTheme.primaryAccent.withValues(alpha: 0.12)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryAccent : AppTheme.textMuted,
              size: 20,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
  }
}
