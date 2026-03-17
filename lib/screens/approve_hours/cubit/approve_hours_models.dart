import 'package:flutter/foundation.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/time/time_entry.dart';

@immutable
class ApproveHoursDateSection {
  const ApproveHoursDateSection({required this.date, required this.entries, required this.totalMinutes});

  final DateTime date;
  final List<TimeEntry> entries;
  final int totalMinutes;
}

@immutable
class ApproveHoursUserSection {
  const ApproveHoursUserSection({
    required this.member,
    required this.entries,
    required this.dateSections,
    required this.totalMinutes,
  });

  final TeamMember member;
  final List<TimeEntry> entries;
  final List<ApproveHoursDateSection> dateSections;
  final int totalMinutes;
}
