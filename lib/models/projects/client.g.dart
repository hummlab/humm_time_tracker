// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientImpl _$$ClientImplFromJson(Map<String, dynamic> json) => _$ClientImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
  linkedEmails: (json['linkedEmails'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
);

Map<String, dynamic> _$$ClientImplToJson(_$ClientImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
  'linkedEmails': instance.linkedEmails,
};
