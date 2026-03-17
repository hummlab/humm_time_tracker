import 'dart:async';

import '../../data_providers/firebase/tag_data_provider.dart';
import '../../models/projects/tag.dart';
import '../data_repository.dart';

class TagsRepository extends DataRepository<List<Tag>, void> {
  TagsRepository(this._dataProvider) : super(const []);

  final TagDataProvider _dataProvider;
  StreamSubscription<List<Tag>>? _subscription;

  void start() {
    if (_subscription != null) return;
    _subscription = _dataProvider.watchTags().listen(emit, onError: emitError);
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    emit(const []);
  }

  @override
  Future<List<Tag>> fetch(void _) async {
    try {
      final tags = await _dataProvider.watchTags().first;
      emit(tags);
      return tags;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  Future<void> addTag(Tag tag) async {
    await _dataProvider.addTag(tag);
  }

  Future<void> updateTag(Tag tag) async {
    await _dataProvider.updateTag(tag);
  }

  Future<void> deleteTag(String id) async {
    await _dataProvider.deleteTag(id);
  }

  Future<bool> addTagSafe(Tag tag) async {
    try {
      await _dataProvider.addTag(tag);
      return true;
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<bool> updateTagSafe(Tag tag) async {
    try {
      await _dataProvider.updateTag(tag);
      return true;
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<bool> deleteTagSafe(String id) async {
    try {
      await _dataProvider.deleteTag(id);
      return true;
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
