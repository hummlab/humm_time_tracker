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
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: _SegmentTab(
                  label: 'Draft ($draftCount)',
                  isActive: controller.index == 0,
                  onTap: () => controller.animateTo(0),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _SegmentTab(
                  label: 'Pending ($pendingCount)',
                  isActive: controller.index == 1,
                  onTap: () => controller.animateTo(1),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _SegmentTab(
                  label: 'Rejected ($rejectedCount)',
                  isActive: controller.index == 2,
                  onTap: () => controller.animateTo(2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SegmentTab extends StatelessWidget {
  const _SegmentTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color:
                isActive
                    ? AppTheme.primaryAccent.withValues(alpha: 0.2)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isActive ? AppTheme.primaryAccent : AppTheme.textMuted,
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
