import 'package:flutter/foundation.dart';
import 'package:time_tracker/models/time/time_entry.dart';

@immutable
class SubmitHoursDateSection {
  const SubmitHoursDateSection({
    required this.date,
    required this.entries,
    required this.totalMinutes,
  });

  final DateTime date;
  final List<TimeEntry> entries;
  final int totalMinutes;
}
