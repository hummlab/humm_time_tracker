import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/settings/admin_settings.dart';
import 'firebase_core_data_provider.dart';

class AdminSettingsDataProvider {
  AdminSettingsDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  DocumentReference<Map<String, dynamic>> get _adminSettingsDoc =>
      _core.organizationCollection('settings').doc('adminSettings');

  Future<AdminSettings> getAdminSettings() async {
    final doc = await _adminSettingsDoc.get();
    if (!doc.exists) {
      final defaultSettings = AdminSettings();
      await _adminSettingsDoc.set(defaultSettings.toFirestore());
      return defaultSettings;
    }
    return AdminSettings.fromFirestore(doc);
  }

  Future<void> updateAdminSettings(AdminSettings settings) async {
    await _adminSettingsDoc.set(settings.toFirestore());
  }
}
