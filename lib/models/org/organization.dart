import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'organization.freezed.dart';
part 'organization.g.dart';

@freezed
class Organization with _$Organization {
  const Organization._();

  const factory Organization({
    required String id,
    required String name,
    required String ownerUserId,
    @FirestoreDateTimeConverter() required DateTime createdAt,
    @FirestoreNullableDateTimeConverter() DateTime? updatedAt,
  }) = _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);

  factory Organization.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Organization.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'ownerUserId': ownerUserId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
