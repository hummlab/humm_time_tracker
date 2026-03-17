// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationInviteImpl _$$OrganizationInviteImplFromJson(Map<String, dynamic> json) => _$OrganizationInviteImpl(
  id: json['id'] as String,
  organizationId: json['organizationId'] as String,
  organizationName: json['organizationName'] as String,
  email: json['email'] as String,
  role: _organizationRoleFromJson(json['role']),
  status: json['status'] as String,
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$OrganizationInviteImplToJson(_$OrganizationInviteImpl instance) => <String, dynamic>{
  'id': instance.id,
  'organizationId': instance.organizationId,
  'organizationName': instance.organizationName,
  'email': instance.email,
  'role': _organizationRoleToJson(instance.role),
  'status': instance.status,
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
};
