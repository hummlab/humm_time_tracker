part of 'time_data_provider.dart';

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

extension DataProviderTimer on TimeDataProvider {
  void startTimer({
    required String description,
    String? projectId,
    List<String> tagIds = const [],
    int? targetMinutes,
  }) {
    _activeTimer = ActiveTimer(
      description: description,
      projectId: projectId,
      tagIds: tagIds,
      startTime: DateTime.now(),
      targetMinutes: targetMinutes,
    );
    notifyListeners();
    _saveActiveTimerToStorage();
  }

  Future<void> stopTimer() async {
    if (_activeTimer == null) return;

    final repository = _timeEntriesRepository;
    final userId = currentUserId;
    if (repository == null || userId == null) {
      return;
    }

    final elapsed = DateTime.now().difference(_activeTimer!.startTime);
    int minutes = elapsed.inMinutes;
    if (minutes < 15) {
      minutes = 15;
    } else {
      minutes = ((minutes + 14) ~/ 15) * 15;
    }

    final entry = TimeEntry(
      id: '',
      description: _activeTimer!.description,
      durationMinutes: minutes,
      date: DateTime.now(),
      projectId: _activeTimer!.projectId,
      tagIds: _activeTimer!.tagIds,
      createdByUserId: userId,
      createdAt: DateTime.now(),
      startTime: _activeTimer!.startTime,
    );
    await repository.addTimeEntry(entry);
    addToLastUsedDurations(minutes);
    addToLastUsedDescriptions(_activeTimer!.description);

    _activeTimer = null;
    notifyListeners();
    _clearActiveTimerFromStorage();
  }

  void cancelTimer() {
    _activeTimer = null;
    notifyListeners();
    _clearActiveTimerFromStorage();
  }

  int getTimerElapsedMinutes() {
    if (_activeTimer == null) return 0;
    return DateTime.now().difference(_activeTimer!.startTime).inMinutes;
  }

  String getTimerElapsedFormatted() {
    if (_activeTimer == null) return '0:00';
    final elapsed = DateTime.now().difference(_activeTimer!.startTime);
    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes % 60;
    final seconds = elapsed.inSeconds % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String _activeTimerPrefsKeyForUser(String userId) => '${TimeDataProvider._activeTimerPrefsKeyPrefix}$userId';

  Future<void> _saveActiveTimerToStorage() async {
    final timer = _activeTimer;
    final userId = currentUserId;
    if (timer == null || userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final key = _activeTimerPrefsKeyForUser(userId);
    final data = jsonEncode(timer.toJson());
    await prefs.setString(key, data);
  }

  Future<void> _clearActiveTimerFromStorage() async {
    final userId = currentUserId;
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final key = _activeTimerPrefsKeyForUser(userId);
    await prefs.remove(key);
  }

  Future<void> _restoreActiveTimerFromStorage() async {
    final userId = currentUserId;
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final key = _activeTimerPrefsKeyForUser(userId);
    final jsonStr = prefs.getString(key);
    if (jsonStr == null) return;

    final Map<String, dynamic> data = jsonDecode(jsonStr) as Map<String, dynamic>;
    final restored = ActiveTimer.fromJson(data);
    if (restored.description.isEmpty) return;
    _activeTimer = restored;
    notifyListeners();
  }
}
