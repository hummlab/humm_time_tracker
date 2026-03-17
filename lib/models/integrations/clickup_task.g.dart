// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clickup_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClickUpTaskImpl _$$ClickUpTaskImplFromJson(Map<String, dynamic> json) => _$ClickUpTaskImpl(
  id: json['id'] as String,
  customId: json['customId'] as String?,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  status: json['status'] as String? ?? 'unknown',
  statusColor: json['statusColor'] as String? ?? '#808080',
  priority: json['priority'] as String?,
  priorityColor: json['priorityColor'] as String?,
  listId: json['listId'] as String?,
  listName: json['listName'] as String?,
  folderId: json['folderId'] as String?,
  folderName: json['folderName'] as String?,
  spaceId: json['spaceId'] as String?,
  spaceName: json['spaceName'] as String?,
  url: json['url'] as String?,
  dateCreated: const FirestoreNullableDateTimeConverter().fromJson(json['dateCreated']),
  dateUpdated: const FirestoreNullableDateTimeConverter().fromJson(json['dateUpdated']),
  dateClosed: const FirestoreNullableDateTimeConverter().fromJson(json['dateClosed']),
  dueDate: const FirestoreNullableDateTimeConverter().fromJson(json['dueDate']),
  startDate: const FirestoreNullableDateTimeConverter().fromJson(json['startDate']),
  timeEstimate: (json['timeEstimate'] as num?)?.toInt(),
  timeSpent: (json['timeSpent'] as num?)?.toInt(),
  assignees:
      (json['assignees'] as List<dynamic>?)?.map((e) => ClickUpAssignee.fromJson(e as Map<String, dynamic>)).toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => ClickUpTag.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
  parent: json['parent'] as String?,
  syncedAt: const FirestoreNullableDateTimeConverter().fromJson(json['syncedAt']),
);

Map<String, dynamic> _$$ClickUpTaskImplToJson(_$ClickUpTaskImpl instance) => <String, dynamic>{
  'id': instance.id,
  'customId': instance.customId,
  'name': instance.name,
  'description': instance.description,
  'status': instance.status,
  'statusColor': instance.statusColor,
  'priority': instance.priority,
  'priorityColor': instance.priorityColor,
  'listId': instance.listId,
  'listName': instance.listName,
  'folderId': instance.folderId,
  'folderName': instance.folderName,
  'spaceId': instance.spaceId,
  'spaceName': instance.spaceName,
  'url': instance.url,
  'dateCreated': const FirestoreNullableDateTimeConverter().toJson(instance.dateCreated),
  'dateUpdated': const FirestoreNullableDateTimeConverter().toJson(instance.dateUpdated),
  'dateClosed': const FirestoreNullableDateTimeConverter().toJson(instance.dateClosed),
  'dueDate': const FirestoreNullableDateTimeConverter().toJson(instance.dueDate),
  'startDate': const FirestoreNullableDateTimeConverter().toJson(instance.startDate),
  'timeEstimate': instance.timeEstimate,
  'timeSpent': instance.timeSpent,
  'assignees': instance.assignees,
  'tags': instance.tags,
  'parent': instance.parent,
  'syncedAt': const FirestoreNullableDateTimeConverter().toJson(instance.syncedAt),
};

_$ClickUpAssigneeImpl _$$ClickUpAssigneeImplFromJson(Map<String, dynamic> json) => _$ClickUpAssigneeImpl(
  id: json['id'] as String,
  username: json['username'] as String?,
  email: json['email'] as String?,
  profilePicture: json['profilePicture'] as String?,
);

Map<String, dynamic> _$$ClickUpAssigneeImplToJson(_$ClickUpAssigneeImpl instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'profilePicture': instance.profilePicture,
};

_$ClickUpTagImpl _$$ClickUpTagImplFromJson(Map<String, dynamic> json) =>
    _$ClickUpTagImpl(name: json['name'] as String, tagFg: json['tagFg'] as String?, tagBg: json['tagBg'] as String?);

Map<String, dynamic> _$$ClickUpTagImplToJson(_$ClickUpTagImpl instance) => <String, dynamic>{
  'name': instance.name,
  'tagFg': instance.tagFg,
  'tagBg': instance.tagBg,
};

_$ClickUpWorkspaceImpl _$$ClickUpWorkspaceImplFromJson(Map<String, dynamic> json) => _$ClickUpWorkspaceImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  color: json['color'] as String?,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$$ClickUpWorkspaceImplToJson(_$ClickUpWorkspaceImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'avatar': instance.avatar,
};

_$ClickUpSpaceImpl _$$ClickUpSpaceImplFromJson(Map<String, dynamic> json) => _$ClickUpSpaceImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  color: json['color'] as String?,
  private: json['private'] as bool? ?? false,
);

Map<String, dynamic> _$$ClickUpSpaceImplToJson(_$ClickUpSpaceImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'private': instance.private,
};

_$ClickUpFolderImpl _$$ClickUpFolderImplFromJson(Map<String, dynamic> json) => _$ClickUpFolderImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  hidden: json['hidden'] as bool? ?? false,
  lists:
      (json['lists'] as List<dynamic>?)?.map((e) => ClickUpList.fromJson(e as Map<String, dynamic>)).toList() ??
      const [],
);

Map<String, dynamic> _$$ClickUpFolderImplToJson(_$ClickUpFolderImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'hidden': instance.hidden,
  'lists': instance.lists,
};

_$ClickUpListImpl _$$ClickUpListImplFromJson(Map<String, dynamic> json) => _$ClickUpListImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  content: json['content'] as String?,
  isSelected: json['isSelected'] as bool? ?? false,
);

Map<String, dynamic> _$$ClickUpListImplToJson(_$ClickUpListImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'content': instance.content,
  'isSelected': instance.isSelected,
};

_$ClickUpSettingsImpl _$$ClickUpSettingsImplFromJson(Map<String, dynamic> json) => _$ClickUpSettingsImpl(
  isConfigured: json['isConfigured'] as bool? ?? false,
  hasApiToken: json['hasApiToken'] as bool? ?? false,
  selectedListIds: (json['selectedListIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  workspaceId: json['workspaceId'] as String?,
  webhookId: json['webhookId'] as String?,
  webhookUrl: json['webhookUrl'] as String?,
  lastSyncAt: const FirestoreNullableDateTimeConverter().fromJson(json['lastSyncAt']),
  lastSyncTaskCount: (json['lastSyncTaskCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ClickUpSettingsImplToJson(_$ClickUpSettingsImpl instance) => <String, dynamic>{
  'isConfigured': instance.isConfigured,
  'hasApiToken': instance.hasApiToken,
  'selectedListIds': instance.selectedListIds,
  'workspaceId': instance.workspaceId,
  'webhookId': instance.webhookId,
  'webhookUrl': instance.webhookUrl,
  'lastSyncAt': const FirestoreNullableDateTimeConverter().toJson(instance.lastSyncAt),
  'lastSyncTaskCount': instance.lastSyncTaskCount,
};
