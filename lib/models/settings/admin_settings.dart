import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_settings.freezed.dart';
part 'admin_settings.g.dart';

/// Admin-only settings that should not be visible to managers or regular users
@freezed
class AdminSettings with _$AdminSettings {
  const AdminSettings._();

  const factory AdminSettings({
    /// Default hourly rate in PLN for budget calculations
    @Default(50.0) double defaultHourlyRate,
  }) = _AdminSettings;

  factory AdminSettings.fromJson(Map<String, dynamic> json) => _$AdminSettingsFromJson(json);

  factory AdminSettings.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return const AdminSettings();
    }
    return AdminSettings.fromJson(data);
  }

  Map<String, dynamic> toFirestore() {
    return {'defaultHourlyRate': defaultHourlyRate};
  }
}
