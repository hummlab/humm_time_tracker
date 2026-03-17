import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/integrations/jira_issue.dart';
import '../firebase/firebase_data_provider.dart';

class JiraDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _cacheKey = 'jira_issues_cache';
  static const String _lastSyncKey = 'jira_last_sync';
  static const Duration _cacheMaxAge = Duration(hours: 24);

  List<JiraIssue> _cachedIssues = [];
  DateTime? _lastCacheLoad;

  List<JiraIssue> get cachedIssues => _cachedIssues;

  String _requireOrganizationId() {
    final organizationId = FirebaseDataProvider.currentActiveOrganizationId;
    if (organizationId == null || organizationId.isEmpty) {
      throw StateError('Active organization is not set');
    }
    return organizationId;
  }

  DocumentReference<Map<String, dynamic>> _jiraSettingsDoc() {
    final organizationId = _requireOrganizationId();
    return _firestore.collection('organizations').doc(organizationId).collection('settings').doc('jira');
  }

  String _cacheKeyForOrg(String organizationId) => '${_cacheKey}_$organizationId';

  String _lastSyncKeyForOrg(String organizationId) => '${_lastSyncKey}_$organizationId';

  Future<void> init() async {
    await _loadFromLocalCache();
  }

  Future<void> reloadCache() async {
    await _loadFromLocalCache();
  }

  bool get isCacheStale {
    if (_lastCacheLoad == null) return true;
    return DateTime.now().difference(_lastCacheLoad!) > _cacheMaxAge;
  }

  Future<void> _loadFromLocalCache() async {
    final organizationId = _requireOrganizationId();
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = prefs.getString(_cacheKeyForOrg(organizationId));
    final lastSyncStr = prefs.getString(_lastSyncKeyForOrg(organizationId));

    if (cacheJson != null) {
      final decoded = jsonDecode(cacheJson) as List<Object?>;
      _cachedIssues = decoded.map((json) => JiraIssue.fromMap(json as Map<String, dynamic>)).toList();
    }

    if (lastSyncStr != null) {
      _lastCacheLoad = DateTime.parse(lastSyncStr);
    }
  }

  Future<void> _saveToLocalCache() async {
    final organizationId = _requireOrganizationId();
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = jsonEncode(_cachedIssues.map((i) => i.toMap()).toList());
    await prefs.setString(_cacheKeyForOrg(organizationId), cacheJson);
    await prefs.setString(_lastSyncKeyForOrg(organizationId), DateTime.now().toIso8601String());
    _lastCacheLoad = DateTime.now();
  }

  Future<JiraSettings> getSettings() async {
    final doc = await _jiraSettingsDoc().get();
    if (!doc.exists) {
      return JiraSettings();
    }
    return JiraSettings.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<bool> saveSettings({String? domain, String? email, String? apiToken, List<String>? selectedProjectIds}) async {
    final updateData = <String, dynamic>{};
    if (domain != null) updateData['domain'] = domain;
    if (email != null) updateData['email'] = email;
    if (apiToken != null) updateData['apiToken'] = apiToken;
    if (selectedProjectIds != null) {
      updateData['selectedProjectIds'] = selectedProjectIds;
    }
    updateData['updatedAt'] = FieldValue.serverTimestamp();

    await _jiraSettingsDoc().set(updateData, SetOptions(merge: true));
    return true;
  }

  Future<bool> testConnection({required String domain, required String email, required String apiToken}) async {
    await _getJson(domain, '/rest/api/3/myself', email: email, apiToken: apiToken);
    return true;
  }

  Future<List<JiraProject>> loadProjects() async {
    final settings = await getSettings();
    final domain = settings.domain;
    final email = settings.email;
    final apiToken = await _getApiToken();

    if (domain == null || domain.isEmpty || email == null || email.isEmpty || apiToken == null) {
      return [];
    }

    final data = await _getJson(
      domain,
      '/rest/api/3/project/search',
      email: email,
      apiToken: apiToken,
      query: {'maxResults': '1000'},
    );

    final values = data['values'] as List<Object?>? ?? [];
    return values.map((p) => JiraProject.fromApi(p as Map<String, dynamic>)).toList();
  }

  Future<List<JiraProject>> getProjects() async {
    return loadProjects();
  }

  Future<(bool, int, String?)> syncIssues({List<String>? selectedProjectIds}) async {
    final settings = await getSettings();
    final domain = settings.domain;
    final email = settings.email;
    final apiToken = await _getApiToken();

    if (domain == null || domain.isEmpty || email == null || email.isEmpty || apiToken == null) {
      return (false, 0, 'Missing Jira credentials');
    }

    final projectIds = selectedProjectIds ?? settings.selectedProjectIds;
    if (projectIds.isEmpty) {
      return (false, 0, 'No Jira projects selected');
    }

    final projects = await loadProjects();
    final selectedProjects = projects.where((p) => projectIds.contains(p.id)).toList();

    if (selectedProjects.isEmpty) {
      return (false, 0, 'Selected projects not found');
    }

    final issues = <JiraIssue>[];

    for (final project in selectedProjects) {
      final projectIssues = await _fetchIssuesForProject(
        domain: domain,
        email: email,
        apiToken: apiToken,
        projectKey: project.key,
      );
      issues.addAll(projectIssues);
    }

    _cachedIssues = issues;
    await _saveToLocalCache();

    await _jiraSettingsDoc().set({
      'lastSyncAt': FieldValue.serverTimestamp(),
      'lastSyncIssueCount': issues.length,
    }, SetOptions(merge: true));

    return (true, issues.length, null);
  }

  List<JiraIssue> searchIssues(String query, {int limit = 4}) {
    if (query.isEmpty || query.length < 2) return [];
    final queryLower = query.toLowerCase();
    final results = <JiraIssue>[];

    for (final issue in _cachedIssues) {
      if (issue.key.toLowerCase() == queryLower) {
        results.add(issue);
        if (results.length >= limit) return results;
      }
    }

    for (final issue in _cachedIssues) {
      if (issue.key.toLowerCase().contains(queryLower) && !results.contains(issue)) {
        results.add(issue);
        if (results.length >= limit) return results;
      }
    }

    for (final issue in _cachedIssues) {
      if (issue.summary.toLowerCase().contains(queryLower) && !results.contains(issue)) {
        results.add(issue);
        if (results.length >= limit) return results;
      }
    }

    return results;
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final organizationId = _requireOrganizationId();
    await prefs.remove(_cacheKeyForOrg(organizationId));
    await prefs.remove(_lastSyncKeyForOrg(organizationId));
    _cachedIssues = [];
    _lastCacheLoad = null;
  }

  Future<List<JiraIssue>> _fetchIssuesForProject({
    required String domain,
    required String email,
    required String apiToken,
    required String projectKey,
  }) async {
    final issues = <JiraIssue>[];
    const pageSize = 100;
    var startAt = 0;
    var total = 0;

    do {
      final data = await _getJson(
        domain,
        '/rest/api/3/search',
        email: email,
        apiToken: apiToken,
        query: {
          'jql': 'project=$projectKey ORDER BY updated DESC',
          'startAt': startAt.toString(),
          'maxResults': pageSize.toString(),
          'fields': 'summary,status,priority,assignee,project,updated',
        },
      );

      final values = data['issues'] as List<Object?>? ?? [];
      total = data['total'] as int? ?? 0;

      issues.addAll(values.map((issue) => JiraIssue.fromApi(issue as Map<String, dynamic>, domain: domain)));

      startAt += pageSize;
    } while (startAt < total);

    return issues;
  }

  Future<Map<String, dynamic>> _getJson(
    String domain,
    String path, {
    required String email,
    required String apiToken,
    Map<String, String>? query,
  }) async {
    final uri = Uri.https('$domain.atlassian.net', path, query);
    final response = await http.get(
      uri,
      headers: {'Authorization': _buildAuthHeader(email, apiToken), 'Accept': 'application/json'},
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Jira API error ${response.statusCode}: ${response.body}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  String _buildAuthHeader(String email, String apiToken) {
    final credentials = base64Encode(utf8.encode('$email:$apiToken'));
    return 'Basic $credentials';
  }

  Future<String?> _getApiToken() async {
    final doc = await _jiraSettingsDoc().get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    final token = data['apiToken'] as String?;
    if (token == null || token.isEmpty) return null;
    return token;
  }
}
