import '../../data_providers/firebase/admin_settings_data_provider.dart';
import '../../models/settings/admin_settings.dart';
import '../data_repository.dart';

class AdminSettingsRepository extends DataRepository<AdminSettings, void> {
  AdminSettingsRepository(this._dataProvider) : super(AdminSettings());

  final AdminSettingsDataProvider _dataProvider;

  @override
  Future<AdminSettings> fetch(void _) async {
    try {
      final settings = await _dataProvider.getAdminSettings();
      emit(settings);
      return settings;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  Future<void> updateAdminSettings(AdminSettings settings) async {
    await _dataProvider.updateAdminSettings(settings);
    emit(settings);
  }
}
