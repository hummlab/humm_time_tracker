// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  color: json['color'] as String? ?? '#10B981',
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
};
