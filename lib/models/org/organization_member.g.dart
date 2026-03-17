// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationMemberImpl _$$OrganizationMemberImplFromJson(Map<String, dynamic> json) => _$OrganizationMemberImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  role: _organizationRoleFromJson(json['role']),
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
  invitedByUserId: json['invitedByUserId'] as String?,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$$OrganizationMemberImplToJson(_$OrganizationMemberImpl instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'email': instance.email,
  'displayName': instance.displayName,
  'role': _organizationRoleToJson(instance.role),
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
  'invitedByUserId': instance.invitedByUserId,
  'isActive': instance.isActive,
};
