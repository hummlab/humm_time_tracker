import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/models/time/grid_row.dart';
import 'package:time_tracker/screens/weekly_grid/cubit/weekly_grid_cubit.dart';
import 'package:time_tracker/screens/weekly_grid/cubit/weekly_grid_state.dart';
import 'package:time_tracker/screens/weekly_grid/widgets/weekly_grid_dialogs.dart';
import 'package:time_tracker/screens/weekly_grid/widgets/weekly_grid_empty_state.dart';
import 'package:time_tracker/screens/weekly_grid/widgets/weekly_grid_header.dart';
import 'package:time_tracker/screens/weekly_grid/widgets/weekly_grid_table.dart';

class WeeklyGridScreen extends StatefulWidget {
  const WeeklyGridScreen({super.key});

  @override
  State<WeeklyGridScreen> createState() => _WeeklyGridScreenState();
}

class _WeeklyGridScreenState extends State<WeeklyGridScreen> {
  late final WeeklyGridCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = WeeklyGridCubit(
      AppDependencies.instance.workspaceRepository,
      AppDependencies.instance.timeEntriesRepository,
      AppDependencies.instance.authDataProvider,
    );
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
      body: CubitBuilder<WeeklyGridCubit, WeeklyGridState>(
        cubit: _cubit,
        builder: (context, state) {
          return Column(
            children: [
              WeeklyGridHeader(
                weekStart: state.weekStart,
                onPreviousWeek: _cubit.previousWeek,
                onNextWeek: _cubit.nextWeek,
                onGoToToday: _cubit.goToToday,
                onAddRow: () => _showAddRowDialog(context, state),
              ),
              Expanded(
                child:
                    state.rows.isEmpty
                        ? WeeklyGridEmptyState(onAddRow: () => _showAddRowDialog(context, state))
                        : WeeklyGridTable(
                          weekStart: state.weekStart,
                          rows: state.rows,
                          getProjectById: _cubit.getProjectById,
                          onEditCell: (row, dayIndex) => _showEditCellDialog(context, state, row, dayIndex),
                        ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showEditCellDialog(BuildContext context, WeeklyGridState state, GridRow row, int dayIndex) async {
    final date = state.weekStart.add(Duration(days: dayIndex));
    await showWeeklyGridEditMinutesDialog(
      context: context,
      row: row,
      dayIndex: dayIndex,
      date: date,
      onSave: (minutes) => _cubit.updateCellMinutes(row: row, dayIndex: dayIndex, newMinutes: minutes),
    );
  }

  Future<void> _showAddRowDialog(BuildContext context, WeeklyGridState state) async {
    await showWeeklyGridAddRowDialog(
      context: context,
      projects: state.projects,
      onSave: (description, projectId) => _cubit.addRow(description: description, projectId: projectId),
    );
  }
}
