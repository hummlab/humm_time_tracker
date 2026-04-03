import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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

part 'widgets/time_tracking_entry_form_widgets.dart';
part 'widgets/time_tracking_project_picker.dart';
part 'widgets/time_tracking_tags_picker.dart';
part 'widgets/time_tracking_active_timer.dart';
part 'widgets/time_tracking_entry_list_item.dart';
part 'widgets/time_tracking_entry_form.dart';
part 'widgets/time_tracking_sections.dart';

class TimeTrackingScreen extends StatefulWidget {
  const TimeTrackingScreen({super.key});

  @override
  State<TimeTrackingScreen> createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> {
  late final TimeTrackingCubit _cubit;
  final GlobalKey<TimeEntryFormState> _timeEntryFormKey =
      GlobalKey<TimeEntryFormState>();
  final TextEditingController _quickDescriptionController =
      TextEditingController();
  String? _lastToastMessage;

  void _startEditing(TimeEntry entry) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    if (!isDesktop) {
      _showEntryFormSheet(editingEntry: entry);
      return;
    }
    _cubit.startEditing(entry);
  }

  void _stopEditing() {
    _cubit.stopEditing();
  }

  @override
  void initState() {
    super.initState();
    _cubit = TimeTrackingCubit(
      AppDependencies.instance.timeDataProvider,
      AppDependencies.instance.authDataProvider,
    );
  }

  @override
  void dispose() {
    _quickDescriptionController.dispose();
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

        return isDesktop
            ? _buildDesktopLayout(state)
            : _buildMobileLayout(state);
      },
    );
  }

  void _handleToast(TimeTrackingState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(
        context,
        message,
        type: state.toastType ?? AppToastType.info,
      );
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
          const SizedBox(height: 16),
          state.hasActiveTimer
              ? ActiveTimerWidget(cubit: _cubit, state: state)
              : _buildStartTimerCard(state),
          const SizedBox(height: 16),
          _buildQuickAddCard(),
          const SizedBox(height: 16),
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
        children: [
          _buildAddEntryCard(state),
          const SizedBox(height: 32),
          _buildEntriesList(state),
        ],
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

  Widget _buildQuickAddCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.add, color: AppTheme.primaryAccent, size: 18),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _quickDescriptionController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: 'Quick entry description',
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 2),
          child: FilledButton(
            onPressed:
                () => _showEntryFormSheet(
                  initialDescription: _quickDescriptionController.text.trim(),
                ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryAccent,
              foregroundColor: AppTheme.primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: const Size(0, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Add'),
          ),
        ),
      ],
    );
  }

  Future<void> _showEntryFormSheet({
    TimeEntry? editingEntry,
    String? initialDescription,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final insets = MediaQuery.of(sheetContext).viewInsets;
        return Padding(
          padding: EdgeInsets.only(bottom: insets.bottom),
          child: SafeArea(
            top: false,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(sheetContext).size.height * 0.94,
              ),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.textMuted.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.of(sheetContext).pop(),
                      icon: const Icon(Icons.close, size: 20),
                      color: AppTheme.textSecondary,
                      tooltip: 'Close',
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: TimeEntryForm(
                        cubit: _cubit,
                        editingEntry: editingEntry,
                        initialDescription: initialDescription,
                        onCancelEdit: () => Navigator.of(sheetContext).pop(),
                        onSaved: () {
                          _quickDescriptionController.clear();
                          Navigator.of(sheetContext).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showQuickTimerSheet() async {
    final descriptionController = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final insets = MediaQuery.of(sheetContext).viewInsets;
        return Padding(
          padding: EdgeInsets.only(bottom: insets.bottom),
          child: SafeArea(
            top: false,
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.cardDark,
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.textMuted.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Start Timer',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        icon: const Icon(Icons.close, size: 20),
                        color: AppTheme.textSecondary,
                        tooltip: 'Close',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'What are you working on?',
                      prefixIcon: Icon(Icons.edit_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final description =
                                descriptionController.text.trim();
                            if (description.isEmpty) {
                              AppToast.show(
                                context,
                                'Enter description first',
                                type: AppToastType.error,
                              );
                              return;
                            }
                            _cubit.startTimer(description: description);
                            Navigator.of(sheetContext).pop();
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Start'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.successAccent,
                            foregroundColor: AppTheme.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    descriptionController.dispose();
  }
}

// Time Entry List Item
enum _EntryMenuAction { copyDescription, delete }
