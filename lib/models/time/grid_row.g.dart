// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grid_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GridRowImpl _$$GridRowImplFromJson(Map<String, dynamic> json) => _$GridRowImpl(
  description: json['description'] as String,
  projectId: json['projectId'] as String?,
  tagIds: (json['tagIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  dayMinutes: (json['dayMinutes'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList() ?? const [],
  dayEntryIds:
      (json['dayEntryIds'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList() ??
      const [],
);

Map<String, dynamic> _$$GridRowImplToJson(_$GridRowImpl instance) => <String, dynamic>{
  'description': instance.description,
  'projectId': instance.projectId,
  'tagIds': instance.tagIds,
  'dayMinutes': instance.dayMinutes,
  'dayEntryIds': instance.dayEntryIds,
};
