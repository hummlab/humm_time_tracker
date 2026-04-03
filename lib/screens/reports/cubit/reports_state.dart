import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'reports_state.freezed.dart';

enum ReportPeriod { thisWeek, lastWeek, thisMonth, lastMonth, custom }

enum GroupBy { none, project, client, date }

enum SortBy { date, duration, project }

extension ReportPeriodExtension on ReportPeriod {
  String get displayName {
    switch (this) {
      case ReportPeriod.thisWeek:
        return 'This Week';
      case ReportPeriod.lastWeek:
        return 'Last Week';
      case ReportPeriod.thisMonth:
        return 'This Month';
      case ReportPeriod.lastMonth:
        return 'Last Month';
      case ReportPeriod.custom:
        return 'Custom';
    }
  }

  IconData get icon {
    switch (this) {
      case ReportPeriod.thisWeek:
        return Icons.view_week;
      case ReportPeriod.lastWeek:
        return Icons.history;
      case ReportPeriod.thisMonth:
        return Icons.calendar_month;
      case ReportPeriod.lastMonth:
        return Icons.calendar_today;
      case ReportPeriod.custom:
        return Icons.date_range;
    }
  }

  DateTimeRange getDateRange() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (this) {
      case ReportPeriod.thisWeek:
        final weekStart = today.subtract(Duration(days: today.weekday - 1));
        return DateTimeRange(start: weekStart, end: today);
      case ReportPeriod.lastWeek:
        final thisWeekStart = today.subtract(Duration(days: today.weekday - 1));
        final lastWeekStart = thisWeekStart.subtract(const Duration(days: 7));
        final lastWeekEnd = thisWeekStart.subtract(const Duration(days: 1));
        return DateTimeRange(start: lastWeekStart, end: lastWeekEnd);
      case ReportPeriod.thisMonth:
        final monthStart = DateTime(now.year, now.month, 1);
        return DateTimeRange(start: monthStart, end: today);
      case ReportPeriod.lastMonth:
        final lastMonth = DateTime(now.year, now.month - 1, 1);
        final lastMonthEnd = DateTime(now.year, now.month, 0);
        return DateTimeRange(start: lastMonth, end: lastMonthEnd);
      case ReportPeriod.custom:
        return DateTimeRange(
          start: today.subtract(const Duration(days: 30)),
          end: today,
        );
    }
  }
}

@freezed
class ReportsState with _$ReportsState {
  const factory ReportsState({
    required ReportPeriod selectedPeriod,
    required DateTimeRange selectedRange,
    required List<String> selectedProjectIds,
    required List<String> selectedClientIds,
    required List<String> selectedTagIds,
    required List<String> selectedMemberIds,
    required GroupBy groupBy,
    required SortBy sortBy,
    required bool sortDescending,
    required List<TimeEntry> filteredEntries,
    required int totalMatchingEntries,
    required bool hasMoreEntries,
    required Map<String, int> minutesByProject,
    required int totalMinutes,
    required int uniqueDays,
    required List<Project> filteredProjects,
    required List<Client> filteredClients,
    required List<TeamMember> filteredMembers,
    required List<Tag> tags,
    required bool canChangeMembers,
    required bool hasFilters,
    required bool isLoading,
    String? toastMessage,
    AppToastType? toastType,
  }) = _ReportsState;

  factory ReportsState.initial() {
    final period = ReportPeriod.thisMonth;
    return ReportsState(
      selectedPeriod: period,
      selectedRange: period.getDateRange(),
      selectedProjectIds: const [],
      selectedClientIds: const [],
      selectedTagIds: const [],
      selectedMemberIds: const [],
      groupBy: GroupBy.none,
      sortBy: SortBy.date,
      sortDescending: true,
      filteredEntries: const [],
      totalMatchingEntries: 0,
      hasMoreEntries: false,
      minutesByProject: const {},
      totalMinutes: 0,
      uniqueDays: 0,
      filteredProjects: const [],
      filteredClients: const [],
      filteredMembers: const [],
      tags: const [],
      canChangeMembers: false,
      hasFilters: false,
      isLoading: false,
      toastMessage: null,
      toastType: null,
    );
  }
}
