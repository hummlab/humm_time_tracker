import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/projects/tag.dart';
import 'firebase_core_data_provider.dart';

class TagDataProvider {
  TagDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  CollectionReference<Map<String, dynamic>> get _tagsCollection => _core.organizationCollection('tags');

  Stream<List<Tag>> watchTags() {
    return _tagsCollection.snapshots().map((snapshot) {
      final tags = snapshot.docs.map((doc) => Tag.fromFirestore(doc)).toList();
      tags.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return tags;
    });
  }

  Future<void> addTag(Tag tag) async {
    await _tagsCollection.add(tag.toFirestore());
  }

  Future<void> updateTag(Tag tag) async {
    await _tagsCollection.doc(tag.id).update(tag.toFirestore());
  }

  Future<void> deleteTag(String id) async {
    await _tagsCollection.doc(id).delete();
  }
}
