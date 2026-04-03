import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/weekly_calendar/cubit/weekly_calendar_cubit.dart';
import 'package:time_tracker/screens/weekly_calendar/cubit/weekly_calendar_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

Future<void> showWeeklyEntryDialog({
  required BuildContext context,
  required WeeklyCalendarCubit cubit,
  required WeeklyCalendarState state,
  required DateTime start,
  required DateTime end,
  required Offset position,
  TimeEntry? existingEntry,
  VoidCallback? onDialogClosed,
}) async {
  final descController = TextEditingController(
    text: existingEntry?.description ?? '',
  );
  DateTime currentStart = existingEntry?.startTime ?? start;
  DateTime currentEnd =
      existingEntry != null
          ? currentStart.add(Duration(minutes: existingEntry.durationMinutes))
          : end;

  String? selectedProjectId = existingEntry?.projectId;
  List<String> selectedTagIds = List.from(existingEntry?.tagIds ?? []);

  final mediaQuery = MediaQuery.of(context);
  const dialogWidth = 320.0;
  final isMobile = mediaQuery.size.width < 700;

  Widget buildEditorContent(
    BuildContext dialogContext,
    StateSetter setDialogState,
  ) {
    final projects = cubit.projects;
    final tags = cubit.tags;
    if (selectedProjectId != null &&
        projects.every((p) => p.id != selectedProjectId)) {
      selectedProjectId = null;
    }
    final durationMinutes = currentEnd
        .difference(currentStart)
        .inMinutes
        .clamp(1, 1440);
    final durationHours = (durationMinutes / 60).floor();
    final durationRemainderMinutes = durationMinutes % 60;
    final durationLabel =
        durationHours > 0
            ? '${durationHours}h ${durationRemainderMinutes.toString().padLeft(2, '0')}m'
            : '${durationRemainderMinutes}m';
    final dateLabel = DateFormat('EEE, MMM d').format(currentStart);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: AppTheme.primaryAccent,
                          ),
                          SizedBox(width: 6),
                        ],
                      ),
                      Text(
                        dateLabel,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryAccent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: AppTheme.primaryAccent.withValues(
                              alpha: 0.25,
                            ),
                          ),
                        ),
                        child: Text(
                          durationLabel,
                          style: const TextStyle(
                            color: AppTheme.primaryAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descController,
                    autofocus: true,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Work description...',
                      hintStyle: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      fillColor: AppTheme.surfaceDark.withValues(alpha: 0.72),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppTheme.borderDark.withValues(alpha: 0.9),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryAccent,
                          width: 1.4,
                        ),
                      ),
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildProjectSelector(projects, selectedProjectId, (val) {
          setDialogState(() => selectedProjectId = val);
        }, state),
        const SizedBox(height: 12),
        _buildTagSelector(tags, selectedTagIds, (tagId) {
          setDialogState(() {
            if (selectedTagIds.contains(tagId)) {
              selectedTagIds.remove(tagId);
            } else {
              selectedTagIds.add(tagId);
            }
          });
        }),
        const Divider(color: AppTheme.borderDark, height: 24),
        Row(
          children: [
            _timeInput(dialogContext, currentStart, (newTime) {
              setDialogState(() {
                currentStart = DateTime(
                  currentStart.year,
                  currentStart.month,
                  currentStart.day,
                  newTime.hour,
                  newTime.minute,
                );
                if (currentEnd.isBefore(currentStart)) {
                  currentEnd = currentStart.add(const Duration(minutes: 15));
                }
              });
            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '→',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
              ),
            ),
            _timeInput(dialogContext, currentEnd, (newTime) {
              setDialogState(() {
                currentEnd = DateTime(
                  currentEnd.year,
                  currentEnd.month,
                  currentEnd.day,
                  newTime.hour,
                  newTime.minute,
                );
                if (currentEnd.isBefore(currentStart)) {
                  currentStart = currentEnd.subtract(
                    const Duration(minutes: 15),
                  );
                }
              });
            }),
            const Spacer(),
            if (existingEntry != null) ...[
              OutlinedButton(
                onPressed: () {
                  cubit.deleteTimeEntry(existingEntry.id);
                  Navigator.pop(dialogContext);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.tertiaryAccent,
                  side: BorderSide(
                    color: AppTheme.tertiaryAccent.withValues(alpha: 0.45),
                  ),
                  padding: const EdgeInsets.all(10),
                  minimumSize: const Size(44, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.delete_outline, size: 18),
              ),
              const SizedBox(width: 8),
            ],
            ElevatedButton(
              onPressed: () {
                if (existingEntry != null) {
                  cubit.updateTimeEntry(
                    existingEntry.copyWith(
                      description: descController.text,
                      durationMinutes: durationMinutes,
                      startTime: currentStart,
                      projectId: selectedProjectId,
                      tagIds: selectedTagIds,
                      date: DateTime(
                        currentStart.year,
                        currentStart.month,
                        currentStart.day,
                      ),
                    ),
                  );
                } else {
                  cubit.addTimeEntry(
                    descController.text,
                    durationMinutes,
                    currentStart,
                    startTime: currentStart,
                    projectId: selectedProjectId,
                    tagIds: selectedTagIds,
                  );
                }
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryAccent,
                foregroundColor: AppTheme.primaryDark,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              child: Text(existingEntry != null ? 'Update' : 'Add'),
            ),
          ],
        ),
      ],
    );
  }

  if (isMobile) {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (sheetContext) => StatefulBuilder(
            builder: (sheetContext, setDialogState) {
              final insets = MediaQuery.of(sheetContext).viewInsets;
              return Padding(
                padding: EdgeInsets.only(bottom: insets.bottom),
                child: SafeArea(
                  top: false,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(sheetContext).size.height * 0.9,
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    decoration: BoxDecoration(
                      color: AppTheme.cardDark,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: AppTheme.primaryAccent.withValues(alpha: 0.22),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: buildEditorContent(sheetContext, setDialogState),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  } else {
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.transparent,
      transitionDuration: Duration.zero,
      pageBuilder:
          (dialogContext, anim1, anim2) => StatefulBuilder(
            builder: (dialogContext, setDialogState) {
              return Stack(
                children: [
                  CustomSingleChildLayout(
                    delegate: _AnchoredDialogLayoutDelegate(
                      anchor: position,
                      viewportPadding:
                          mediaQuery.padding +
                          mediaQuery.viewInsets +
                          const EdgeInsets.all(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: dialogWidth,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.cardDark,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.45),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                          border: Border.all(
                            color: AppTheme.primaryAccent.withValues(
                              alpha: 0.22,
                            ),
                          ),
                        ),
                        child: buildEditorContent(
                          dialogContext,
                          setDialogState,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  onDialogClosed?.call();
}

class _AnchoredDialogLayoutDelegate extends SingleChildLayoutDelegate {
  _AnchoredDialogLayoutDelegate({
    required this.anchor,
    required this.viewportPadding,
  });

  final Offset anchor;
  final EdgeInsets viewportPadding;
  static const double _horizontalGap = 20;
  static const double _verticalOffset = -60;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final maxWidth = (constraints.maxWidth - viewportPadding.horizontal).clamp(
      0.0,
      constraints.maxWidth,
    );
    final maxHeight = (constraints.maxHeight - viewportPadding.vertical).clamp(
      0.0,
      constraints.maxHeight,
    );
    return BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final minX = viewportPadding.left;
    final maxX = size.width - viewportPadding.right - childSize.width;
    final minY = viewportPadding.top;
    final maxY = size.height - viewportPadding.bottom - childSize.height;

    final rightCandidate = anchor.dx + _horizontalGap;
    final leftCandidate = anchor.dx - childSize.width - _horizontalGap;

    double x;
    if (rightCandidate <= maxX) {
      x = rightCandidate;
    } else if (leftCandidate >= minX) {
      x = leftCandidate;
    } else {
      x = (anchor.dx - (childSize.width / 2)).clamp(minX, maxX);
    }

    final preferredY = anchor.dy + _verticalOffset;
    final y = preferredY.clamp(minY, maxY);

    return Offset(maxX < minX ? minX : x, maxY < minY ? minY : y);
  }

  @override
  bool shouldRelayout(covariant _AnchoredDialogLayoutDelegate oldDelegate) {
    return anchor != oldDelegate.anchor ||
        viewportPadding != oldDelegate.viewportPadding;
  }
}

Widget _buildProjectSelector(
  List<Project> projects,
  String? selectedId,
  Function(String?) onChanged,
  WeeklyCalendarState state,
) {
  Project? selectedProject;
  if (selectedId != null) {
    for (final project in projects) {
      if (project.id == selectedId) {
        selectedProject = project;
        break;
      }
    }
  }

  final projectsById = {for (final project in projects) project.id: project};
  final recentProjectIds =
      state.weekEntries
          .where((e) => e.projectId != null)
          .map((e) => e.projectId!)
          .where((projectId) => projectsById.containsKey(projectId))
          .take(10)
          .toSet()
          .toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (recentProjectIds.isNotEmpty) ...[
        const Text(
          'QUICK SELECT',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w900,
            color: AppTheme.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              recentProjectIds.map((id) {
                final project = projectsById[id];
                if (project == null) return const SizedBox.shrink();
                final color = AppTheme.colorFromHex(project.color);
                final isSelected = selectedId == id;

                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onChanged(id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(
                          alpha: isSelected ? 0.25 : 0.12,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              isSelected ? color : color.withValues(alpha: 0.3),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            project.name,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : AppTheme.textSecondary,
                              fontSize: 11,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 16),
      ],
      PopupMenuButton<String?>(
        onSelected: onChanged,
        offset: const Offset(0, 30),
        itemBuilder:
            (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('No Project', style: TextStyle(fontSize: 12)),
              ),
              ...projects.map(
                (p) => PopupMenuItem(
                  value: p.id,
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppTheme.colorFromHex(p.color),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(p.name, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.borderDark),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.folder_outlined,
                size: 14,
                color:
                    selectedProject != null
                        ? AppTheme.colorFromHex(selectedProject.color)
                        : AppTheme.textMuted,
              ),
              const SizedBox(width: 8),
              Text(
                selectedProject?.name ?? 'Select Project',
                style: TextStyle(
                  color:
                      selectedProject != null
                          ? Colors.white
                          : AppTheme.textMuted,
                  fontSize: 12,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                size: 16,
                color: AppTheme.textMuted,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildTagSelector(
  List<Tag> tags,
  List<String> selectedIds,
  Function(String) onToggle,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Icon(Icons.label_outline, size: 14, color: AppTheme.textMuted),
          const SizedBox(width: 8),
          Text(
            'Tags',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Wrap(
        spacing: 4,
        runSpacing: 4,
        children:
            tags.map((t) {
              final isSelected = selectedIds.contains(t.id);
              return GestureDetector(
                onTap: () => onToggle(t.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? AppTheme.primaryAccent
                            : AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color:
                          isSelected ? Colors.transparent : AppTheme.borderDark,
                    ),
                  ),
                  child: Text(
                    t.name,
                    style: TextStyle(
                      fontSize: 10,
                      color:
                          isSelected
                              ? AppTheme.primaryDark
                              : AppTheme.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    ],
  );
}

Widget _timeInput(
  BuildContext context,
  DateTime time,
  Function(TimeOfDay) onTimeSelected,
) {
  return GestureDetector(
    onTap: () async {
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(time),
        builder:
            (context, child) => Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppTheme.primaryAccent,
                  onPrimary: AppTheme.primaryDark,
                  surface: AppTheme.surfaceDark,
                ),
              ),
              child: child!,
            ),
      );
      if (picked != null) onTimeSelected(picked);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderDark),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        DateFormat('HH:mm').format(time),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );
}
