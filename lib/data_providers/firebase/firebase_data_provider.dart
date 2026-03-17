import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/integrations/clickup_task.dart';
import '../../models/org/organization.dart';
import '../../models/org/organization_invite.dart';
import '../../models/org/organization_member.dart';
import '../../models/org/team_member.dart';
import '../../models/projects/client.dart';
import '../../models/projects/project.dart';
import '../../models/projects/tag.dart';
import '../../models/settings/admin_settings.dart';
import '../../models/time/time_entry.dart';
import 'admin_settings_data_provider.dart';
import 'clickup_task_data_provider.dart';
import 'client_data_provider.dart';
import 'firebase_auth_data_provider.dart';
import 'firebase_core_data_provider.dart';
import 'organization_data_provider.dart';
import 'project_data_provider.dart';
import 'tag_data_provider.dart';
import 'team_member_data_provider.dart';
import 'time_entry_data_provider.dart';

class FirebaseDataProvider {
  FirebaseDataProvider({FirebaseCoreDataProvider? core}) : _core = core ?? FirebaseCoreDataProvider() {
    auth = FirebaseAuthDataProvider(_core);
    organizations = OrganizationDataProvider(_core);
    clients = ClientDataProvider(_core);
    projects = ProjectDataProvider(_core);
    teamMembers = TeamMemberDataProvider(_core);
    tags = TagDataProvider(_core);
    timeEntries = TimeEntryDataProvider(_core);
    clickUpTasks = ClickUpTaskDataProvider(_core);
    adminSettings = AdminSettingsDataProvider(_core);
  }

  final FirebaseCoreDataProvider _core;

  late final FirebaseAuthDataProvider auth;
  late final OrganizationDataProvider organizations;
  late final ClientDataProvider clients;
  late final ProjectDataProvider projects;
  late final TeamMemberDataProvider teamMembers;
  late final TagDataProvider tags;
  late final TimeEntryDataProvider timeEntries;
  late final ClickUpTaskDataProvider clickUpTasks;
  late final AdminSettingsDataProvider adminSettings;

  String? get currentUserId => _core.currentUserId;
  String? get activeOrganizationId => _core.activeOrganizationId;

  static String? get currentActiveOrganizationId => FirebaseCoreDataProvider.currentActiveOrganizationId;

  void setActiveOrganizationId(String? organizationId) {
    _core.setActiveOrganizationId(organizationId);
  }

  Stream<User?> get authStateChanges => auth.authStateChanges;

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return auth.signInWithEmail(email, password);
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return auth.signUpWithEmail(email, password);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await auth.sendPasswordResetEmail(email);
  }

  Future<List<Organization>> getOrganizationsByIds(List<String> organizationIds) async {
    return organizations.getOrganizationsByIds(organizationIds);
  }

  Future<Organization> createOrganization({
    required String name,
    required String ownerUserId,
    required String ownerEmail,
  }) async {
    return organizations.createOrganization(name: name, ownerUserId: ownerUserId, ownerEmail: ownerEmail);
  }

  Future<void> setActiveOrganizationForUser(String userId, String organizationId) async {
    await organizations.setActiveOrganizationForUser(userId, organizationId);
  }

  Future<OrganizationMember?> getOrganizationMember(String organizationId, String userId) async {
    return organizations.getOrganizationMember(organizationId, userId);
  }

  Future<void> inviteOrganizationMember({required String email, required TeamMemberRole role}) async {
    await organizations.inviteOrganizationMember(email: email, role: role);
  }

  Future<List<OrganizationInvite>> getMyPendingOrganizationInvites() async {
    return organizations.getMyPendingOrganizationInvites();
  }

  Future<void> acceptOrganizationInvite({required String organizationId, required String inviteId}) async {
    await organizations.acceptOrganizationInvite(organizationId: organizationId, inviteId: inviteId);
  }

  Future<Map<String, dynamic>> resolveMyOrganizations({bool persistToUserDoc = true}) async {
    return organizations.resolveMyOrganizations(persistToUserDoc: persistToUserDoc);
  }

  Stream<List<Client>> getClients() => clients.watchClients();

  Future<void> addClient(Client client) async {
    await clients.addClient(client);
  }

  Future<void> updateClient(Client client) async {
    await clients.updateClient(client);
  }

  Future<void> deleteClient(String id) async {
    await clients.deleteClient(id);
  }

  Stream<List<Project>> getProjects() => projects.watchProjects();

  Future<void> addProject(Project project) async {
    await projects.addProject(project);
  }

  Future<void> updateProject(Project project) async {
    await projects.updateProject(project);
  }

  Future<void> deleteProject(String id) async {
    await projects.deleteProject(id);
  }

  Stream<List<TeamMember>> getTeamMembers() => teamMembers.watchTeamMembers();

  Future<void> addTeamMember(TeamMember member) async {
    await teamMembers.addTeamMember(member);
    if (member.email.isNotEmpty) {
      await inviteOrganizationMember(email: member.email, role: member.role);
    }
  }

  Future<void> updateTeamMember(TeamMember member) async {
    await teamMembers.updateTeamMember(member);
  }

  Future<void> syncUserRoleFromTeamMember(TeamMember member) async {
    await teamMembers.syncUserRoleFromTeamMember(member);
  }

  Future<void> deleteTeamMember(String id) async {
    await teamMembers.deleteTeamMember(id);
  }

  Stream<List<Tag>> getTags() => tags.watchTags();

  Future<void> addTag(Tag tag) async {
    await tags.addTag(tag);
  }

  Future<void> updateTag(Tag tag) async {
    await tags.updateTag(tag);
  }

  Future<void> deleteTag(String id) async {
    await tags.deleteTag(id);
  }

  Stream<List<TimeEntry>> getTimeEntries() => timeEntries.watchTimeEntries();

  Future<DocumentReference<Map<String, dynamic>>> addTimeEntry(TimeEntry entry) async {
    return timeEntries.addTimeEntry(entry);
  }

  Future<void> updateTimeEntry(TimeEntry entry) async {
    await timeEntries.updateTimeEntry(entry);
  }

  Future<void> deleteTimeEntry(String id) async {
    await timeEntries.deleteTimeEntry(id);
  }

  Future<void> updateTimeEntriesStatus(
    List<String> entryIds,
    TimeEntryStatus status, {
    String? approvedByUserId,
    String? rejectionReason,
  }) async {
    await timeEntries.updateTimeEntriesStatus(
      entryIds,
      status,
      approvedByUserId: approvedByUserId,
      rejectionReason: rejectionReason,
    );
  }

  Stream<List<TimeEntry>> getTimeEntriesByStatus(TimeEntryStatus status) {
    return timeEntries.watchTimeEntriesByStatus(status);
  }

  Stream<List<TimeEntry>> getPendingTimeEntries() {
    return timeEntries.watchPendingTimeEntries();
  }

  Stream<List<ClickUpTask>> getClickUpTasks() {
    return clickUpTasks.watchClickUpTasks();
  }

  Future<AdminSettings> getAdminSettings() async {
    return adminSettings.getAdminSettings();
  }

  Future<void> updateAdminSettings(AdminSettings settings) async {
    await adminSettings.updateAdminSettings(settings);
  }

  Future<List<Project>> getProjectsForClient(String clientId) async {
    return projects.getProjectsForClient(clientId);
  }

  Future<List<TimeEntry>> getTimeEntriesForClient(String clientId) async {
    final projectsForClient = await getProjectsForClient(clientId);
    final projectIds = projectsForClient.map((p) => p.id).toList();

    if (projectIds.isEmpty) {
      return [];
    }

    final List<TimeEntry> allEntries = [];
    for (var i = 0; i < projectIds.length; i += 10) {
      final batch = projectIds.skip(i).take(10).toList();
      final snapshot =
          await _core
              .organizationCollection('timeEntries')
              .where('projectId', whereIn: batch)
              .where('status', isEqualTo: TimeEntryStatus.approved.value)
              .get();
      allEntries.addAll(snapshot.docs.map((doc) => TimeEntry.fromFirestore(doc)));
    }

    return allEntries;
  }

  Future<List<TimeEntry>> getTimeEntriesForClientMonth(String clientId, int year, int month) async {
    final projectsForClient = await getProjectsForClient(clientId);
    final projectIds = projectsForClient.map((p) => p.id).toList();

    if (projectIds.isEmpty) {
      return [];
    }

    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = DateTime(year, month + 1, 0, 23, 59, 59);

    final List<TimeEntry> allEntries = [];
    for (var i = 0; i < projectIds.length; i += 10) {
      final batch = projectIds.skip(i).take(10).toList();
      final snapshot =
          await _core
              .organizationCollection('timeEntries')
              .where('projectId', whereIn: batch)
              .where('status', isEqualTo: TimeEntryStatus.approved.value)
              .get();
      allEntries.addAll(
        snapshot.docs
            .map((doc) => TimeEntry.fromFirestore(doc))
            .where(
              (entry) =>
                  entry.date.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
                  entry.date.isBefore(endOfMonth.add(const Duration(days: 1))),
            ),
      );
    }

    return allEntries;
  }

  Future<Client?> getClientById(String clientId) async {
    return clients.getClientById(clientId);
  }

  Future<String?> findClientIdByEmail({required String organizationId, required String email}) async {
    return clients.findClientIdByEmail(organizationId: organizationId, email: email);
  }
}
