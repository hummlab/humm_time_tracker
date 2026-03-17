// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeEntryImpl _$$TimeEntryImplFromJson(Map<String, dynamic> json) => _$TimeEntryImpl(
  id: json['id'] as String,
  description: json['description'] as String,
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  date: const FirestoreDateTimeConverter().fromJson(json['date']),
  projectId: json['projectId'] as String?,
  tagIds: (json['tagIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  createdByUserId: json['createdByUserId'] as String,
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
  clickUpTaskId: json['clickUpTaskId'] as String?,
  jiraIssueKey: json['jiraIssueKey'] as String?,
  status: json['status'] == null ? TimeEntryStatus.draft : _timeEntryStatusFromJson(json['status']),
  approvedByUserId: json['approvedByUserId'] as String?,
  approvedAt: const FirestoreNullableDateTimeConverter().fromJson(json['approvedAt']),
  rejectionReason: json['rejectionReason'] as String?,
  startTime: const FirestoreNullableDateTimeConverter().fromJson(json['startTime']),
);

Map<String, dynamic> _$$TimeEntryImplToJson(_$TimeEntryImpl instance) => <String, dynamic>{
  'id': instance.id,
  'description': instance.description,
  'durationMinutes': instance.durationMinutes,
  'date': const FirestoreDateTimeConverter().toJson(instance.date),
  'projectId': instance.projectId,
  'tagIds': instance.tagIds,
  'createdByUserId': instance.createdByUserId,
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
  'clickUpTaskId': instance.clickUpTaskId,
  'jiraIssueKey': instance.jiraIssueKey,
  'status': _timeEntryStatusToJson(instance.status),
  'approvedByUserId': instance.approvedByUserId,
  'approvedAt': const FirestoreNullableDateTimeConverter().toJson(instance.approvedAt),
  'rejectionReason': instance.rejectionReason,
  'startTime': const FirestoreNullableDateTimeConverter().toJson(instance.startTime),
};
