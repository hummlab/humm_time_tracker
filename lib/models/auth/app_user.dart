import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';
import '../org/team_member.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    required String id,
    required String email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson)
    @Default(TeamMemberRole.regular)
    TeamMemberRole role,
    @FirestoreDateTimeConverter() required DateTime createdAt,
    @Default([]) List<String> organizationIds,
    String? defaultOrganizationId,
    String? activeOrganizationId,
    String? clientId,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'role': role.value,
      'createdAt': Timestamp.fromDate(createdAt),
      'organizationIds': organizationIds,
      'defaultOrganizationId': defaultOrganizationId,
      'activeOrganizationId': activeOrganizationId,
      'clientId': clientId,
    };
  }

  bool get isAdmin => role == TeamMemberRole.admin;
  bool get isManager => role == TeamMemberRole.manager;
  bool get isRegular => role == TeamMemberRole.regular;
  bool get isClient => role == TeamMemberRole.client;
  bool get hasManagerAccess => isAdmin || isManager;
  bool get hasOrganizations => organizationIds.isNotEmpty;
}

TeamMemberRole _teamMemberRoleFromJson(Object? value) {
  return TeamMemberRoleExtension.fromString(value?.toString());
}

String _teamMemberRoleToJson(TeamMemberRole value) => value.value;
