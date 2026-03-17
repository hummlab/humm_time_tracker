import 'dart:async';

import '../../data_providers/firebase/clickup_task_data_provider.dart';
import '../../models/integrations/clickup_task.dart';
import '../data_repository.dart';

class ClickUpTasksRepository extends DataRepository<List<ClickUpTask>, void> {
  ClickUpTasksRepository(this._dataProvider) : super(const []);

  final ClickUpTaskDataProvider _dataProvider;
  StreamSubscription<List<ClickUpTask>>? _subscription;

  void start() {
    _subscription ??= _dataProvider.watchClickUpTasks().listen(emit, onError: emitError);
  }

  @override
  Future<List<ClickUpTask>> fetch(void _) async {
    try {
      final tasks = await _dataProvider.watchClickUpTasks().first;
      emit(tasks);
      return tasks;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
