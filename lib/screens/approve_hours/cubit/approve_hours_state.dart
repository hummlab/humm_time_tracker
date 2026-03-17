import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/approve_hours/cubit/approve_hours_models.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'approve_hours_state.freezed.dart';

@freezed
class ApproveHoursState with _$ApproveHoursState {
  const factory ApproveHoursState({
    required List<TimeEntry> pendingEntries,
    required List<TimeEntry> filteredEntries,
    required List<ApproveHoursUserSection> userSections,
    required List<TeamMember> usersWithPending,
    required Map<String, int> pendingCountsByUserId,
    String? filterByUserId,
    required List<String> selectedEntryIds,
    required bool isProcessing,
    required int totalMinutes,
    String? toastMessage,
    AppToastType? toastType,
  }) = _ApproveHoursState;

  factory ApproveHoursState.initial() {
    return const ApproveHoursState(
      pendingEntries: [],
      filteredEntries: [],
      userSections: [],
      usersWithPending: [],
      pendingCountsByUserId: {},
      filterByUserId: null,
      selectedEntryIds: [],
      isProcessing: false,
      totalMinutes: 0,
      toastMessage: null,
      toastType: null,
    );
  }
}
