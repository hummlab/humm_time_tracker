import 'package:flutter/material.dart';
import 'package:time_tracker/screens/projects/cubit/projects_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.card, required this.onTap, required this.onDelete});

  final ProjectCardData card;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) {
      return '${hours}h ${mins}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else if (mins > 0) {
      return '${mins}m';
    }
    return '0m';
  }

  @override
  Widget build(BuildContext context) {
    final color = _accentColorForClient(card.clientName, AppTheme.colorFromHex(card.project.color));
    final monthDuration = _formatDuration(card.thisMonthMinutes);
    final totalDuration = _formatDuration(card.totalMinutes);
    final metaParts = <String>[
      '${card.teamMembers.length} members',
      if (card.clientName != null && card.clientName!.trim().isNotEmpty) card.clientName!.trim(),
    ];
    final metaText = metaParts.join(' • ');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1B2D4D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderDark.withValues(alpha: 0.7)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8))),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          card.project.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Opacity(
                        opacity: 0.78,
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_horiz, color: AppTheme.textSecondary, size: 21),
                          padding: const EdgeInsets.all(8),
                          onSelected: (value) {
                            if (value == 'delete') onDelete();
                          },
                          itemBuilder:
                              (context) => [
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline, color: AppTheme.tertiaryAccent),
                                      SizedBox(width: 8),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                              ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    monthDuration,
                    style: TextStyle(fontSize: 28, height: 1.05, fontWeight: FontWeight.w700, color: color),
                  ),
                  const Text(
                    'this month',
                    style: TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$totalDuration total',
                    style: const TextStyle(fontSize: 13, color: AppTheme.textMuted, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    metaText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _accentColorForClient(String? client, Color fallback) {
    final normalized = (client ?? '').trim().toLowerCase();
    if (normalized.isEmpty) return fallback;

    final palette = <Color>[
      const Color(0xFF3B82F6),
      const Color(0xFF10B981),
      const Color(0xFF8B5CF6),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFF14B8A6),
    ];
    final hash = normalized.runes.fold<int>(0, (acc, c) => (acc + c) % 100000);
    return palette[hash % palette.length];
  }
}
