import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/screens/submit_hours/cubit/submit_hours_models.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'submit_hours_state.freezed.dart';

enum SubmitHoursQuickSelectPeriod { none, thisMonth, lastMonth }

@freezed
class SubmitHoursState with _$SubmitHoursState {
  const factory SubmitHoursState({
    required List<TimeEntry> draftEntries,
    required List<TimeEntry> pendingEntries,
    required List<TimeEntry> rejectedEntries,
    required List<SubmitHoursDateSection> draftSections,
    required List<SubmitHoursDateSection> pendingSections,
    required List<SubmitHoursDateSection> rejectedSections,
    required List<String> selectedEntryIds,
    required SubmitHoursQuickSelectPeriod activeQuickSelect,
    required bool isSubmitting,
    required int totalDraftMinutes,
    required int totalPendingMinutes,
    required int totalRejectedMinutes,
    required int selectedTotalMinutes,
    String? toastMessage,
    AppToastType? toastType,
  }) = _SubmitHoursState;

  factory SubmitHoursState.initial() {
    return const SubmitHoursState(
      draftEntries: [],
      pendingEntries: [],
      rejectedEntries: [],
      draftSections: [],
      pendingSections: [],
      rejectedSections: [],
      selectedEntryIds: [],
      activeQuickSelect: SubmitHoursQuickSelectPeriod.none,
      isSubmitting: false,
      totalDraftMinutes: 0,
      totalPendingMinutes: 0,
      totalRejectedMinutes: 0,
      selectedTotalMinutes: 0,
      toastMessage: null,
      toastType: null,
    );
  }
}
