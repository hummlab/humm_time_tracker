import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/theme/app_theme.dart';

class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.tag, required this.entryCount, required this.onTap, required this.onDelete});

  final Tag tag;
  final int entryCount;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.colorFromHex(tag.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Text(tag.name, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
              child: Text('$entryCount', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 8),
            GestureDetector(onTap: onDelete, child: Icon(Icons.close, size: 16, color: color.withValues(alpha: 0.7))),
          ],
        ),
      ),
    );
  }
}
