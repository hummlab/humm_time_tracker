import 'dart:async';

import '../../data_providers/firebase/project_data_provider.dart';
import '../../models/projects/project.dart';
import '../data_repository.dart';

class ProjectsRepository extends DataRepository<List<Project>, void> {
  ProjectsRepository(this._dataProvider) : super(const []);

  final ProjectDataProvider _dataProvider;
  StreamSubscription<List<Project>>? _subscription;

  void start() {
    if (_subscription != null) return;
    _subscription = _dataProvider.watchProjects().listen(emit, onError: emitError);
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    emit(const []);
  }

  @override
  Future<List<Project>> fetch(void _) async {
    try {
      final projects = await _dataProvider.watchProjects().first;
      emit(projects);
      return projects;
    } catch (e, st) {
      emitError(e, st);
      return current;
    }
  }

  Future<void> addProject(Project project) async {
    await _dataProvider.addProject(project);
  }

  Future<void> updateProject(Project project) async {
    await _dataProvider.updateProject(project);
  }

  Future<bool> updateProjectSafe(Project project) async {
    try {
      await _dataProvider.updateProject(project);
      return true;
    } catch (e, st) {
      emitError(e, st);
      return false;
    }
  }

  Future<void> deleteProject(String id) async {
    await _dataProvider.deleteProject(id);
  }

  Future<List<Project>> getProjectsForClient(String clientId) async {
    return _dataProvider.getProjectsForClient(clientId);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
