import 'package:flutter/foundation.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_providers/firebase/client_data_provider.dart';
import 'package:time_tracker/data_providers/firebase/firebase_core_data_provider.dart';
import 'package:time_tracker/data_providers/firebase/organization_data_provider.dart';
import 'package:time_tracker/data_providers/firebase/project_data_provider.dart';
import 'package:time_tracker/data_providers/firebase/tag_data_provider.dart';
import 'package:time_tracker/data_providers/firebase/team_member_data_provider.dart';
import 'package:time_tracker/data_providers/firebase/time_entry_data_provider.dart';
import 'package:time_tracker/data_providers/time/time_data_provider.dart';
import 'package:time_tracker/data_repositories/firebase/clients_repository.dart';
import 'package:time_tracker/data_repositories/firebase/projects_repository.dart';
import 'package:time_tracker/data_repositories/firebase/tags_repository.dart';
import 'package:time_tracker/data_repositories/firebase/team_members_repository.dart';
import 'package:time_tracker/data_repositories/firebase/time_entries_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/screens/login/cubit/auth_cubit.dart';

class AppDependencies with ChangeNotifier {
  AppDependencies._();

  static final AppDependencies instance = AppDependencies._();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  late final FirebaseCoreDataProvider firebaseCoreDataProvider;
  late final ClientsRepository clientsRepository;
  late final ProjectsRepository projectsRepository;
  late final TeamMembersRepository teamMembersRepository;
  late final TagsRepository tagsRepository;
  late final TimeEntriesRepository timeEntriesRepository;
  late final WorkspaceRepository workspaceRepository;
  late final TimeDataProvider timeDataProvider;
  late final AuthDataProvider authDataProvider;
  late final AuthCubit authCubit;

  void init() {
    if (_isInitialized) return;

    firebaseCoreDataProvider = FirebaseCoreDataProvider();

    clientsRepository = ClientsRepository(ClientDataProvider(firebaseCoreDataProvider));
    projectsRepository = ProjectsRepository(ProjectDataProvider(firebaseCoreDataProvider));
    teamMembersRepository = TeamMembersRepository(
      TeamMemberDataProvider(firebaseCoreDataProvider),
      OrganizationDataProvider(firebaseCoreDataProvider),
    );
    tagsRepository = TagsRepository(TagDataProvider(firebaseCoreDataProvider));
    timeEntriesRepository = TimeEntriesRepository(TimeEntryDataProvider(firebaseCoreDataProvider));

    workspaceRepository = WorkspaceRepository(
      clientsRepository: clientsRepository,
      projectsRepository: projectsRepository,
      teamMembersRepository: teamMembersRepository,
      tagsRepository: tagsRepository,
      timeEntriesRepository: timeEntriesRepository,
    );

    timeDataProvider = TimeDataProvider();
    timeDataProvider.setRepositories(
      clientsRepository: clientsRepository,
      projectsRepository: projectsRepository,
      teamMembersRepository: teamMembersRepository,
      tagsRepository: tagsRepository,
      timeEntriesRepository: timeEntriesRepository,
      workspaceRepository: workspaceRepository,
    );

    authDataProvider = AuthDataProvider();
    authCubit = AuthCubit(authDataProvider);

    _isInitialized = true;
    notifyListeners();
  }
}
