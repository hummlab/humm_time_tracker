import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'team_member.freezed.dart';
part 'team_member.g.dart';

enum TeamMemberRole { regular, manager, admin, client }

extension TeamMemberRoleExtension on TeamMemberRole {
  String get displayName {
    switch (this) {
      case TeamMemberRole.regular:
        return 'Regular User';
      case TeamMemberRole.manager:
        return 'Manager';
      case TeamMemberRole.admin:
        return 'Admin';
      case TeamMemberRole.client:
        return 'Client';
    }
  }

  String get value {
    switch (this) {
      case TeamMemberRole.regular:
        return 'regular';
      case TeamMemberRole.manager:
        return 'manager';
      case TeamMemberRole.admin:
        return 'admin';
      case TeamMemberRole.client:
        return 'client';
    }
  }

  static TeamMemberRole fromString(String? value) {
    switch (value) {
      case 'manager':
        return TeamMemberRole.manager;
      case 'admin':
        return TeamMemberRole.admin;
      case 'client':
        return TeamMemberRole.client;
      default:
        return TeamMemberRole.regular;
    }
  }
}

TeamMemberRole _teamMemberRoleFromJson(Object? value) {
  return TeamMemberRoleExtension.fromString(value?.toString());
}

String _teamMemberRoleToJson(TeamMemberRole value) => value.value;

@freezed
class TeamMember with _$TeamMember {
  const TeamMember._();

  const factory TeamMember({
    required String id,
    required String name,
    required String email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson)
    @Default(TeamMemberRole.regular)
    TeamMemberRole role,
    String? avatarUrl,
    required String userId,
    String? firebaseUid,
    @FirestoreDateTimeConverter() required DateTime createdAt,
  }) = _TeamMember;

  factory TeamMember.fromJson(Map<String, dynamic> json) => _$TeamMemberFromJson(json);

  factory TeamMember.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TeamMember.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'role': role.value,
      'avatarUrl': avatarUrl,
      'userId': userId,
      'firebaseUid': firebaseUid,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
