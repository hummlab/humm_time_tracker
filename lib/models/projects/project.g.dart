// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) => _$ProjectImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  clientId: json['clientId'] as String?,
  teamMemberIds: (json['teamMemberIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  color: json['color'] as String? ?? '#6366F1',
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
  isActive: json['isActive'] as bool? ?? true,
  clickUpListIds: (json['clickUpListIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
);

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'clientId': instance.clientId,
  'teamMemberIds': instance.teamMemberIds,
  'color': instance.color,
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
  'isActive': instance.isActive,
  'clickUpListIds': instance.clickUpListIds,
};
