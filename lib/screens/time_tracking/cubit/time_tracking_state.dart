import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/active_timer.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'time_tracking_state.freezed.dart';

@freezed
class TimeTrackingState with _$TimeTrackingState {
  const factory TimeTrackingState({
    required DateTime selectedDate,
    required List<TimeEntry> entriesForDate,
    required List<TimeEntry> weekEntries,
    required List<Project> projects,
    required List<Tag> tags,
    ActiveTimer? activeTimer,
    String? currentUserId,
    TeamMember? currentMember,
    required bool hasManagerAccess,
    required bool hasActiveTimer,
    required bool isStoppingTimer,
    String? toastMessage,
    AppToastType? toastType,
    TimeEntry? editingEntry,
  }) = _TimeTrackingState;

  factory TimeTrackingState.initial() {
    final now = DateTime.now();
    return TimeTrackingState(
      selectedDate: DateTime(now.year, now.month, now.day),
      entriesForDate: const [],
      weekEntries: const [],
      projects: const [],
      tags: const [],
      activeTimer: null,
      currentUserId: null,
      currentMember: null,
      hasManagerAccess: false,
      hasActiveTimer: false,
      isStoppingTimer: false,
      toastMessage: null,
      toastType: null,
      editingEntry: null,
    );
  }
}
