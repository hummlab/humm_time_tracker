import 'dart:async';

import '../../data_providers/firebase/time_entry_data_provider.dart';
import '../../models/time/time_entry.dart';
import '../data_repository.dart';

class TimeEntriesQuery {
  const TimeEntriesQuery({this.status});

  final TimeEntryStatus? status;
}

class TimeEntriesRepository extends DataRepository<List<TimeEntry>, TimeEntriesQuery> {
  TimeEntriesRepository(this._dataProvider) : super(const []);

  final TimeEntryDataProvider _dataProvider;
  StreamSubscription<List<TimeEntry>>? _subscription;

  void start({TimeEntryStatus? status}) {
    _subscription?.cancel();
    _subscription = _watchStream(status).listen(emit, onError: emitError);
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    emit(const []);
  }

  @override
  Future<List<TimeEntry>> fetch(TimeEntriesQuery query) async {
    try {
      final entries = await _watchStream(query.status).first;
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

  Stream<List<TimeEntry>> _watchStream(TimeEntryStatus? status) {
    if (status == null) {
      return _dataProvider.watchTimeEntries();
    }
    return _dataProvider.watchTimeEntriesByStatus(status);
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
