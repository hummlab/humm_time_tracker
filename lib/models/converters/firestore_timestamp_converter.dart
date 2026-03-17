import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FirestoreDateTimeConverter implements JsonConverter<DateTime, Object?> {
  const FirestoreDateTimeConverter();

  @override
  DateTime fromJson(Object? json) {
    if (json == null) {
      return DateTime.now();
    }
    if (json is DateTime) return json;
    if (json is Timestamp) return json.toDate();
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    if (json is String) {
      final parsed = DateTime.tryParse(json);
      if (parsed != null) return parsed;
    }
    return DateTime.now();
  }

  @override
  Object toJson(DateTime object) => object.toIso8601String();
}

class FirestoreNullableDateTimeConverter implements JsonConverter<DateTime?, Object?> {
  const FirestoreNullableDateTimeConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is DateTime) return json;
    if (json is Timestamp) return json.toDate();
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    if (json is String) return DateTime.tryParse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) => object?.toIso8601String();
}
