import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
class Tag with _$Tag {
  const Tag._();

  const factory Tag({
    required String id,
    required String name,
    @Default('#10B981') String color,
    @FirestoreDateTimeConverter() required DateTime createdAt,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  factory Tag.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Tag.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return {'name': name, 'color': color, 'createdAt': Timestamp.fromDate(createdAt)};
  }
}
