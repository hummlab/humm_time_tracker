import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/weekly_calendar/cubit/weekly_calendar_cubit.dart';
import 'package:time_tracker/screens/weekly_calendar/cubit/weekly_calendar_state.dart';
import 'package:time_tracker/screens/weekly_calendar/widgets/weekly_calendar_entry_dialog.dart';
import 'package:time_tracker/screens/weekly_calendar/widgets/weekly_calendar_header.dart';
import 'package:time_tracker/widgets/visual_weekly_calendar.dart';

class WeeklyCalendarScreen extends StatefulWidget {
  const WeeklyCalendarScreen({super.key});

  @override
  State<WeeklyCalendarScreen> createState() => _WeeklyCalendarScreenState();
}

class _WeeklyCalendarScreenState extends State<WeeklyCalendarScreen> {
  late final WeeklyCalendarCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = WeeklyCalendarCubit(AppDependencies.instance.timeDataProvider, AppDependencies.instance.authDataProvider);
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CubitBuilder<WeeklyCalendarCubit, WeeklyCalendarState>(
        cubit: _cubit,
        builder: (context, state) {
          final normalizedWeekStart = DateTime(
            state.weekStart.year,
            state.weekStart.month,
            state.weekStart.day,
          ).subtract(Duration(days: state.weekStart.weekday - 1));
          final weekStart = DateTime(normalizedWeekStart.year, normalizedWeekStart.month, normalizedWeekStart.day);
          final weekEnd = weekStart.add(const Duration(days: 7));
          final currentUserId = state.currentUserId;

          final weekEntries =
              state.weekEntries
                  .where(
                    (e) =>
                        e.createdByUserId == currentUserId &&
                        e.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
                        e.date.isBefore(weekEnd),
                  )
                  .toList();

          final weekTotalMinutes = weekEntries.fold(0, (sum, e) => sum + e.durationMinutes);
          final weekHours = weekTotalMinutes ~/ 60;
          final weekMinutes = weekTotalMinutes % 60;

          return Column(
            children: [
              WeeklyCalendarHeader(
                weekStart: weekStart,
                onPreviousWeek: _cubit.previousWeek,
                onNextWeek: _cubit.nextWeek,
                weekHours: weekHours,
                weekMinutes: weekMinutes,
              ),
              Expanded(
                child: VisualWeeklyCalendar(
                  weekStart: weekStart,
                  entries: weekEntries,
                  getProjectById: _cubit.getProjectById,
                  onSlotTap:
                      (start, end, pos, clearSelection) => showWeeklyEntryDialog(
                        context: context,
                        cubit: _cubit,
                        state: state,
                        start: start,
                        end: end,
                        position: pos,
                        onDialogClosed: clearSelection,
                      ),
                  onEntryTap:
                      (entry, pos) => showWeeklyEntryDialog(
                        context: context,
                        cubit: _cubit,
                        state: state,
                        start: entry.startTime ?? entry.date,
                        end: entry.startTime ?? entry.date,
                        position: pos,
                        existingEntry: entry,
                      ),
                  onEntryMoved: (entry, newStart, [newDuration]) {
                    final durationMinutes = newDuration ?? entry.durationMinutes;
                    final candidateEntry = entry.copyWith(
                      date: DateTime(newStart.year, newStart.month, newStart.day),
                      startTime: newStart,
                      durationMinutes: durationMinutes,
                    );

                    if (_cubit.hasOverlap(candidateEntry)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Time entries cannot overlap on the same day.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    _cubit.updateTimeEntry(candidateEntry);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
