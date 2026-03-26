import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/models/integrations/clickup_task.dart';
import 'package:time_tracker/models/integrations/jira_issue.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/time_tracking/cubit/time_tracking_cubit.dart';
import 'package:time_tracker/screens/time_tracking/cubit/time_tracking_state.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';
import 'package:time_tracker/widgets/duration_chips.dart';
import 'package:time_tracker/widgets/week_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

part 'widgets/time_tracking_active_timer.dart';
part 'widgets/time_tracking_entry_form.dart';
part 'widgets/time_tracking_entry_form_widgets.dart';
part 'widgets/time_tracking_entry_list_item.dart';
part 'widgets/time_tracking_project_picker.dart';
part 'widgets/time_tracking_sections.dart';
part 'widgets/time_tracking_tags_picker.dart';

class TimeTrackingScreen extends StatefulWidget {
  const TimeTrackingScreen({super.key});

  @override
  State<TimeTrackingScreen> createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> {
  late final TimeTrackingCubit _cubit;
  final GlobalKey<TimeEntryFormState> _timeEntryFormKey = GlobalKey<TimeEntryFormState>();
  String? _lastToastMessage;

  void _startEditing(TimeEntry entry) {
    _cubit.startEditing(entry);
  }

  void _stopEditing() {
    _cubit.stopEditing();
  }

  @override
  void initState() {
    super.initState();
    _cubit = TimeTrackingCubit(AppDependencies.instance.timeDataProvider, AppDependencies.instance.authDataProvider);
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubitBuilder<TimeTrackingCubit, TimeTrackingState>(
      cubit: _cubit,
      builder: (context, state) {
        _handleToast(state);
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 800;

        return isDesktop ? _buildDesktopLayout(state) : _buildMobileLayout(state);
      },
    );
  }

  void _handleToast(TimeTrackingState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(context, message, type: state.toastType ?? AppToastType.info);
    });
    _cubit.clearToast();
  }

  Widget _buildDesktopLayout(TimeTrackingState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildTimeEntrySection(state)),
        Container(width: 1, color: AppTheme.borderDark),
        Expanded(flex: 2, child: _buildCalendarAndSummary(state)),
      ],
    );
  }

  Widget _buildMobileLayout(TimeTrackingState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarWidget(state),
          const SizedBox(height: 24),
          _buildStartTimerCard(state),
          const SizedBox(height: 24),
          _buildAddEntryCard(state),
          const SizedBox(height: 24),
          _buildEntriesList(state),
        ],
      ),
    );
  }

  Widget _buildTimeEntrySection(TimeTrackingState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildAddEntryCard(state), const SizedBox(height: 32), _buildEntriesList(state)],
      ),
    );
  }

  Widget _buildCalendarAndSummary(TimeTrackingState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarWidget(state),
          const SizedBox(height: 24),
          if (state.hasActiveTimer) ...[
            ActiveTimerWidget(cubit: _cubit, state: state),
            const SizedBox(height: 24),
          ] else if (state.editingEntry == null) ...[
            _buildStartTimerCard(state),
            const SizedBox(height: 24),
          ],
          _buildDaySummary(state),
        ],
      ),
    );
  }

  Widget _buildCalendarWidget(TimeTrackingState state) {
    final minutesByDate = _cubit.minutesByDateForWeek(currentUserOnly: true);
    return WeekCalendar(
      selectedDate: state.selectedDate,
      onDateSelected: _cubit.setSelectedDate,
      minutesByDate: minutesByDate,
    );
  }

  Widget _buildAddEntryCard(TimeTrackingState state) {
    return TimeEntryForm(
      key: _timeEntryFormKey,
      cubit: _cubit,
      editingEntry: state.editingEntry,
      onCancelEdit: _stopEditing,
      onSaved: _stopEditing,
    );
  }
}

// Time Entry List Item
enum _EntryMenuAction { copyDescription, delete }
