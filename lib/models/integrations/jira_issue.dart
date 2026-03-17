import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'jira_issue.freezed.dart';
part 'jira_issue.g.dart';

@freezed
class JiraIssue with _$JiraIssue {
  const JiraIssue._();

  const factory JiraIssue({
    required String id,
    required String key,
    required String summary,
    required JiraStatus status,
    required JiraProject project,
    String? priority,
    String? assignee,
    String? url,
    @FirestoreNullableDateTimeConverter() DateTime? updatedAt,
  }) = _JiraIssue;

  factory JiraIssue.fromJson(Map<String, dynamic> json) => _$JiraIssueFromJson(json);

  factory JiraIssue.fromApi(Map<String, dynamic> data, {required String domain}) {
    final fields = data['fields'] as Map<String, dynamic>? ?? {};
    final statusData = fields['status'] as Map<String, dynamic>? ?? {};
    final priorityData = fields['priority'] as Map<String, dynamic>?;
    final assigneeData = fields['assignee'] as Map<String, dynamic>?;
    final projectData = fields['project'] as Map<String, dynamic>? ?? {};

    final statusCategory = statusData['statusCategory'] as Map<String, dynamic>?;
    final colorName = statusCategory?['colorName'] as String?;

    return JiraIssue(
      id: data['id']?.toString() ?? '',
      key: data['key'] ?? '',
      summary: fields['summary'] ?? '',
      status: JiraStatus(name: statusData['name'] ?? 'Unknown', color: JiraStatus.colorFromName(colorName)),
      priority: priorityData?['name'],
      assignee: assigneeData?['displayName'],
      project: JiraProject.fromApi(projectData),
      url: domain.isNotEmpty ? 'https://$domain.atlassian.net/browse/${data['key'] ?? ''}' : null,
      updatedAt: _parseDate(fields['updated']),
    );
  }

  factory JiraIssue.fromMap(Map<String, dynamic> data) {
    return JiraIssue.fromJson({
      'id': data['id'] ?? '',
      'key': data['key'] ?? '',
      'summary': data['summary'] ?? '',
      'status': data['status'] ?? const {},
      'priority': data['priority'],
      'assignee': data['assignee'],
      'project': data['project'] ?? const {},
      'url': data['url'],
      'updatedAt': data['updatedAt'],
    });
  }

  static DateTime? _parseDate(Object? value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'summary': summary,
      'status': status.toJson(),
      'priority': priority,
      'assignee': assignee,
      'project': project.toJson(),
      'url': url,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  String get displayName => '[$key] $summary';

  String get shortId => key;
}

@freezed
class JiraProject with _$JiraProject {
  const JiraProject._();

  const factory JiraProject({required String id, required String key, required String name}) = _JiraProject;

  factory JiraProject.fromJson(Map<String, dynamic> json) => _$JiraProjectFromJson(json);

  factory JiraProject.fromApi(Map<String, dynamic> data) {
    return JiraProject(id: data['id']?.toString() ?? '', key: data['key'] ?? '', name: data['name'] ?? '');
  }

  factory JiraProject.fromMap(Map<String, dynamic> data) {
    return JiraProject.fromJson({'id': data['id'] ?? '', 'key': data['key'] ?? '', 'name': data['name'] ?? ''});
  }
}

@freezed
class JiraStatus with _$JiraStatus {
  const JiraStatus._();

  const factory JiraStatus({required String name, required String color}) = _JiraStatus;

  factory JiraStatus.fromJson(Map<String, dynamic> json) => _$JiraStatusFromJson(json);

  factory JiraStatus.fromMap(Map<String, dynamic> data) {
    return JiraStatus.fromJson({'name': data['name'] ?? 'Unknown', 'color': data['color'] ?? '#808080'});
  }

  static String colorFromName(String? colorName) {
    switch (colorName) {
      case 'green':
        return '#22C55E';
      case 'yellow':
        return '#F59E0B';
      case 'red':
        return '#EF4444';
      case 'blue':
        return '#3B82F6';
      case 'gray':
        return '#6B7280';
      case 'purple':
        return '#8B5CF6';
      default:
        return '#808080';
    }
  }
}

@freezed
class JiraSettings with _$JiraSettings {
  const JiraSettings._();

  const factory JiraSettings({
    String? domain,
    String? email,
    @Default(false) bool hasApiToken,
    @Default([]) List<String> selectedProjectIds,
    @FirestoreNullableDateTimeConverter() DateTime? lastSyncAt,
    @Default(0) int lastSyncIssueCount,
  }) = _JiraSettings;

  factory JiraSettings.fromJson(Map<String, dynamic> json) => _$JiraSettingsFromJson(json);

  factory JiraSettings.fromMap(Map<String, dynamic> data) {
    final lastSyncRaw = data['lastSyncAt'];
    DateTime? lastSyncAt;
    if (lastSyncRaw is Timestamp) {
      lastSyncAt = lastSyncRaw.toDate();
    } else if (lastSyncRaw is String) {
      lastSyncAt = DateTime.tryParse(lastSyncRaw);
    }

    return JiraSettings(
      domain: data['domain'],
      email: data['email'],
      hasApiToken: (data['apiToken'] ?? '').toString().isNotEmpty,
      selectedProjectIds: List<String>.from(data['selectedProjectIds'] ?? []),
      lastSyncAt: lastSyncAt,
      lastSyncIssueCount: data['lastSyncIssueCount'] ?? 0,
    );
  }
}
