import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class SubmitHoursTabBar extends StatelessWidget {
  const SubmitHoursTabBar({
    super.key,
    required this.controller,
    required this.draftCount,
    required this.pendingCount,
    required this.rejectedCount,
  });

  final TabController controller;
  final int draftCount;
  final int pendingCount;
  final int rejectedCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: AppTheme.primaryAccent.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppTheme.primaryAccent,
        unselectedLabelColor: AppTheme.textMuted,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Icon(Icons.edit_note, size: 18), const SizedBox(width: 4), Text('Draft ($draftCount)')],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.hourglass_empty, size: 18),
                const SizedBox(width: 4),
                Text('Pending ($pendingCount)'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cancel_outlined, size: 18),
                const SizedBox(width: 4),
                Text('Rejected ($rejectedCount)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
