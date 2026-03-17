// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationImpl _$$OrganizationImplFromJson(Map<String, dynamic> json) => _$OrganizationImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  ownerUserId: json['ownerUserId'] as String,
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const FirestoreNullableDateTimeConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$OrganizationImplToJson(_$OrganizationImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'ownerUserId': instance.ownerUserId,
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const FirestoreNullableDateTimeConverter().toJson(instance.updatedAt),
};
