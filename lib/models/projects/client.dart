import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@freezed
class Client with _$Client {
  const Client._();

  const factory Client({
    required String id,
    required String name,
    String? email,
    String? phone,
    @FirestoreDateTimeConverter() required DateTime createdAt,
    @Default([]) List<String> linkedEmails,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  factory Client.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Client.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': Timestamp.fromDate(createdAt),
      'linkedEmails': linkedEmails,
    };
  }
}
