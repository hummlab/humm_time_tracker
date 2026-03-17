// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamMemberImpl _$$TeamMemberImplFromJson(Map<String, dynamic> json) => _$TeamMemberImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  role: json['role'] == null ? TeamMemberRole.regular : _teamMemberRoleFromJson(json['role']),
  avatarUrl: json['avatarUrl'] as String?,
  userId: json['userId'] as String,
  firebaseUid: json['firebaseUid'] as String?,
  createdAt: const FirestoreDateTimeConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$TeamMemberImplToJson(_$TeamMemberImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'role': _teamMemberRoleToJson(instance.role),
  'avatarUrl': instance.avatarUrl,
  'userId': instance.userId,
  'firebaseUid': instance.firebaseUid,
  'createdAt': const FirestoreDateTimeConverter().toJson(instance.createdAt),
};
