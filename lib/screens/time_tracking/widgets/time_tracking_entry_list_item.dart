part of 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';

class TimeEntryListItem extends StatelessWidget {
  final TimeEntry entry;
  final Project? project;
  final List<Tag> tags;
  final bool isEditing;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TimeEntryListItem({
    super.key,
    required this.entry,
    this.project,
    required this.tags,
    required this.isEditing,
    required this.onTap,
    required this.onDelete,
  });

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete time entry'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Are you sure you want to delete this entry?'),
                  const SizedBox(height: 8),
                  Text(
                    entry.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.tertiaryAccent,
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: AppTheme.textPrimary),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final projectColor =
        project != null
            ? AppTheme.colorFromHex(project!.color)
            : AppTheme.textMuted;
    final timeRange = entry.timeRange;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
        decoration: BoxDecoration(
          color:
              isEditing
                  ? AppTheme.primaryAccent.withValues(alpha: 0.08)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: projectColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.description,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: isEditing ? AppTheme.primaryAccent : null,
                            fontSize: 15,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                  if (project != null || tags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (project != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: projectColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  project!.name,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: projectColor,
                                  ),
                                ),
                                if (tags.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 1,
                                    height: 12,
                                    color: AppTheme.borderDark,
                                  ),
                                ],
                              ],
                            ),
                          ...tags
                              .take(3)
                              .map(
                                (tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.colorFromHex(
                                      tag.color,
                                    ).withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '#${tag.name}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.colorFromHex(tag.color),
                                    ),
                                  ),
                                ),
                              ),
                          if (tags.length > 3)
                            Text(
                              '+${tags.length - 3}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppTheme.textMuted,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${entry.formattedDuration} • $timeRange',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            PopupMenuButton<_EntryMenuAction>(
              tooltip: 'More actions',
              icon: const Icon(
                Icons.more_vert,
                color: AppTheme.textMuted,
                size: 20,
              ),
              onSelected: (action) async {
                switch (action) {
                  case _EntryMenuAction.copyDescription:
                    Clipboard.setData(ClipboardData(text: entry.description));
                    AppToast.show(
                      context,
                      'Description copied',
                      type: AppToastType.success,
                    );
                    break;
                  case _EntryMenuAction.delete:
                    final confirmed = await _confirmDelete(context);
                    if (confirmed) {
                      onDelete();
                    }
                    break;
                }
              },
              itemBuilder:
                  (context) => [
                    const PopupMenuItem<_EntryMenuAction>(
                      value: _EntryMenuAction.copyDescription,
                      child: Row(
                        children: [
                          Icon(
                            Icons.copy,
                            size: 16,
                            color: AppTheme.textSecondary,
                          ),
                          SizedBox(width: 8),
                          Text('Copy description'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<_EntryMenuAction>(
                      value: _EntryMenuAction.delete,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 16,
                            color: AppTheme.tertiaryAccent,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Delete',
                            style: TextStyle(color: AppTheme.tertiaryAccent),
                          ),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }
}

// Time Entry Form
