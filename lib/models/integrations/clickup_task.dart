import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'clickup_task.freezed.dart';
part 'clickup_task.g.dart';

@freezed
class ClickUpTask with _$ClickUpTask {
  const ClickUpTask._();

  const factory ClickUpTask({
    required String id,
    String? customId,
    required String name,
    @Default('') String description,
    @Default('unknown') String status,
    @Default('#808080') String statusColor,
    String? priority,
    String? priorityColor,
    String? listId,
    String? listName,
    String? folderId,
    String? folderName,
    String? spaceId,
    String? spaceName,
    String? url,
    @FirestoreNullableDateTimeConverter() DateTime? dateCreated,
    @FirestoreNullableDateTimeConverter() DateTime? dateUpdated,
    @FirestoreNullableDateTimeConverter() DateTime? dateClosed,
    @FirestoreNullableDateTimeConverter() DateTime? dueDate,
    @FirestoreNullableDateTimeConverter() DateTime? startDate,
    int? timeEstimate,
    int? timeSpent,
    @Default([]) List<ClickUpAssignee> assignees,
    @Default([]) List<ClickUpTag> tags,
    String? parent,
    @FirestoreNullableDateTimeConverter() DateTime? syncedAt,
  }) = _ClickUpTask;

  factory ClickUpTask.fromJson(Map<String, dynamic> json) => _$ClickUpTaskFromJson(json);

  factory ClickUpTask.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ClickUpTask.fromMap(data, doc.id);
  }

  factory ClickUpTask.fromMap(Map<String, dynamic> data, [String? docId]) {
    return ClickUpTask.fromJson({...data, 'id': docId ?? data['id'] ?? ''});
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customId': customId,
      'name': name,
      'description': description,
      'status': status,
      'statusColor': statusColor,
      'priority': priority,
      'priorityColor': priorityColor,
      'listId': listId,
      'listName': listName,
      'folderId': folderId,
      'folderName': folderName,
      'spaceId': spaceId,
      'spaceName': spaceName,
      'url': url,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'dateUpdated': dateUpdated?.millisecondsSinceEpoch,
      'dateClosed': dateClosed?.millisecondsSinceEpoch,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'startDate': startDate?.millisecondsSinceEpoch,
      'timeEstimate': timeEstimate,
      'timeSpent': timeSpent,
      'assignees': assignees.map((a) => a.toJson()).toList(),
      'tags': tags.map((t) => t.toJson()).toList(),
      'parent': parent,
      'syncedAt': syncedAt?.millisecondsSinceEpoch,
    };
  }

  /// Returns a display string for the task (ID + Name)
  String get displayName {
    if (customId != null && customId!.isNotEmpty) {
      return '[$customId] $name';
    }
    return name;
  }

  /// Returns a short identifier for the task
  String get shortId => customId ?? id.substring(0, 8);
}

@freezed
class ClickUpAssignee with _$ClickUpAssignee {
  const ClickUpAssignee._();

  const factory ClickUpAssignee({required String id, String? username, String? email, String? profilePicture}) =
      _ClickUpAssignee;

  factory ClickUpAssignee.fromJson(Map<String, dynamic> json) => _$ClickUpAssigneeFromJson(json);

  factory ClickUpAssignee.fromMap(Map<String, dynamic> data) {
    return ClickUpAssignee.fromJson({
      'id': data['id']?.toString() ?? '',
      'username': data['username'],
      'email': data['email'],
      'profilePicture': data['profilePicture'],
    });
  }
}

@freezed
class ClickUpTag with _$ClickUpTag {
  const ClickUpTag._();

  const factory ClickUpTag({required String name, String? tagFg, String? tagBg}) = _ClickUpTag;

  factory ClickUpTag.fromJson(Map<String, dynamic> json) => _$ClickUpTagFromJson(json);

  factory ClickUpTag.fromMap(Map<String, dynamic> data) {
    return ClickUpTag.fromJson({'name': data['name'] ?? '', 'tagFg': data['tagFg'], 'tagBg': data['tagBg']});
  }
}

/// ClickUp workspace (team)
@freezed
class ClickUpWorkspace with _$ClickUpWorkspace {
  const ClickUpWorkspace._();

  const factory ClickUpWorkspace({required String id, required String name, String? color, String? avatar}) =
      _ClickUpWorkspace;

  factory ClickUpWorkspace.fromJson(Map<String, dynamic> json) => _$ClickUpWorkspaceFromJson(json);

  factory ClickUpWorkspace.fromMap(Map<String, dynamic> data) {
    return ClickUpWorkspace.fromJson({
      'id': data['id']?.toString() ?? '',
      'name': data['name'] ?? '',
      'color': data['color'],
      'avatar': data['avatar'],
    });
  }
}

/// ClickUp space
@freezed
class ClickUpSpace with _$ClickUpSpace {
  const ClickUpSpace._();

  const factory ClickUpSpace({required String id, required String name, String? color, @Default(false) bool private}) =
      _ClickUpSpace;

  factory ClickUpSpace.fromJson(Map<String, dynamic> json) => _$ClickUpSpaceFromJson(json);

  factory ClickUpSpace.fromMap(Map<String, dynamic> data) {
    return ClickUpSpace.fromJson({
      'id': data['id']?.toString() ?? '',
      'name': data['name'] ?? '',
      'color': data['color'],
      'private': data['private'] ?? false,
    });
  }
}

/// ClickUp folder
@freezed
class ClickUpFolder with _$ClickUpFolder {
  const ClickUpFolder._();

  const factory ClickUpFolder({
    required String id,
    required String name,
    @Default(false) bool hidden,
    @Default([]) List<ClickUpList> lists,
  }) = _ClickUpFolder;

  factory ClickUpFolder.fromJson(Map<String, dynamic> json) => _$ClickUpFolderFromJson(json);

  factory ClickUpFolder.fromMap(Map<String, dynamic> data) {
    return ClickUpFolder.fromJson({
      'id': data['id']?.toString() ?? '',
      'name': data['name'] ?? '',
      'hidden': data['hidden'] ?? false,
      'lists':
          (data['lists'] as List<Object?>?)?.map((l) => ClickUpList.fromMap(l as Map<String, dynamic>)).toList() ?? [],
    });
  }
}

/// ClickUp list
@freezed
class ClickUpList with _$ClickUpList {
  const ClickUpList._();

  const factory ClickUpList({
    required String id,
    required String name,
    String? content,
    @Default(false) bool isSelected,
  }) = _ClickUpList;

  factory ClickUpList.fromJson(Map<String, dynamic> json) => _$ClickUpListFromJson(json);

  factory ClickUpList.fromMap(Map<String, dynamic> data) {
    return ClickUpList.fromJson({
      'id': data['id']?.toString() ?? '',
      'name': data['name'] ?? '',
      'content': data['content'],
      'isSelected': data['isSelected'] ?? false,
    });
  }
}

/// ClickUp sync settings
@freezed
class ClickUpSettings with _$ClickUpSettings {
  const ClickUpSettings._();

  const factory ClickUpSettings({
    @Default(false) bool isConfigured,
    @Default(false) bool hasApiToken,
    @Default([]) List<String> selectedListIds,
    String? workspaceId,
    String? webhookId,
    String? webhookUrl,
    @FirestoreNullableDateTimeConverter() DateTime? lastSyncAt,
    @Default(0) int lastSyncTaskCount,
  }) = _ClickUpSettings;

  factory ClickUpSettings.fromJson(Map<String, dynamic> json) => _$ClickUpSettingsFromJson(json);

  factory ClickUpSettings.fromMap(Map<String, dynamic> data) {
    return ClickUpSettings.fromJson({...data, 'lastSyncAt': data['lastSyncAt']});
  }
}
