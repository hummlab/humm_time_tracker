// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jira_issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JiraIssueImpl _$$JiraIssueImplFromJson(Map<String, dynamic> json) => _$JiraIssueImpl(
  id: json['id'] as String,
  key: json['key'] as String,
  summary: json['summary'] as String,
  status: JiraStatus.fromJson(json['status'] as Map<String, dynamic>),
  project: JiraProject.fromJson(json['project'] as Map<String, dynamic>),
  priority: json['priority'] as String?,
  assignee: json['assignee'] as String?,
  url: json['url'] as String?,
  updatedAt: const FirestoreNullableDateTimeConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$JiraIssueImplToJson(_$JiraIssueImpl instance) => <String, dynamic>{
  'id': instance.id,
  'key': instance.key,
  'summary': instance.summary,
  'status': instance.status,
  'project': instance.project,
  'priority': instance.priority,
  'assignee': instance.assignee,
  'url': instance.url,
  'updatedAt': const FirestoreNullableDateTimeConverter().toJson(instance.updatedAt),
};

_$JiraProjectImpl _$$JiraProjectImplFromJson(Map<String, dynamic> json) =>
    _$JiraProjectImpl(id: json['id'] as String, key: json['key'] as String, name: json['name'] as String);

Map<String, dynamic> _$$JiraProjectImplToJson(_$JiraProjectImpl instance) => <String, dynamic>{
  'id': instance.id,
  'key': instance.key,
  'name': instance.name,
};

_$JiraStatusImpl _$$JiraStatusImplFromJson(Map<String, dynamic> json) =>
    _$JiraStatusImpl(name: json['name'] as String, color: json['color'] as String);

Map<String, dynamic> _$$JiraStatusImplToJson(_$JiraStatusImpl instance) => <String, dynamic>{
  'name': instance.name,
  'color': instance.color,
};

_$JiraSettingsImpl _$$JiraSettingsImplFromJson(Map<String, dynamic> json) => _$JiraSettingsImpl(
  domain: json['domain'] as String?,
  email: json['email'] as String?,
  hasApiToken: json['hasApiToken'] as bool? ?? false,
  selectedProjectIds: (json['selectedProjectIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  lastSyncAt: const FirestoreNullableDateTimeConverter().fromJson(json['lastSyncAt']),
  lastSyncIssueCount: (json['lastSyncIssueCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$JiraSettingsImplToJson(_$JiraSettingsImpl instance) => <String, dynamic>{
  'domain': instance.domain,
  'email': instance.email,
  'hasApiToken': instance.hasApiToken,
  'selectedProjectIds': instance.selectedProjectIds,
  'lastSyncAt': const FirestoreNullableDateTimeConverter().toJson(instance.lastSyncAt),
  'lastSyncIssueCount': instance.lastSyncIssueCount,
};
