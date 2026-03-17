import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/integrations/clickup_task.dart';
import '../firebase/firebase_data_provider.dart';

class ClickUpDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(region: 'europe-west1');

  static const String _cacheKey = 'clickup_tasks_cache';
  static const String _lastSyncKey = 'clickup_last_sync';
  static const Duration _cacheMaxAge = Duration(hours: 24);

  /// Cached tasks in memory
  List<ClickUpTask> _cachedTasks = [];
  DateTime? _lastCacheLoad;

  /// Get cached tasks
  List<ClickUpTask> get cachedTasks => _cachedTasks;

  String _requireOrganizationId() {
    final organizationId = FirebaseDataProvider.currentActiveOrganizationId;
    if (organizationId == null || organizationId.isEmpty) {
      throw StateError('Active organization is not set');
    }
    return organizationId;
  }

  String _cacheKeyForOrg(String organizationId) => '${_cacheKey}_$organizationId';

  String _lastSyncKeyForOrg(String organizationId) => '${_lastSyncKey}_$organizationId';

  /// Initialize service and load cache
  Future<void> init() async {
    await _loadFromLocalCache();
  }

  /// Load tasks from local storage cache
  Future<void> _loadFromLocalCache() async {
    final organizationId = _requireOrganizationId();
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = prefs.getString(_cacheKeyForOrg(organizationId));
    final lastSyncStr = prefs.getString(_lastSyncKeyForOrg(organizationId));

    if (cacheJson != null) {
      final List<Object?> decoded = jsonDecode(cacheJson) as List<Object?>;
      _cachedTasks = decoded.map((json) => ClickUpTask.fromMap(json as Map<String, dynamic>)).toList();
    }

    if (lastSyncStr != null) {
      _lastCacheLoad = DateTime.parse(lastSyncStr);
    }
  }

  /// Save tasks to local storage cache
  Future<void> _saveToLocalCache() async {
    final organizationId = _requireOrganizationId();
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = jsonEncode(_cachedTasks.map((t) => t.toMap()).toList());
    await prefs.setString(_cacheKeyForOrg(organizationId), cacheJson);
    await prefs.setString(_lastSyncKeyForOrg(organizationId), DateTime.now().toIso8601String());
    _lastCacheLoad = DateTime.now();
  }

  /// Check if cache is stale
  bool get isCacheStale {
    if (_lastCacheLoad == null) return true;
    return DateTime.now().difference(_lastCacheLoad!) > _cacheMaxAge;
  }

  /// Load tasks from Firestore (with optional incremental update)
  Future<List<ClickUpTask>> loadTasksFromFirestore({bool forceFullLoad = false}) async {
    final organizationId = _requireOrganizationId();
    Query query = _firestore.collection('organizations').doc(organizationId).collection('clickup_tasks');

    // If we have cached tasks and not forcing full load, get only updated ones
    if (!forceFullLoad && _cachedTasks.isNotEmpty && _lastCacheLoad != null) {
      query = query.where('syncedAt', isGreaterThan: Timestamp.fromDate(_lastCacheLoad!));
    }

    query = query.orderBy('syncedAt', descending: true).limit(1000);

    final snapshot = await query.get();
    final newTasks = snapshot.docs.map((doc) => ClickUpTask.fromFirestore(doc)).toList();

    if (forceFullLoad || _cachedTasks.isEmpty) {
      // Full load
      _cachedTasks = newTasks;
    } else {
      // Merge new/updated tasks
      final taskMap = {for (var t in _cachedTasks) t.id: t};
      for (var task in newTasks) {
        taskMap[task.id] = task;
      }
      _cachedTasks = taskMap.values.toList();
    }

    // Sort by dateUpdated
    _cachedTasks.sort((a, b) {
      final aDate = a.dateUpdated ?? a.dateCreated ?? DateTime(1970);
      final bDate = b.dateUpdated ?? b.dateCreated ?? DateTime(1970);
      return bDate.compareTo(aDate);
    });

    await _saveToLocalCache();

    return _cachedTasks;
  }

  /// Search tasks locally
  List<ClickUpTask> searchTasksLocal(String query, {int limit = 4}) {
    if (query.isEmpty || query.length < 2) return [];

    final queryLower = query.toLowerCase();
    final results = <ClickUpTask>[];

    // First, search by custom ID (exact match preferred)
    for (var task in _cachedTasks) {
      if (task.customId != null && task.customId!.toLowerCase() == queryLower) {
        results.add(task);
        if (results.length >= limit) return results;
      }
    }

    // Then search by custom ID contains
    for (var task in _cachedTasks) {
      if (task.customId != null && task.customId!.toLowerCase().contains(queryLower) && !results.contains(task)) {
        results.add(task);
        if (results.length >= limit) return results;
      }
    }

    // Then search by name contains
    for (var task in _cachedTasks) {
      if (task.name.toLowerCase().contains(queryLower) && !results.contains(task)) {
        results.add(task);
        if (results.length >= limit) return results;
      }
    }

    return results;
  }

  /// Search tasks - local only for instant results
  /// Remote search is disabled for better UX - tasks are cached locally
  List<ClickUpTask> searchTasks(String query, {int limit = 4}) {
    return searchTasksLocal(query, limit: limit);
  }

  // ============ Cloud Functions Wrappers ============

  /// Get ClickUp settings
  Future<ClickUpSettings> getSettings() async {
    final callable = _functions.httpsCallable('getClickUpSettings');
    final result = await callable.call({'organizationId': _requireOrganizationId()});

    if (result.data['success'] == true) {
      return ClickUpSettings.fromMap(result.data['settings'] as Map<String, dynamic>);
    }
    return ClickUpSettings();
  }

  /// Save ClickUp API token
  Future<bool> saveApiToken(String apiToken) async {
    final callable = _functions.httpsCallable('saveClickUpSettings');
    final result = await callable.call({'organizationId': _requireOrganizationId(), 'apiToken': apiToken});
    return result.data['success'] == true;
  }

  /// Save selected list IDs
  Future<bool> saveSelectedLists(List<String> listIds) async {
    final callable = _functions.httpsCallable('saveClickUpSettings');
    final result = await callable.call({'organizationId': _requireOrganizationId(), 'selectedListIds': listIds});
    return result.data['success'] == true;
  }

  /// Save workspace ID
  Future<bool> saveWorkspaceId(String workspaceId) async {
    final callable = _functions.httpsCallable('saveClickUpSettings');
    final result = await callable.call({'organizationId': _requireOrganizationId(), 'workspaceId': workspaceId});
    return result.data['success'] == true;
  }

  /// Get workspaces
  Future<List<ClickUpWorkspace>> getWorkspaces() async {
    final callable = _functions.httpsCallable('getClickUpWorkspaces');
    final result = await callable.call({'organizationId': _requireOrganizationId()});

    if (result.data['success'] == true) {
      final List<Object?> workspaces = result.data['workspaces'] as List<Object?>? ?? [];
      return workspaces.map((w) => ClickUpWorkspace.fromMap(w as Map<String, dynamic>)).toList();
    }
    return [];
  }

  /// Get spaces for workspace
  Future<List<ClickUpSpace>> getSpaces(String workspaceId) async {
    final callable = _functions.httpsCallable('getClickUpSpaces');
    final result = await callable.call({'organizationId': _requireOrganizationId(), 'workspaceId': workspaceId});

    if (result.data['success'] == true) {
      final List<Object?> spaces = result.data['spaces'] as List<Object?>? ?? [];
      return spaces.map((s) => ClickUpSpace.fromMap(s as Map<String, dynamic>)).toList();
    }
    return [];
  }

  /// Get folders for space
  Future<List<ClickUpFolder>> getFolders(String spaceId) async {
    final callable = _functions.httpsCallable('getClickUpFolders');
    final result = await callable.call({'organizationId': _requireOrganizationId(), 'spaceId': spaceId});

    if (result.data['success'] == true) {
      final List<Object?> folders = result.data['folders'] as List<Object?>? ?? [];
      return folders.map((f) => ClickUpFolder.fromMap(f as Map<String, dynamic>)).toList();
    }
    return [];
  }

  /// Get folderless lists for space
  Future<List<ClickUpList>> getFolderlessLists(String spaceId) async {
    final callable = _functions.httpsCallable('getClickUpLists');
    final result = await callable.call({'organizationId': _requireOrganizationId(), 'spaceId': spaceId});

    if (result.data['success'] == true) {
      final List<Object?> lists = result.data['lists'] as List<Object?>? ?? [];
      return lists.map((l) => ClickUpList.fromMap(l as Map<String, dynamic>)).toList();
    }
    return [];
  }

  /// Get lists for folder
  Future<List<ClickUpList>> getFolderLists(String folderId) async {
    final callable = _functions.httpsCallable('getClickUpFolderLists');
    final result = await callable.call({'organizationId': _requireOrganizationId(), 'folderId': folderId});

    if (result.data['success'] == true) {
      final List<Object?> lists = result.data['lists'] as List<Object?>? ?? [];
      return lists.map((l) => ClickUpList.fromMap(l as Map<String, dynamic>)).toList();
    }
    return [];
  }

  /// Sync all tasks from ClickUp
  Future<(bool, int, String?)> syncAllTasks() async {
    final callable = _functions.httpsCallable(
      'syncClickUpTasks',
      options: HttpsCallableOptions(timeout: const Duration(minutes: 10)),
    );
    final result = await callable.call({'organizationId': _requireOrganizationId()});

    if (result.data['success'] == true) {
      final taskCount = result.data['taskCount'] as int;
      // Reload from Firestore after sync
      await loadTasksFromFirestore(forceFullLoad: true);
      return (true, taskCount, null);
    }
    return (false, 0, result.data['error'] as String?);
  }

  /// Sync tasks incrementally
  Future<(bool, int, String?)> syncTasksIncremental() async {
    final callable = _functions.httpsCallable(
      'syncClickUpTasksIncremental',
      options: HttpsCallableOptions(timeout: const Duration(minutes: 5)),
    );
    final result = await callable.call({'organizationId': _requireOrganizationId()});

    if (result.data['success'] == true) {
      final taskCount = result.data['taskCount'] as int;
      // Reload from Firestore after sync
      await loadTasksFromFirestore();
      return (true, taskCount, null);
    }
    return (false, 0, result.data['error'] as String?);
  }

  /// Create webhook
  Future<bool> createWebhook(String workspaceId, String webhookUrl) async {
    final callable = _functions.httpsCallable('createClickUpWebhook');
    final result = await callable.call({
      'organizationId': _requireOrganizationId(),
      'workspaceId': workspaceId,
      'webhookUrl': webhookUrl,
    });
    return result.data['success'] == true;
  }

  /// Delete webhook
  Future<bool> deleteWebhook(String webhookId) async {
    final callable = _functions.httpsCallable('deleteClickUpWebhook');
    final result = await callable.call({'organizationId': _requireOrganizationId(), 'webhookId': webhookId});
    return result.data['success'] == true;
  }

  /// Get task count
  Future<int> getTaskCount() async {
    final callable = _functions.httpsCallable('getClickUpTaskCount');
    final result = await callable.call({'organizationId': _requireOrganizationId()});
    if (result.data['success'] == true) {
      return result.data['count'] as int;
    }
    return 0;
  }

  /// Clear local cache
  Future<void> clearCache() async {
    final organizationId = _requireOrganizationId();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKeyForOrg(organizationId));
    await prefs.remove(_lastSyncKeyForOrg(organizationId));
    _cachedTasks = [];
    _lastCacheLoad = null;
  }

  /// Update cached tasks from Firestore stream (real-time updates)
  void updateCachedTasks(List<ClickUpTask> tasks) {
    _cachedTasks = tasks;
    _lastCacheLoad = DateTime.now();
    // Save to local storage in background
    _saveToLocalCache();
  }
}
