// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) => _$AppUserImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  role: json['role'] == null ? TeamMemberRole.regular : _teamMemberRoleFromJson(json['role']),
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
  organizationIds: (json['organizationIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  defaultOrganizationId: json['defaultOrganizationId'] as String?,
  activeOrganizationId: json['activeOrganizationId'] as String?,
  clientId: json['clientId'] as String?,
);

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'role': _teamMemberRoleToJson(instance.role),
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
  'organizationIds': instance.organizationIds,
  'defaultOrganizationId': instance.defaultOrganizationId,
  'activeOrganizationId': instance.activeOrganizationId,
  'clientId': instance.clientId,
};
