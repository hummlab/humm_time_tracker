import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/time/time_entry.dart';
import 'firebase_core_data_provider.dart';

class TimeEntryDataProvider {
  TimeEntryDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  CollectionReference<Map<String, dynamic>> get _timeEntriesCollection => _core.organizationCollection('timeEntries');

  Stream<List<TimeEntry>> watchTimeEntries() {
    return _timeEntriesCollection.snapshots().map((snapshot) {
      final entries = snapshot.docs.map((doc) => TimeEntry.fromFirestore(doc)).toList();
      entries.sort((a, b) => b.date.compareTo(a.date));
      return entries;
    });
  }

  Future<DocumentReference<Map<String, dynamic>>> addTimeEntry(TimeEntry entry) async {
    return _timeEntriesCollection.add(entry.toFirestore());
  }

  Future<void> updateTimeEntry(TimeEntry entry) async {
    await _timeEntriesCollection.doc(entry.id).update(entry.toFirestore());
  }

  Future<void> deleteTimeEntry(String id) async {
    await _timeEntriesCollection.doc(id).delete();
  }

  Future<void> updateTimeEntriesStatus(
    List<String> entryIds,
    TimeEntryStatus status, {
    String? approvedByUserId,
    String? rejectionReason,
  }) async {
    final batch = _core.firestore.batch();
    final now = DateTime.now();

    for (final entryId in entryIds) {
      final ref = _timeEntriesCollection.doc(entryId);
      final updateData = <String, dynamic>{'status': status.value};

      if (status == TimeEntryStatus.approved || status == TimeEntryStatus.rejected) {
        updateData['approvedByUserId'] = approvedByUserId;
        updateData['approvedAt'] = Timestamp.fromDate(now);
      }

      if (status == TimeEntryStatus.rejected && rejectionReason != null) {
        updateData['rejectionReason'] = rejectionReason;
      }

      batch.update(ref, updateData);
    }

    await batch.commit();
  }

  Stream<List<TimeEntry>> watchTimeEntriesByStatus(TimeEntryStatus status) {
    return _timeEntriesCollection.where('status', isEqualTo: status.value).snapshots().map((snapshot) {
      final entries = snapshot.docs.map((doc) => TimeEntry.fromFirestore(doc)).toList();
      entries.sort((a, b) => b.date.compareTo(a.date));
      return entries;
    });
  }

  Stream<List<TimeEntry>> watchPendingTimeEntries() {
    return watchTimeEntriesByStatus(TimeEntryStatus.pending);
  }
}
