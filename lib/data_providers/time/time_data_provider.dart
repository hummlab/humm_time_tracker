import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_repositories/firebase/clients_repository.dart';
import '../../data_repositories/firebase/projects_repository.dart';
import '../../data_repositories/firebase/tags_repository.dart';
import '../../data_repositories/firebase/team_members_repository.dart';
import '../../data_repositories/firebase/time_entries_repository.dart';
import '../../data_repositories/integrations/clickup_repository.dart';
import '../../data_repositories/integrations/jira_repository.dart';
import '../../data_repositories/workspace_repository.dart';
import '../../models/integrations/clickup_task.dart';
import '../../models/integrations/jira_issue.dart';
import '../../models/org/team_member.dart';
import '../../models/projects/project.dart';
import '../../models/projects/tag.dart';
import '../../models/time/active_timer.dart';
import '../../models/time/time_entry.dart';
import '../firebase/firebase_data_provider.dart';
import '../integrations/clickup_data_provider.dart';
import '../integrations/jira_data_provider.dart';

part 'time_data_provider_core.dart';
part 'time_data_provider_timer.dart';

class TimeDataProvider extends ChangeNotifier {
  final FirebaseDataProvider _firebaseService = FirebaseDataProvider();
  final ClickUpRepository _clickUpRepository = ClickUpRepository(ClickUpDataProvider());
  final JiraRepository _jiraRepository = JiraRepository(JiraDataProvider());

  ClientsRepository? _clientsRepository;
  ProjectsRepository? _projectsRepository;
  TeamMembersRepository? _teamMembersRepository;
  TagsRepository? _tagsRepository;
  TimeEntriesRepository? _timeEntriesRepository;
  WorkspaceRepository? _workspaceRepository;
  VoidCallback? _workspaceRepositoryListener;

  DateTime _selectedDate = DateTime.now();
  List<int> _lastUsedDurations = [];
  List<String> _lastUsedDescriptions = [];

  // Timer state
  ActiveTimer? _activeTimer;

  // ClickUp
  List<ClickUpTask> _clickUpTasks = [];
  bool _clickUpInitialized = false;

  // Jira
  List<JiraIssue> _jiraIssues = [];
  bool _jiraInitialized = false;

  String? _currentUserId;
  static const String _activeTimerPrefsKeyPrefix = 'active_timer_';

  StreamSubscription? _clickUpTasksSub;

  DateTime get selectedDate => _selectedDate;
  List<int> get lastUsedDurations => _lastUsedDurations;
  List<String> get lastUsedDescriptions => _lastUsedDescriptions;
  ActiveTimer? get activeTimer => _activeTimer;
  bool get hasActiveTimer => _activeTimer != null;

  List<Project> get projects => _workspaceRepository?.projects ?? const [];
  List<Tag> get tags => _workspaceRepository?.tags ?? const [];
  List<TimeEntry> get timeEntries => _workspaceRepository?.timeEntries ?? const [];

  // ClickUp getters
  List<ClickUpTask> get clickUpTasks => _clickUpTasks;
  bool get clickUpInitialized => _clickUpInitialized;
  ClickUpRepository get clickUpRepository => _clickUpRepository;

  // Jira getters
  List<JiraIssue> get jiraIssues => _jiraIssues;
  bool get jiraInitialized => _jiraInitialized;
  JiraRepository get jiraRepository => _jiraRepository;

  /// The actual Firebase UID of the current user
  String? get currentUserId => _currentUserId ?? _firebaseService.currentUserId;

  void setRepositories({
    required ClientsRepository clientsRepository,
    required ProjectsRepository projectsRepository,
    required TeamMembersRepository teamMembersRepository,
    required TagsRepository tagsRepository,
    required TimeEntriesRepository timeEntriesRepository,
    required WorkspaceRepository workspaceRepository,
  }) {
    if (_workspaceRepositoryListener != null && _workspaceRepository != null) {
      _workspaceRepository!.removeListener(_workspaceRepositoryListener!);
    }

    _clientsRepository = clientsRepository;
    _projectsRepository = projectsRepository;
    _teamMembersRepository = teamMembersRepository;
    _tagsRepository = tagsRepository;
    _timeEntriesRepository = timeEntriesRepository;
    _workspaceRepository = workspaceRepository;

    _workspaceRepositoryListener = () {
      notifyListeners();
    };
    _workspaceRepository!.addListener(_workspaceRepositoryListener!);
  }

  List<TimeEntry> getEntriesForDate(DateTime date) {
    return _workspaceRepository?.getEntriesForDate(date) ?? const [];
  }

  List<TimeEntry> getEntriesForWeek(DateTime weekStart) {
    return _workspaceRepository?.getEntriesForWeek(weekStart) ?? const [];
  }

  Project? getProjectById(String? id) {
    if (id == null) return null;
    return _workspaceRepository?.getProjectById(id);
  }

  Project? getProjectByClickUpListId(String listId) {
    return _workspaceRepository?.getProjectByClickUpListId(listId);
  }

  Tag? getTagById(String id) {
    return _workspaceRepository?.getTagById(id);
  }

  TeamMember? getCurrentUserTeamMember() {
    return _workspaceRepository?.getCurrentUserTeamMember(currentUserId);
  }

  List<Project> getProjectsForUser({required bool hasManagerAccess, String? teamMemberId}) {
    return _workspaceRepository?.getProjectsForUser(hasManagerAccess: hasManagerAccess, teamMemberId: teamMemberId) ??
        const [];
  }

  Future<void> addTimeEntry(
    String description,
    int durationMinutes,
    DateTime date, {
    String? projectId,
    List<String>? tagIds,
    String? clickUpTaskId,
    String? jiraIssueKey,
    DateTime? startTime,
  }) async {
    final repository = _timeEntriesRepository;
    final userId = currentUserId;
    if (repository == null || userId == null) return;

    final entry = TimeEntry(
      id: '',
      description: description,
      durationMinutes: durationMinutes,
      date: date,
      projectId: projectId,
      tagIds: tagIds ?? const [],
      createdByUserId: userId,
      createdAt: DateTime.now(),
      clickUpTaskId: clickUpTaskId,
      jiraIssueKey: jiraIssueKey,
      startTime: startTime,
    );

    await repository.addTimeEntry(entry);
  }

  Future<void> updateTimeEntry(TimeEntry entry) async {
    final repository = _timeEntriesRepository;
    if (repository == null) return;
    await repository.updateTimeEntry(entry);
  }

  Future<void> deleteTimeEntry(String id) async {
    final repository = _timeEntriesRepository;
    if (repository == null) return;
    await repository.deleteTimeEntry(id);
  }

  @override
  void dispose() {
    if (_workspaceRepositoryListener != null && _workspaceRepository != null) {
      _workspaceRepository!.removeListener(_workspaceRepositoryListener!);
    }
    _cancelSubscriptions();
    super.dispose();
  }
}
