import '../../data_providers/integrations/jira_data_provider.dart';
import '../../models/integrations/jira_issue.dart';
import '../data_repository.dart';

class JiraRepository extends DataRepository<List<JiraIssue>, void> {
  JiraRepository(this._dataProvider) : super(const []);

  final JiraDataProvider _dataProvider;

  List<JiraIssue> get cachedIssues => _dataProvider.cachedIssues;
  bool get isCacheStale => _dataProvider.isCacheStale;

  Future<void> init() async {
    try {
      await _dataProvider.init();
      emit(_dataProvider.cachedIssues);
    } catch (e, st) {
      emitError(e, st);
    }
  }

  @override
  Future<List<JiraIssue>> fetch(void _) async {
    return loadIssuesFromCache();
  }

  Future<List<JiraIssue>> loadIssuesFromCache() async {
    try {
      await _dataProvider.reloadCache();
      emit(_dataProvider.cachedIssues);
      return _dataProvider.cachedIssues;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  Future<JiraSettings> getSettings() async {
    try {
      return await _dataProvider.getSettings();
    } catch (e, st) {
      emitError(e, st);
      return JiraSettings();
    }
  }

  Future<bool> saveSettings({String? domain, String? email, String? apiToken, List<String>? selectedProjectIds}) async {
    try {
      return await _dataProvider.saveSettings(
        domain: domain,
        email: email,
        apiToken: apiToken,
        selectedProjectIds: selectedProjectIds,
      );
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<bool> testConnection({required String domain, required String email, required String apiToken}) async {
    try {
      return await _dataProvider.testConnection(domain: domain, email: email, apiToken: apiToken);
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<List<JiraProject>> loadProjects() async {
    try {
      return await _dataProvider.loadProjects();
    } catch (e, st) {
      emitError(e, st);
      return [];
    }
  }

  Future<(bool, int, String?)> syncIssues() async {
    try {
      final result = await _dataProvider.syncIssues();
      emit(_dataProvider.cachedIssues);
      return result;
    } catch (e, st) {
      emitError(e, st);
      return (false, 0, e.toString());
    }
  }

  Future<void> clearCache() async {
    try {
      await _dataProvider.clearCache();
      emit(const []);
    } catch (e, st) {
      emitError(e, st);
    }
  }

  List<JiraIssue> searchIssues(String query, {int limit = 4}) {
    return _dataProvider.searchIssues(query, limit: limit);
  }
}
