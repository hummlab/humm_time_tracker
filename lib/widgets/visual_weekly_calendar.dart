import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/projects/project.dart';
import '../models/time/time_entry.dart';
import '../theme/app_theme.dart';

enum _ResizeEdge { top, bottom }

class VisualWeeklyCalendar extends StatefulWidget {
  final DateTime weekStart;
  final List<TimeEntry> entries;
  final Function(DateTime startTime, DateTime endTime, Offset position, VoidCallback clearSelection) onSlotTap;
  final Function(TimeEntry entry, Offset position) onEntryTap;
  final Function(TimeEntry entry, DateTime newStart, [int? newDuration]) onEntryMoved;
  final Project? Function(String? id) getProjectById;

  const VisualWeeklyCalendar({
    super.key,
    required this.weekStart,
    required this.entries,
    required this.onSlotTap,
    required this.onEntryTap,
    required this.onEntryMoved,
    required this.getProjectById,
  });

  @override
  State<VisualWeeklyCalendar> createState() => _VisualWeeklyCalendarState();
}

class _VisualWeeklyCalendarState extends State<VisualWeeklyCalendar> {
  final double hourHeight = 60.0;
  final double timeColumnWidth = 60.0;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _gridKey = GlobalKey();
  static const int _snapMinutes = 15;
  static const int _minDurationMinutes = 15;
  static const double _resizeHandleHeight = 10.0;

  _ResizeEdge? _resizeEdge;
  String? _resizingEntryId;
  DateTime? _resizeOriginalStart;
  int? _resizeOriginalDuration;
  int? _resizeDayIndex;

  // Selection state for drag-to-create
  DateTime? _selectionStart;
  DateTime? _selectionEnd;
  int? _selectionDayIndex;

  // Drag-and-drop state
  double _dragGrabYOffset = 0.0;
  Offset _lastTapPosition = Offset.zero;
  TimeEntry? _draggingEntry;
  int? _dragPreviewDayIndex;
  double? _dragPreviewTop;
  double? _dragPreviewHeight;
  Offset? _dragCursorLocalPosition;

  // Tooltip & Hover state
  Offset? _hoverPosition;
  final Map<String, TimeEntry> _optimisticEntries = {};
  final Map<String, Timer> _optimisticEntryTimers = {};

  List<TimeEntry> get _displayEntries {
    if (_optimisticEntries.isEmpty) return widget.entries;
    return widget.entries.map((entry) {
      return _optimisticEntries[entry.id] ?? entry;
    }).toList();
  }

  void _clearSelection() {
    if (_selectionStart == null && _selectionEnd == null && _selectionDayIndex == null) {
      return;
    }
    setState(() {
      _selectionStart = null;
      _selectionEnd = null;
      _selectionDayIndex = null;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToDefaultHour());
  }

  @override
  void dispose() {
    for (final timer in _optimisticEntryTimers.values) {
      timer.cancel();
    }
    _optimisticEntryTimers.clear();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VisualWeeklyCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_optimisticEntries.isEmpty) return;

    final entriesById = {for (final entry in widget.entries) entry.id: entry};
    final confirmedIds = <String>[];

    _optimisticEntries.forEach((id, optimisticEntry) {
      final persistedEntry = entriesById[id];
      if (persistedEntry == null) {
        confirmedIds.add(id);
        return;
      }
      if (persistedEntry.startTime == optimisticEntry.startTime &&
          persistedEntry.durationMinutes == optimisticEntry.durationMinutes &&
          persistedEntry.date == optimisticEntry.date) {
        confirmedIds.add(id);
      }
    });

    if (confirmedIds.isEmpty) return;
    for (final id in confirmedIds) {
      _optimisticEntries.remove(id);
      _optimisticEntryTimers.remove(id)?.cancel();
    }
  }

  void _setOptimisticEntry(TimeEntry entry) {
    _optimisticEntries[entry.id] = entry;
    _optimisticEntryTimers.remove(entry.id)?.cancel();
    _optimisticEntryTimers[entry.id] = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _optimisticEntries.remove(entry.id);
      });
      _optimisticEntryTimers.remove(entry.id);
    });
  }

  void _jumpToDefaultHour() {
    if (!mounted) return;
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(hourHeight * 8);
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToDefaultHour());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dayWidth = (constraints.maxWidth - timeColumnWidth) / 7;
        final displayEntries = _displayEntries;

        return Column(
          children: [
            _buildDayHeader(dayWidth, displayEntries),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: MouseRegion(
                  onHover: (e) {
                    setState(() {
                      _hoverPosition = e.localPosition;
                    });
                  },
                  onExit: (e) {
                    setState(() {
                      _hoverPosition = null;
                    });
                  },
                  child: SizedBox(
                    key: _gridKey,
                    height: hourHeight * 24,
                    child: Stack(
                      children: [
                        _buildGrid(dayWidth),
                        if (_selectionStart != null && _selectionEnd != null && _selectionDayIndex != null)
                          _buildSelectionBlock(dayWidth),
                        ...displayEntries.map((entry) => _buildEntryBlock(entry, dayWidth)),
                        if (_draggingEntry != null &&
                            _dragPreviewDayIndex != null &&
                            _dragPreviewTop != null &&
                            _dragPreviewHeight != null)
                          _buildDragPreview(dayWidth),
                        if ((_draggingEntry != null || _resizingEntryId != null) && _dragCursorLocalPosition != null)
                          _buildActiveDragTooltip(),
                        _buildCurrentTimeIndicator(dayWidth),
                        if (_hoverPosition != null &&
                            _selectionStart == null &&
                            _draggingEntry == null &&
                            _resizingEntryId == null)
                          _buildHoverTooltip(dayWidth),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateDragPreviewFromGlobalOffset(Offset globalOffset, double dayWidth) {
    final gridContext = _gridKey.currentContext;
    if (gridContext == null || _draggingEntry == null) return;

    final RenderBox gridBox = gridContext.findRenderObject() as RenderBox;
    final localOffset = gridBox.globalToLocal(globalOffset);

    final minutesInDay = 24 * 60;
    // localOffset is already in the scroll content coordinate space,
    // so adding scroll offset here would double-count it.
    final topInStack = localOffset.dy - _dragGrabYOffset;
    final rawMinutes = (topInStack / hourHeight) * 60;
    final snappedMinutes = ((rawMinutes / 15).round() * 15).clamp(0, minutesInDay - 15).toInt();

    final snappedTop = (snappedMinutes / 60) * hourHeight;

    final rawDayIndex = ((localOffset.dx - timeColumnWidth) / dayWidth).floor();
    final clampedDayIndex = rawDayIndex.clamp(0, 6);

    setState(() {
      _dragPreviewTop = snappedTop;
      _dragPreviewDayIndex = clampedDayIndex;
      _dragCursorLocalPosition = localOffset;
    });
  }

  int _snapMinutesToGrid(int minutes, {required bool clampToEndOfDay}) {
    final maxMinutes = clampToEndOfDay ? 24 * 60 : (24 * 60) - _snapMinutes;
    final snapped = ((minutes / _snapMinutes).round() * _snapMinutes).clamp(0, maxMinutes).toInt();
    return snapped;
  }

  void _startResize({
    required TimeEntry entry,
    required _ResizeEdge edge,
    required DateTime entryStart,
    required int dayIndex,
    required double height,
  }) {
    final entryStartMinutes = (entryStart.hour * 60) + entryStart.minute;
    final snappedStartMinutes = _snapMinutesToGrid(entryStartMinutes, clampToEndOfDay: false);
    final snappedTop = (snappedStartMinutes / 60) * hourHeight;

    setState(() {
      _resizeEdge = edge;
      _resizingEntryId = entry.id;
      _resizeOriginalStart = entryStart;
      _resizeOriginalDuration = entry.durationMinutes;
      _resizeDayIndex = dayIndex;

      _draggingEntry = entry;
      _dragPreviewDayIndex = dayIndex;
      _dragPreviewTop = snappedTop;
      _dragPreviewHeight = height;
    });
  }

  void _updateResizeFromGlobalOffset(Offset globalOffset) {
    final gridContext = _gridKey.currentContext;
    if (gridContext == null ||
        _draggingEntry == null ||
        _resizeEdge == null ||
        _resizeOriginalStart == null ||
        _resizeOriginalDuration == null ||
        _resizeDayIndex == null) {
      return;
    }

    final RenderBox gridBox = gridContext.findRenderObject() as RenderBox;
    final localOffset = gridBox.globalToLocal(globalOffset);

    final pointerMinutesRaw = ((localOffset.dy / hourHeight) * 60).round();
    final pointerMinutesSnapped = _snapMinutesToGrid(pointerMinutesRaw, clampToEndOfDay: true);

    final originalStartMinutes = (_resizeOriginalStart!.hour * 60) + _resizeOriginalStart!.minute;
    final originalEndMinutes = originalStartMinutes + _resizeOriginalDuration!;

    int newStartMinutes = originalStartMinutes;
    int newEndMinutes = originalEndMinutes;

    if (_resizeEdge == _ResizeEdge.top) {
      newStartMinutes = pointerMinutesSnapped.clamp(0, originalEndMinutes - _minDurationMinutes);
    } else {
      newEndMinutes = pointerMinutesSnapped.clamp(originalStartMinutes + _minDurationMinutes, 24 * 60);
    }

    final newDurationMinutes = (newEndMinutes - newStartMinutes).clamp(_minDurationMinutes, 24 * 60);
    final newTop = (newStartMinutes / 60) * hourHeight;
    final newHeight = (newDurationMinutes / 60) * hourHeight;

    setState(() {
      _dragPreviewTop = newTop;
      _dragPreviewHeight = newHeight;
      _dragCursorLocalPosition = localOffset;
    });
  }

  void _endResize() {
    if (_draggingEntry == null ||
        _resizeEdge == null ||
        _resizeOriginalStart == null ||
        _resizeOriginalDuration == null ||
        _resizeDayIndex == null ||
        _dragPreviewTop == null ||
        _dragPreviewHeight == null) {
      setState(() {
        _resizeEdge = null;
        _resizingEntryId = null;
      });
      return;
    }

    final newStartMinutes = ((_dragPreviewTop! / hourHeight) * 60).round();
    final newDurationMinutes = ((_dragPreviewHeight! / hourHeight) * 60).round();

    final snappedStartMinutes = _snapMinutesToGrid(newStartMinutes, clampToEndOfDay: false);
    final snappedDurationMinutes =
        ((newDurationMinutes / _snapMinutes).round() * _snapMinutes).clamp(_minDurationMinutes, 24 * 60).toInt();

    final baseDate = widget.weekStart.add(Duration(days: _resizeDayIndex!));
    final newStart = DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      snappedStartMinutes ~/ 60,
      snappedStartMinutes % 60,
    );

    final entry = _draggingEntry!;
    final updatedEntry = entry.copyWith(
      date: DateTime(newStart.year, newStart.month, newStart.day),
      startTime: newStart,
      durationMinutes: snappedDurationMinutes,
    );
    _setOptimisticEntry(updatedEntry);

    setState(() {
      _resizeEdge = null;
      _resizingEntryId = null;
      _resizeOriginalStart = null;
      _resizeOriginalDuration = null;
      _resizeDayIndex = null;

      _draggingEntry = null;
      _dragPreviewDayIndex = null;
      _dragPreviewTop = null;
      _dragPreviewHeight = null;
      _dragCursorLocalPosition = null;
    });

    widget.onEntryMoved(entry, newStart, snappedDurationMinutes);
  }

  Widget _buildDayHeader(double dayWidth, List<TimeEntry> entries) {
    final today = DateTime.now();
    return Container(
      padding: EdgeInsets.only(left: timeColumnWidth),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Row(
        children: List.generate(7, (index) {
          final day = widget.weekStart.add(Duration(days: index));
          final isToday = day.year == today.year && day.month == today.month && day.day == today.day;

          final dayEntries = entries.where((e) {
            final entryStart = e.startTime ?? e.createdAt.subtract(Duration(minutes: e.durationMinutes));
            return entryStart.year == day.year && entryStart.month == day.month && entryStart.day == day.day;
          });
          final totalMinutes = dayEntries.fold(0, (sum, e) => sum + e.durationMinutes);
          final hoursPart = totalMinutes ~/ 60;
          final minutesPart = totalMinutes % 60;
          final durationLabel =
              totalMinutes == 0
                  ? '0m'
                  : hoursPart > 0
                  ? '${hoursPart}h ${minutesPart}m'
                  : '${minutesPart}m';

          return Container(
            width: dayWidth,
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  DateFormat('E').format(day).toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: isToday ? AppTheme.primaryAccent : AppTheme.textMuted,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration:
                      isToday ? const BoxDecoration(color: AppTheme.primaryAccent, shape: BoxShape.circle) : null,
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isToday ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  durationLabel,
                  style: TextStyle(
                    fontSize: 9,
                    color: totalMinutes > 0 ? AppTheme.textSecondary : AppTheme.textMuted,
                    fontWeight: totalMinutes > 0 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildGrid(double dayWidth) {
    return Stack(
      children: [
        // Horizontal hour lines
        ...List.generate(
          24,
          (hour) => Positioned(
            top: hour * hourHeight,
            left: 0,
            right: 0,
            child: Container(
              height: hourHeight,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppTheme.borderDark, width: 0.5)),
              ),
              child: Row(
                children: [
                  Container(
                    width: timeColumnWidth,
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 8, top: 2),
                    child: Text(
                      '${hour.toString().padLeft(2, '0')}:00',
                      style: const TextStyle(fontSize: 10, color: AppTheme.textMuted),
                    ),
                  ),
                  ...List.generate(
                    7,
                    (dayIndex) => Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(left: BorderSide(color: AppTheme.borderDark, width: 0.5)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Vertical DragTargets (full height)
        Positioned.fill(
          left: timeColumnWidth,
          child: Row(
            children: List.generate(
              7,
              (dayIndex) => Expanded(
                child: DragTarget<TimeEntry>(
                  onWillAcceptWithDetails: (_) => true,
                  onAcceptWithDetails: (details) {
                    final gridContext = _gridKey.currentContext;
                    if (gridContext == null) return;
                    final RenderBox gridBox = gridContext.findRenderObject() as RenderBox;
                    final localOffset = gridBox.globalToLocal(details.offset);
                    // localOffset is already in the scroll content coordinate space,
                    // so adding scroll offset here would double-count it.
                    final double topInStack = localOffset.dy - _dragGrabYOffset;

                    final minutesInDay = 24 * 60;
                    final rawMinutes = (topInStack / hourHeight) * 60;
                    final snappedMinutes = ((rawMinutes / 15).round() * 15).clamp(0, minutesInDay - 15).toInt();
                    final h = snappedMinutes ~/ 60;
                    final m = snappedMinutes % 60;

                    final baseDate = widget.weekStart.add(Duration(days: dayIndex));
                    final newStart = DateTime(baseDate.year, baseDate.month, baseDate.day, h, m);
                    final updatedEntry = details.data.copyWith(
                      date: DateTime(newStart.year, newStart.month, newStart.day),
                      startTime: newStart,
                    );
                    _setOptimisticEntry(updatedEntry);
                    setState(() {
                      _draggingEntry = null;
                      _dragPreviewDayIndex = null;
                      _dragPreviewTop = null;
                      _dragPreviewHeight = null;
                      _dragCursorLocalPosition = null;
                    });
                    widget.onEntryMoved(details.data, newStart);
                  },
                  builder:
                      (context, candidateData, rejectedData) => GestureDetector(
                        onTapDown: (details) {
                          _lastTapPosition = details.globalPosition;
                        },
                        onTapUp: (details) {
                          final tapPos = details.localPosition.dy; // Relative to the full-height DragTarget
                          final totalMinutes = (tapPos / hourHeight) * 60;
                          final h = (totalMinutes / 60).floor();
                          final m = ((totalMinutes % 60) / 15).floor() * 15;
                          final baseDate = widget.weekStart.add(Duration(days: dayIndex));
                          final startTime = DateTime(baseDate.year, baseDate.month, baseDate.day, h, m);
                          final RenderBox box = context.findRenderObject() as RenderBox;
                          final anchoredTapPosition = box.localToGlobal(Offset(dayWidth * 0.75, tapPos));
                          widget.onSlotTap(
                            startTime,
                            startTime.add(const Duration(minutes: 30)),
                            anchoredTapPosition,
                            _clearSelection,
                          );
                        },
                        onVerticalDragStart: (details) {
                          final tapPos = details.localPosition.dy; // Relative to the full-height DragTarget
                          final totalMinutes = (tapPos / hourHeight) * 60;
                          final m = (totalMinutes / 15).floor() * 15;
                          final baseDate = widget.weekStart.add(Duration(days: dayIndex));
                          setState(() {
                            _selectionDayIndex = dayIndex;
                            _selectionStart = DateTime(
                              baseDate.year,
                              baseDate.month,
                              baseDate.day,
                            ).add(Duration(minutes: m));
                            _selectionEnd = _selectionStart!.add(const Duration(minutes: 15));
                          });
                        },
                        onVerticalDragUpdate: (details) {
                          if (_selectionStart == null) return;
                          final localPos = details.localPosition.dy; // Relative to the full-height DragTarget
                          final totalMinutes = (localPos / hourHeight) * 60;
                          final m = (totalMinutes / 15).round() * 15;
                          final baseDate = widget.weekStart.add(Duration(days: dayIndex));
                          final currentSelectionEnd = DateTime(
                            baseDate.year,
                            baseDate.month,
                            baseDate.day,
                          ).add(Duration(minutes: m));
                          if (currentSelectionEnd.isAfter(_selectionStart!)) {
                            setState(() => _selectionEnd = currentSelectionEnd);
                          }
                        },
                        onVerticalDragEnd: (details) {
                          if (_selectionStart != null && _selectionEnd != null) {
                            final s = _selectionStart!;
                            final e = _selectionEnd!;
                            final selectionEndMinutes = (e.hour * 60) + e.minute;
                            final selectionEndDy = (selectionEndMinutes / 60) * hourHeight;
                            final RenderBox box = context.findRenderObject() as RenderBox;
                            final anchoredTapPosition = box.localToGlobal(Offset(dayWidth * 0.75, selectionEndDy));
                            widget.onSlotTap(s, e, anchoredTapPosition, _clearSelection);
                          }
                        },
                        child: Container(
                          color:
                              candidateData.isNotEmpty
                                  ? AppTheme.primaryAccent.withValues(alpha: 0.1)
                                  : Colors.transparent,
                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionBlock(double dayWidth) {
    final selectionStart = _selectionStart!;
    final selectionEnd = _selectionEnd!;
    final top = (selectionStart.hour * hourHeight) + (selectionStart.minute / 60 * hourHeight);
    final durationMinutes = selectionEnd.difference(selectionStart).inMinutes;
    final height = (durationMinutes / 60 * hourHeight).clamp(15.0, double.infinity);
    final left = timeColumnWidth + (_selectionDayIndex! * dayWidth);
    final startLabel = DateFormat.Hm().format(selectionStart);
    final endLabel = DateFormat.Hm().format(selectionEnd);
    final durationHours = durationMinutes ~/ 60;
    final durationRemainderMinutes = durationMinutes % 60;
    final durationLabel =
        '${durationHours.toString().padLeft(2, '0')}:'
        '${durationRemainderMinutes.toString().padLeft(2, '0')}:00';

    return Positioned(
      top: top,
      left: left,
      width: dayWidth,
      height: height,
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: AppTheme.primaryAccent.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppTheme.primaryAccent, width: 2),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 6,
              top: 6,
              right: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryDark.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppTheme.primaryAccent.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$startLabel – $endLabel',
                      style: const TextStyle(color: AppTheme.textPrimary, fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      durationLabel,
                      style: const TextStyle(color: AppTheme.primaryAccent, fontSize: 11, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragPreview(double dayWidth) {
    final entry = _draggingEntry!;
    final Project? project = entry.projectId != null ? widget.getProjectById(entry.projectId!) : null;
    final color = project != null ? AppTheme.colorFromHex(project.color) : AppTheme.primaryAccent;

    final left = timeColumnWidth + (_dragPreviewDayIndex! * dayWidth);

    return Positioned(
      top: _dragPreviewTop,
      left: left,
      width: dayWidth,
      height: _dragPreviewHeight,
      child: IgnorePointer(
        child: Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withValues(alpha: 0.9), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildEntryBlock(TimeEntry entry, double dayWidth) {
    final Project? project = entry.projectId != null ? widget.getProjectById(entry.projectId!) : null;
    final color = project != null ? AppTheme.colorFromHex(project.color) : AppTheme.primaryAccent;

    final entryStart = entry.startTime ?? entry.createdAt.subtract(Duration(minutes: entry.durationMinutes));

    if (entryStart.isBefore(widget.weekStart) || entryStart.isAfter(widget.weekStart.add(const Duration(days: 7)))) {
      return const SizedBox.shrink();
    }

    final dayIndex = entryStart.difference(widget.weekStart).inDays;
    if (dayIndex < 0 || dayIndex >= 7) return const SizedBox.shrink();
    final isResizingThisEntry = _resizingEntryId == entry.id;

    final top = (entryStart.hour * hourHeight) + (entryStart.minute / 60 * hourHeight);
    final height = (entry.durationMinutes / 60 * hourHeight).clamp(20.0, double.infinity);
    final left = timeColumnWidth + (dayIndex * dayWidth);

    final isSelectionActive = _selectionStart != null || _resizingEntryId != null;
    final isFocused = _resizingEntryId == entry.id || _draggingEntry?.id == entry.id;
    final opacity = (isSelectionActive && !isFocused) ? 0.25 : 1.0;

    return Positioned(
      top: top,
      left: left,
      width: dayWidth,
      height: height,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: opacity,
        child: Draggable<TimeEntry>(
          data: entry,
          maxSimultaneousDrags: _resizingEntryId == entry.id ? 0 : 1,
          dragAnchorStrategy: pointerDragAnchorStrategy,
          onDragStarted: () {
            final entryTopMinutes = (entryStart.hour * 60) + entryStart.minute;
            final snappedStartMinutes = ((entryTopMinutes / _snapMinutes).floor() * _snapMinutes).clamp(
              0,
              (24 * 60) - _snapMinutes,
            );
            final snappedTop = (snappedStartMinutes / 60) * hourHeight;
            setState(() {
              _draggingEntry = entry;
              _dragPreviewDayIndex = dayIndex;
              _dragPreviewTop = snappedTop;
              _dragPreviewHeight = height;
            });
          },
          onDragUpdate: (details) {
            if (_draggingEntry == null) return;
            _updateDragPreviewFromGlobalOffset(details.globalPosition, dayWidth);
          },
          onDragEnd: (details) {
            if (!details.wasAccepted) {
              setState(() {
                _draggingEntry = null;
                _dragPreviewDayIndex = null;
                _dragPreviewTop = null;
                _dragPreviewHeight = null;
                _dragCursorLocalPosition = null;
              });
            }
          },
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              _draggingEntry = null;
              _dragPreviewDayIndex = null;
              _dragPreviewTop = null;
              _dragPreviewHeight = null;
              _dragCursorLocalPosition = null;
            });
          },
          feedback: const Material(color: Colors.transparent, child: SizedBox.shrink()),
          childWhenDragging: const SizedBox.shrink(),
          child: GestureDetector(
            // Trigger the dialog on a clean tap (not a drag)
            onTap: isResizingThisEntry ? null : () => widget.onEntryTap(entry, _lastTapPosition),
            onTapDown: (details) {
              // Anchor the dialog slightly to the right of the tap to avoid covering the entry.
              _lastTapPosition = details.globalPosition.translate(dayWidth * 0.25, 0);
              setState(() {
                // Use the local position within the entry block as the grab offset.
                _dragGrabYOffset = details.localPosition.dy;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: color.withValues(alpha: isResizingThisEntry ? 0.06 : 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const descriptionStyle = TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.2,
                        );
                        const durationStyle = TextStyle(fontSize: 10.5, height: 1.2);

                        final availableHeight = constraints.maxHeight;
                        final durationLineHeight = 9 * 1.2;
                        final descriptionLineHeight = 10 * 1.2;

                        final shouldShowDuration = availableHeight >= 28;
                        final spaceForDescription = availableHeight - (shouldShowDuration ? durationLineHeight + 2 : 0);
                        final maxLines = (spaceForDescription / descriptionLineHeight).floor().clamp(1, 10);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (availableHeight > 18)
                              Expanded(
                                child: Text(
                                  entry.description,
                                  style: descriptionStyle,
                                  maxLines: maxLines,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if (shouldShowDuration)
                              Text(
                                entry.formattedDuration,
                                style: durationStyle.copyWith(color: Colors.white.withValues(alpha: 0.8)),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Resize handles
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: _resizeHandleHeight,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeUpDown,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onVerticalDragStart: (_) {
                          _dragGrabYOffset = 0;
                          _startResize(
                            entry: entry,
                            edge: _ResizeEdge.top,
                            entryStart: entryStart,
                            dayIndex: dayIndex,
                            height: height,
                          );
                        },
                        onVerticalDragUpdate: (details) {
                          _updateResizeFromGlobalOffset(details.globalPosition);
                        },
                        onVerticalDragEnd: (_) {
                          _endResize();
                        },
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: _resizeHandleHeight,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeUpDown,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onVerticalDragStart: (_) {
                          _dragGrabYOffset = 0;
                          _startResize(
                            entry: entry,
                            edge: _ResizeEdge.bottom,
                            entryStart: entryStart,
                            dayIndex: dayIndex,
                            height: height,
                          );
                        },
                        onVerticalDragUpdate: (details) {
                          _updateResizeFromGlobalOffset(details.globalPosition);
                        },
                        onVerticalDragEnd: (_) {
                          _endResize();
                        },
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTimeIndicator(double dayWidth) {
    final now = DateTime.now();
    if (now.isBefore(widget.weekStart) || now.isAfter(widget.weekStart.add(const Duration(days: 7)))) {
      return const SizedBox.shrink();
    }

    final dayIndex = now.difference(widget.weekStart).inDays;
    if (dayIndex < 0 || dayIndex >= 7) return const SizedBox.shrink();

    final top = (now.hour * hourHeight) + (now.minute / 60 * hourHeight);
    final left = timeColumnWidth + (dayIndex * dayWidth);

    return Positioned(
      top: top,
      left: left,
      width: dayWidth,
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
          Expanded(child: Container(height: 1, color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildActiveDragTooltip() {
    if (_dragCursorLocalPosition == null) return const SizedBox.shrink();

    final int anchorMinutes;
    if (_resizingEntryId != null && _resizeEdge == _ResizeEdge.bottom) {
      final bottom = (_dragPreviewTop ?? 0) + (_dragPreviewHeight ?? 0);
      anchorMinutes = ((bottom / hourHeight) * 60).round();
    } else {
      anchorMinutes = (((_dragPreviewTop ?? 0) / hourHeight) * 60).round();
    }

    final snappedMinutes = ((anchorMinutes / 15).round() * 15).toInt();
    final h = (snappedMinutes ~/ 60).clamp(0, 23);
    final m = (snappedMinutes % 60).clamp(0, 59);
    final timeLabel = '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

    final dx = _dragCursorLocalPosition!.dx + 12;
    final dy = _dragCursorLocalPosition!.dy - 28;

    return Positioned(
      left: dx,
      top: dy,
      child: IgnorePointer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.cardDark.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.borderDark),
          ),
          child: Text(
            timeLabel,
            style: const TextStyle(color: AppTheme.primaryAccent, fontSize: 12, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  Widget _buildHoverTooltip(double dayWidth) {
    if (_hoverPosition == null) return const SizedBox.shrink();

    final totalMinutes = (_hoverPosition!.dy / hourHeight) * 60;
    final snappedMinutes = ((totalMinutes / 15).round() * 15).toInt();
    final h = (snappedMinutes ~/ 60).clamp(0, 23);
    final m = (snappedMinutes % 60).clamp(0, 59);
    final timeLabel = '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

    String? durationLabel;
    if (_selectionStart != null && _selectionEnd != null) {
      final startLabel = DateFormat.Hm().format(_selectionStart!);
      final endLabel = DateFormat.Hm().format(_selectionEnd!);
      final duration = _selectionEnd!.difference(_selectionStart!);
      final hours = duration.inHours;
      final mins = duration.inMinutes % 60;
      durationLabel = '$startLabel - $endLabel (${hours}h ${mins}m)';
    }

    return Positioned(
      left: _hoverPosition!.dx, // No offset to follow cursor precisely
      top: _hoverPosition!.dy, // No offset to follow cursor precisely
      child: IgnorePointer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.cardDark.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.borderDark),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timeLabel,
                style: const TextStyle(color: AppTheme.primaryAccent, fontSize: 12, fontWeight: FontWeight.w800),
              ),
              if (durationLabel != null) ...[
                const SizedBox(height: 2),
                Text(
                  durationLabel,
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
