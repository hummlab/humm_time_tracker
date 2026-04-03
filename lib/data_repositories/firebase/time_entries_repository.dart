import 'dart:async';

import '../../data_providers/firebase/time_entry_data_provider.dart';
import '../../models/time/time_entry.dart';
import '../data_repository.dart';

class TimeEntriesQuery {
  const TimeEntriesQuery({this.status, this.start, this.end});

  final TimeEntryStatus? status;
  final DateTime? start;
  final DateTime? end;
}

class TimeEntriesRepository
    extends DataRepository<List<TimeEntry>, TimeEntriesQuery> {
  TimeEntriesRepository(this._dataProvider) : super(const []);

  final TimeEntryDataProvider _dataProvider;
  StreamSubscription<List<TimeEntry>>? _subscription;

  void start({TimeEntriesQuery query = const TimeEntriesQuery()}) {
    _subscription?.cancel();
    _subscription = _watchStream(query).listen(emit, onError: emitError);
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    emit(const []);
  }

  @override
  Future<List<TimeEntry>> fetch(TimeEntriesQuery query) async {
    try {
      final entries = await _watchStream(query).first;
      emit(entries);
      return entries;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    await _dataProvider.addTimeEntry(entry);
  }

  Future<void> updateTimeEntry(TimeEntry entry) async {
    await _dataProvider.updateTimeEntry(entry);
  }

  Future<void> deleteTimeEntry(String id) async {
    await _dataProvider.deleteTimeEntry(id);
  }

  Future<List<TimeEntry>> fetchByDateRange({
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      return await _dataProvider.fetchTimeEntriesByDateRange(
        start: start,
        end: end,
      );
    } catch (e, st) {
      emitError(e, st);
      return const [];
    }
  }

  Future<void> updateTimeEntriesStatus(
    List<String> entryIds,
    TimeEntryStatus status, {
    String? approvedByUserId,
    String? rejectionReason,
  }) async {
    await _dataProvider.updateTimeEntriesStatus(
      entryIds,
      status,
      approvedByUserId: approvedByUserId,
      rejectionReason: rejectionReason,
    );
  }

  Future<TimeEntriesResult> updateTimeEntriesStatusSafe(
    List<String> entryIds,
    TimeEntryStatus status, {
    String? approvedByUserId,
    String? rejectionReason,
  }) async {
    try {
      await updateTimeEntriesStatus(
        entryIds,
        status,
        approvedByUserId: approvedByUserId,
        rejectionReason: rejectionReason,
      );
      return const TimeEntriesResult.success();
    } catch (e, st) {
      emitError(e, st);
      return TimeEntriesResult.failure(e);
    }
  }

  Stream<List<TimeEntry>> _watchStream(TimeEntriesQuery query) {
    final hasRange = query.start != null && query.end != null;
    if (hasRange) {
      if (query.status != null) {
        return _dataProvider.watchTimeEntriesByStatusAndDateRange(
          query.status!,
          start: query.start!,
          end: query.end!,
        );
      }
      return _dataProvider.watchTimeEntriesByDateRange(
        start: query.start!,
        end: query.end!,
      );
    }

    if (query.status == null) {
      return _dataProvider.watchTimeEntries();
    }
    return _dataProvider.watchTimeEntriesByStatus(query.status!);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

class TimeEntriesResult {
  const TimeEntriesResult.success() : isSuccess = true, error = null;
  const TimeEntriesResult.failure(this.error) : isSuccess = false;

  final bool isSuccess;
  final Object? error;
}
