import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'organization_member.freezed.dart';
part 'organization_member.g.dart';

enum OrganizationRole { owner, admin, manager, member, client }

extension OrganizationRoleExtension on OrganizationRole {
  String get value {
    switch (this) {
      case OrganizationRole.owner:
        return 'owner';
      case OrganizationRole.admin:
        return 'admin';
      case OrganizationRole.manager:
        return 'manager';
      case OrganizationRole.member:
        return 'member';
      case OrganizationRole.client:
        return 'client';
    }
  }

  String get displayName {
    switch (this) {
      case OrganizationRole.owner:
        return 'Owner';
      case OrganizationRole.admin:
        return 'Admin';
      case OrganizationRole.manager:
        return 'Manager';
      case OrganizationRole.member:
        return 'Member';
      case OrganizationRole.client:
        return 'Client';
    }
  }

  static OrganizationRole fromString(String? value) {
    switch (value) {
      case 'owner':
        return OrganizationRole.owner;
      case 'admin':
        return OrganizationRole.admin;
      case 'manager':
        return OrganizationRole.manager;
      case 'client':
        return OrganizationRole.client;
      case 'member':
      default:
        return OrganizationRole.member;
    }
  }
}

OrganizationRole _organizationRoleFromJson(Object? value) {
  return OrganizationRoleExtension.fromString(value?.toString());
}

String _organizationRoleToJson(OrganizationRole value) => value.value;

@freezed
class OrganizationMember with _$OrganizationMember {
  const OrganizationMember._();

  const factory OrganizationMember({
    required String id,
    required String userId,
    required String email,
    String? displayName,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) required OrganizationRole role,
    @FirestoreDateTimeConverter() required DateTime createdAt,
    String? invitedByUserId,
    @Default(true) bool isActive,
  }) = _OrganizationMember;

  factory OrganizationMember.fromJson(Map<String, dynamic> json) => _$OrganizationMemberFromJson(json);

  factory OrganizationMember.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrganizationMember.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'email': email,
      'displayName': displayName,
      'role': role.value,
      'createdAt': Timestamp.fromDate(createdAt),
      'invitedByUserId': invitedByUserId,
      'isActive': isActive,
    };
  }
}
