import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const Project._();

  const factory Project({
    required String id,
    required String name,
    String? description,
    String? clientId,
    @Default([]) List<String> teamMemberIds,
    @Default('#6366F1') String color,
    @FirestoreDateTimeConverter() required DateTime createdAt,
    @Default(true) bool isActive,
    @Default([]) List<String> clickUpListIds,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  factory Project.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Project.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'clientId': clientId,
      'teamMemberIds': teamMemberIds,
      'color': color,
      'createdAt': Timestamp.fromDate(createdAt),
      'isActive': isActive,
      'clickUpListIds': clickUpListIds,
    };
  }
}
