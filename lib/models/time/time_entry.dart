import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'time_entry.freezed.dart';
part 'time_entry.g.dart';

/// Status of a time entry in the approval workflow
enum TimeEntryStatus {
  /// Entry is being worked on, not yet submitted
  draft,

  /// Entry has been submitted for approval
  pending,

  /// Entry has been approved by manager/admin
  approved,

  /// Entry has been rejected
  rejected,
}

extension TimeEntryStatusExtension on TimeEntryStatus {
  String get value {
    switch (this) {
      case TimeEntryStatus.draft:
        return 'draft';
      case TimeEntryStatus.pending:
        return 'pending';
      case TimeEntryStatus.approved:
        return 'approved';
      case TimeEntryStatus.rejected:
        return 'rejected';
    }
  }

  String get displayName {
    switch (this) {
      case TimeEntryStatus.draft:
        return 'Draft';
      case TimeEntryStatus.pending:
        return 'Pending Approval';
      case TimeEntryStatus.approved:
        return 'Approved';
      case TimeEntryStatus.rejected:
        return 'Rejected';
    }
  }

  static TimeEntryStatus fromString(String? value) {
    switch (value) {
      case 'pending':
        return TimeEntryStatus.pending;
      case 'approved':
        return TimeEntryStatus.approved;
      case 'rejected':
        return TimeEntryStatus.rejected;
      default:
        return TimeEntryStatus.draft;
    }
  }
}

TimeEntryStatus _timeEntryStatusFromJson(Object? value) {
  return TimeEntryStatusExtension.fromString(value?.toString());
}

String _timeEntryStatusToJson(TimeEntryStatus value) => value.value;

@freezed
class TimeEntry with _$TimeEntry {
  const TimeEntry._();

  const factory TimeEntry({
    required String id,
    required String description,
    required int durationMinutes,
    @FirestoreDateTimeConverter() required DateTime date,
    String? projectId,
    @Default([]) List<String> tagIds,
    required String createdByUserId,
    @FirestoreDateTimeConverter() required DateTime createdAt,
    String? clickUpTaskId,
    String? jiraIssueKey,
    @JsonKey(fromJson: _timeEntryStatusFromJson, toJson: _timeEntryStatusToJson)
    @Default(TimeEntryStatus.draft)
    TimeEntryStatus status,
    String? approvedByUserId,
    @FirestoreNullableDateTimeConverter() DateTime? approvedAt,
    String? rejectionReason,
    @FirestoreNullableDateTimeConverter() DateTime? startTime,
  }) = _TimeEntry;

  factory TimeEntry.fromJson(Map<String, dynamic> json) => _$TimeEntryFromJson(json);

  factory TimeEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final createdBy = data['createdByUserId'] ?? data['userId'] ?? '';
    return TimeEntry.fromJson({...data, 'id': doc.id, 'createdByUserId': createdBy});
  }

  Map<String, dynamic> toFirestore() {
    return {
      'description': description,
      'durationMinutes': durationMinutes,
      'date': Timestamp.fromDate(date),
      'projectId': projectId,
      'tagIds': tagIds,
      'createdByUserId': createdByUserId,
      'createdAt': Timestamp.fromDate(createdAt),
      'clickUpTaskId': clickUpTaskId,
      'jiraIssueKey': jiraIssueKey,
      'status': status.value,
      'approvedByUserId': approvedByUserId,
      'approvedAt': approvedAt != null ? Timestamp.fromDate(approvedAt!) : null,
      'rejectionReason': rejectionReason,
      'startTime': startTime != null ? Timestamp.fromDate(startTime!) : null,
    };
  }

  /// Calculate time range string for display
  String get timeRange {
    final start = startTime ?? createdAt.subtract(Duration(minutes: durationMinutes));
    final end = start.add(Duration(minutes: durationMinutes));
    final startStr = '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    final endStr = '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    return '$startStr–$endStr';
  }

  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }

  bool get isDraft => status == TimeEntryStatus.draft;
  bool get isPending => status == TimeEntryStatus.pending;
  bool get isApproved => status == TimeEntryStatus.approved;
  bool get isRejected => status == TimeEntryStatus.rejected;
}
