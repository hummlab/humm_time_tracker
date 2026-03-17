import '../../data_providers/integrations/clickup_data_provider.dart';
import '../../models/integrations/clickup_task.dart';
import '../data_repository.dart';

class ClickUpRepository extends DataRepository<List<ClickUpTask>, void> {
  ClickUpRepository(this._dataProvider) : super(const []);

  final ClickUpDataProvider _dataProvider;

  List<ClickUpTask> get cachedTasks => _dataProvider.cachedTasks;
  bool get isCacheStale => _dataProvider.isCacheStale;

  Future<void> init() async {
    try {
      await _dataProvider.init();
      emit(_dataProvider.cachedTasks);
    } catch (e, st) {
      emitError(e, st);
    }
  }

  @override
  Future<List<ClickUpTask>> fetch(void _) async {
    return loadTasksFromFirestore();
  }

  Future<List<ClickUpTask>> loadTasksFromFirestore({bool forceFullLoad = false}) async {
    try {
      final tasks = await _dataProvider.loadTasksFromFirestore(forceFullLoad: forceFullLoad);
      emit(tasks);
      return tasks;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  List<ClickUpTask> searchTasks(String query, {int limit = 4}) {
    return _dataProvider.searchTasks(query, limit: limit);
  }

  Future<ClickUpSettings> getSettings() async {
    try {
      return await _dataProvider.getSettings();
    } catch (e, st) {
      emitError(e, st);
      return ClickUpSettings();
    }
  }

  Future<bool> saveApiToken(String apiToken) async {
    try {
      return await _dataProvider.saveApiToken(apiToken);
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<bool> saveSelectedLists(List<String> listIds) async {
    try {
      return await _dataProvider.saveSelectedLists(listIds);
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<bool> saveWorkspaceId(String workspaceId) async {
    try {
      return await _dataProvider.saveWorkspaceId(workspaceId);
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<List<ClickUpWorkspace>> getWorkspaces() async {
    try {
      return await _dataProvider.getWorkspaces();
    } catch (e, st) {
      emitError(e, st);
      return [];
    }
  }

  Future<List<ClickUpSpace>> getSpaces(String workspaceId) async {
    try {
      return await _dataProvider.getSpaces(workspaceId);
    } catch (e, st) {
      emitError(e, st);
      return [];
    }
  }

  Future<List<ClickUpFolder>> getFolders(String spaceId) async {
    try {
      return await _dataProvider.getFolders(spaceId);
    } catch (e, st) {
      emitError(e, st);
      return [];
    }
  }

  Future<List<ClickUpList>> getFolderlessLists(String spaceId) async {
    try {
      return await _dataProvider.getFolderlessLists(spaceId);
    } catch (e, st) {
      emitError(e, st);
      return [];
    }
  }

  Future<List<ClickUpList>> getFolderLists(String folderId) async {
    try {
      return await _dataProvider.getFolderLists(folderId);
    } catch (e, st) {
      emitError(e, st);
      return [];
    }
  }

  Future<(bool, int, String?)> syncAllTasks() async {
    try {
      final result = await _dataProvider.syncAllTasks();
      emit(_dataProvider.cachedTasks);
      return result;
    } catch (e, st) {
      emitError(e, st);
      return (false, 0, e.toString());
    }
  }

  Future<(bool, int, String?)> syncTasksIncremental() async {
    try {
      final result = await _dataProvider.syncTasksIncremental();
      emit(_dataProvider.cachedTasks);
      return result;
    } catch (e, st) {
      emitError(e, st);
      return (false, 0, e.toString());
    }
  }

  Future<bool> createWebhook(String workspaceId, String webhookUrl) async {
    try {
      return await _dataProvider.createWebhook(workspaceId, webhookUrl);
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<bool> deleteWebhook(String webhookId) async {
    try {
      return await _dataProvider.deleteWebhook(webhookId);
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<int> getTaskCount() async {
    try {
      return await _dataProvider.getTaskCount();
    } catch (e, st) {
      emitError(e, st);
      return 0;
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

  void updateCachedTasks(List<ClickUpTask> tasks) {
    _dataProvider.updateCachedTasks(tasks);
    emit(tasks);
  }
}
