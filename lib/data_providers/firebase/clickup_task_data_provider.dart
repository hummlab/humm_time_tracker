import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/integrations/clickup_task.dart';
import 'firebase_core_data_provider.dart';

class ClickUpTaskDataProvider {
  ClickUpTaskDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  CollectionReference<Map<String, dynamic>> get _clickUpTasksCollection =>
      _core.organizationCollection('clickup_tasks');

  Stream<List<ClickUpTask>> watchClickUpTasks() {
    return _clickUpTasksCollection.orderBy('syncedAt', descending: true).limit(1000).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ClickUpTask.fromFirestore(doc)).toList();
    });
  }
}
