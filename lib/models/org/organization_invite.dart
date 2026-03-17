import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';
import 'organization_member.dart';

part 'organization_invite.freezed.dart';
part 'organization_invite.g.dart';

@freezed
class OrganizationInvite with _$OrganizationInvite {
  const OrganizationInvite._();

  const factory OrganizationInvite({
    required String id,
    required String organizationId,
    required String organizationName,
    required String email,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) required OrganizationRole role,
    required String status,
    @FirestoreDateTimeConverter() required DateTime createdAt,
  }) = _OrganizationInvite;

  factory OrganizationInvite.fromJson(Map<String, dynamic> json) => _$OrganizationInviteFromJson(json);

  factory OrganizationInvite.fromFunctionMap(Map<String, dynamic> data) {
    final createdAtMs = data['createdAtMs'] as int?;
    return OrganizationInvite(
      id: data['id'] as String? ?? '',
      organizationId: data['organizationId'] as String? ?? '',
      organizationName: data['organizationName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: OrganizationRoleExtension.fromString(data['role'] as String?),
      status: data['status'] as String? ?? 'pending',
      createdAt: createdAtMs != null ? DateTime.fromMillisecondsSinceEpoch(createdAtMs) : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'email': email,
      'role': role.value,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

OrganizationRole _organizationRoleFromJson(Object? value) {
  return OrganizationRoleExtension.fromString(value?.toString());
}

String _organizationRoleToJson(OrganizationRole value) => value.value;
