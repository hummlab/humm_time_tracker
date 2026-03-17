// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActiveTimerImpl _$$ActiveTimerImplFromJson(Map<String, dynamic> json) => _$ActiveTimerImpl(
  description: json['description'] as String,
  projectId: json['projectId'] as String?,
  tagIds: (json['tagIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  startTime: const FirestoreDateTimeConverter().fromJson(json['startTime']),
  targetMinutes: (json['targetMinutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ActiveTimerImplToJson(_$ActiveTimerImpl instance) => <String, dynamic>{
  'description': instance.description,
  'projectId': instance.projectId,
  'tagIds': instance.tagIds,
  'startTime': const FirestoreDateTimeConverter().toJson(instance.startTime),
  'targetMinutes': instance.targetMinutes,
};
