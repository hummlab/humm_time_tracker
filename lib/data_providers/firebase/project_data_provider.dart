import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/projects/project.dart';
import 'firebase_core_data_provider.dart';

class ProjectDataProvider {
  ProjectDataProvider(this._core);

  final FirebaseCoreDataProvider _core;

  CollectionReference<Map<String, dynamic>> get _projectsCollection => _core.organizationCollection('projects');

  Stream<List<Project>> watchProjects() {
    return _projectsCollection.snapshots().map((snapshot) {
      final projects = snapshot.docs.map((doc) => Project.fromFirestore(doc)).toList();
      projects.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return projects;
    });
  }

  Future<void> addProject(Project project) async {
    await _projectsCollection.add(project.toFirestore());
  }

  Future<void> updateProject(Project project) async {
    await _projectsCollection.doc(project.id).update(project.toFirestore());
  }

  Future<void> deleteProject(String id) async {
    await _projectsCollection.doc(id).delete();
  }

  Future<List<Project>> getProjectsForClient(String clientId) async {
    final snapshot = await _projectsCollection.where('clientId', isEqualTo: clientId).get();
    return snapshot.docs.map((doc) => Project.fromFirestore(doc)).toList();
  }
}
