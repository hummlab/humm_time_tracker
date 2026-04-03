part of 'time_data_provider.dart';

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

extension DataProviderCore on TimeDataProvider {
  static const int _historyWindowDays = 365;
  static const int _futureWindowDays = 30;

  void init() {
    final userId = _firebaseService.currentUserId;
    if (userId == null) {
      return;
    }
    final organizationId = _firebaseService.activeOrganizationId;
    if (organizationId == null || organizationId.isEmpty) {
      clear();
      return;
    }

    _currentUserId = userId;
    _restoreActiveTimerFromStorage();

    _cancelSubscriptions();

    _clientsRepository?.start();
    _projectsRepository?.start();
    _teamMembersRepository?.start();
    _tagsRepository?.start();
    _ensureTimeEntriesWindow(_selectedDate, force: true);

    _initClickUp();
    _initJira();
  }

  Future<void> _initClickUp() async {
    await _clickUpRepository.init();
    _clickUpTasks = _clickUpRepository.cachedTasks;
    _clickUpInitialized = true;

    if (_clickUpRepository.isCacheStale) {
      await refreshClickUpTasks();
    }

    _clickUpTasksSub = _firebaseService.getClickUpTasks().listen((tasks) {
      _clickUpTasks = tasks;
      _clickUpRepository.updateCachedTasks(tasks);
      notifyListeners();
    }, onError: (e) {});

    notifyListeners();
  }

  Future<void> _initJira() async {
    await _jiraRepository.init();
    _jiraIssues = _jiraRepository.cachedIssues;
    _jiraInitialized = true;
    notifyListeners();
  }

  Future<void> refreshClickUpTasks({bool forceFullLoad = false}) async {
    _clickUpTasks = await _clickUpRepository.loadTasksFromFirestore(
      forceFullLoad: forceFullLoad,
    );
    notifyListeners();
  }

  Future<void> refreshJiraIssues() async {
    await _jiraRepository.loadIssuesFromCache();
    _jiraIssues = _jiraRepository.cachedIssues;
    notifyListeners();
  }

  Future<List<ClickUpTask>> searchClickUpTasks(
    String query, {
    int limit = 4,
  }) async {
    return _clickUpRepository.searchTasks(query, limit: limit);
  }

  Future<List<JiraIssue>> searchJiraIssues(
    String query, {
    int limit = 4,
  }) async {
    return _jiraRepository.searchIssues(query, limit: limit);
  }

  void _cancelSubscriptions() {
    _clientsRepository?.stop();
    _projectsRepository?.stop();
    _teamMembersRepository?.stop();
    _tagsRepository?.stop();
    _timeEntriesRepository?.stop();
    _clickUpTasksSub?.cancel();
  }

  void clear() {
    _cancelSubscriptions();
    _clickUpTasks = [];
    _clickUpInitialized = false;
    _jiraIssues = [];
    _jiraInitialized = false;
    _currentUserId = null;
    _activeTimer = null;
    _lastUsedDurations = [];
    _lastUsedDescriptions = [];
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _entriesWindowStart = null;
    _entriesWindowEnd = null;
    notifyListeners();
    _clearActiveTimerFromStorage();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = DateTime(date.year, date.month, date.day);
    _ensureTimeEntriesWindow(_selectedDate);
    notifyListeners();
  }

  void _ensureTimeEntriesWindow(DateTime anchorDate, {bool force = false}) {
    final start = DateTime(
      anchorDate.year,
      anchorDate.month,
      anchorDate.day,
    ).subtract(const Duration(days: _historyWindowDays));
    final end = DateTime(
      anchorDate.year,
      anchorDate.month,
      anchorDate.day,
    ).add(const Duration(days: _futureWindowDays));

    if (!force &&
        _entriesWindowStart != null &&
        _entriesWindowEnd != null &&
        !anchorDate.isBefore(_entriesWindowStart!) &&
        !anchorDate.isAfter(_entriesWindowEnd!)) {
      return;
    }

    _entriesWindowStart = start;
    _entriesWindowEnd = end;
    _timeEntriesRepository?.start(
      query: TimeEntriesQuery(
        start: _entriesWindowStart,
        end: _entriesWindowEnd,
      ),
    );
  }

  void addToLastUsedDurations(int duration) {
    _lastUsedDurations.remove(duration);
    _lastUsedDurations.insert(0, duration);
    if (_lastUsedDurations.length > 4) {
      _lastUsedDurations = _lastUsedDurations.take(4).toList();
    }
    notifyListeners();
  }

  void addToLastUsedDescriptions(String description) {
    if (description.trim().isEmpty) return;
    _lastUsedDescriptions.removeWhere(
      (d) => d.toLowerCase() == description.toLowerCase(),
    );
    _lastUsedDescriptions.insert(0, description);
    if (_lastUsedDescriptions.length > 4) {
      _lastUsedDescriptions = _lastUsedDescriptions.take(4).toList();
    }
    notifyListeners();
  }

  // Team member de-duplication moved to TeamMembersRepository.
}
