import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/org/team_member.dart';
import '../models/projects/client.dart';
import '../models/projects/project.dart';
import '../models/projects/tag.dart';
import '../models/time/grid_row.dart';
import '../models/time/time_entry.dart';
import 'firebase/clients_repository.dart';
import 'firebase/projects_repository.dart';
import 'firebase/tags_repository.dart';
import 'firebase/team_members_repository.dart';
import 'firebase/time_entries_repository.dart';

class WorkspaceRepository extends ChangeNotifier {
  WorkspaceRepository({
    ClientsRepository? clientsRepository,
    ProjectsRepository? projectsRepository,
    TeamMembersRepository? teamMembersRepository,
    TagsRepository? tagsRepository,
    TimeEntriesRepository? timeEntriesRepository,
  }) {
    if (clientsRepository != null &&
        projectsRepository != null &&
        teamMembersRepository != null &&
        tagsRepository != null &&
        timeEntriesRepository != null) {
      updateRepositories(
        clientsRepository: clientsRepository,
        projectsRepository: projectsRepository,
        teamMembersRepository: teamMembersRepository,
        tagsRepository: tagsRepository,
        timeEntriesRepository: timeEntriesRepository,
      );
    }
  }

  ClientsRepository? _clientsRepository;
  ProjectsRepository? _projectsRepository;
  TeamMembersRepository? _teamMembersRepository;
  TagsRepository? _tagsRepository;
  TimeEntriesRepository? _timeEntriesRepository;

  StreamSubscription? _clientsSub;
  StreamSubscription? _projectsSub;
  StreamSubscription? _teamMembersSub;
  StreamSubscription? _tagsSub;
  StreamSubscription? _timeEntriesSub;

  void updateRepositories({
    required ClientsRepository clientsRepository,
    required ProjectsRepository projectsRepository,
    required TeamMembersRepository teamMembersRepository,
    required TagsRepository tagsRepository,
    required TimeEntriesRepository timeEntriesRepository,
  }) {
    if (_clientsRepository == clientsRepository &&
        _projectsRepository == projectsRepository &&
        _teamMembersRepository == teamMembersRepository &&
        _tagsRepository == tagsRepository &&
        _timeEntriesRepository == timeEntriesRepository) {
      return;
    }

    _detachListeners();

    _clientsRepository = clientsRepository;
    _projectsRepository = projectsRepository;
    _teamMembersRepository = teamMembersRepository;
    _tagsRepository = tagsRepository;
    _timeEntriesRepository = timeEntriesRepository;

    _clientsSub = clientsRepository.stream.listen((_) => notifyListeners(), onError: (_) => notifyListeners());
    _projectsSub = projectsRepository.stream.listen((_) => notifyListeners(), onError: (_) => notifyListeners());
    _teamMembersSub = teamMembersRepository.stream.listen((_) => notifyListeners(), onError: (_) => notifyListeners());
    _tagsSub = tagsRepository.stream.listen((_) => notifyListeners(), onError: (_) => notifyListeners());
    _timeEntriesSub = timeEntriesRepository.stream.listen((_) => notifyListeners(), onError: (_) => notifyListeners());

    notifyListeners();
  }

  void _detachListeners() {
    _clientsSub?.cancel();
    _projectsSub?.cancel();
    _teamMembersSub?.cancel();
    _tagsSub?.cancel();
    _timeEntriesSub?.cancel();
  }

  List<Client> get clients => _clientsRepository?.current ?? const [];
  List<Project> get projects => _projectsRepository?.current ?? const [];
  List<TeamMember> get teamMembers => _teamMembersRepository?.current ?? const [];
  List<Tag> get tags => _tagsRepository?.current ?? const [];
  List<TimeEntry> get timeEntries => _timeEntriesRepository?.current ?? const [];

  T? _firstWhereOrNull<T>(List<T> items, bool Function(T) test) {
    for (final item in items) {
      if (test(item)) return item;
    }
    return null;
  }

  Project? getProjectById(String id) {
    return _firstWhereOrNull(projects, (p) => p.id == id);
  }

  Project? getProjectByClickUpListId(String listId) {
    return _firstWhereOrNull(projects, (p) => p.clickUpListIds.contains(listId));
  }

  Client? getClientById(String id) {
    return _firstWhereOrNull(clients, (c) => c.id == id);
  }

  Tag? getTagById(String id) {
    return _firstWhereOrNull(tags, (t) => t.id == id);
  }

  TeamMember? getTeamMemberById(String id) {
    return _firstWhereOrNull(teamMembers, (m) => m.id == id);
  }

  TeamMember? getCurrentUserTeamMember(String? currentUserId) {
    final userId = currentUserId;
    if (userId == null) {
      return null;
    }

    return _firstWhereOrNull(teamMembers, (m) => m.firebaseUid == userId);
  }

  List<Project> getProjectsForUser({required bool hasManagerAccess, String? teamMemberId}) {
    if (hasManagerAccess) {
      return projects;
    }

    if (teamMemberId == null) {
      return [];
    }

    return projects.where((p) => p.teamMemberIds.contains(teamMemberId)).toList();
  }

  List<Client> getClientsForUser({required bool hasManagerAccess, String? teamMemberId}) {
    if (hasManagerAccess) {
      return clients;
    }

    if (teamMemberId == null) {
      return [];
    }

    final userProjectIds =
        projects
            .where((p) => p.teamMemberIds.contains(teamMemberId))
            .map((p) => p.clientId)
            .whereType<String>()
            .toSet();

    return clients.where((c) => userProjectIds.contains(c.id)).toList();
  }

  List<TeamMember> getTeamMembersForUser({
    required bool isAdmin,
    required bool isManager,
    String? teamMemberId,
    String? currentUserId,
  }) {
    if (isAdmin) {
      return teamMembers;
    }

    final currentMember = getCurrentUserTeamMember(currentUserId);
    if (currentMember == null) {
      return [];
    }

    if (isManager) {
      final managerProjectIds =
          projects.where((p) => p.teamMemberIds.contains(teamMemberId ?? currentMember.id)).map((p) => p.id).toSet();

      final visibleMemberIds = <String>{};
      for (final project in projects) {
        if (managerProjectIds.contains(project.id)) {
          visibleMemberIds.addAll(project.teamMemberIds);
        }
      }

      visibleMemberIds.add(currentMember.id);

      return teamMembers.where((m) => visibleMemberIds.contains(m.id)).toList();
    }

    return [currentMember];
  }

  List<TimeEntry> getTimeEntriesForUser({
    required bool isAdmin,
    required bool isManager,
    String? teamMemberId,
    String? currentUserId,
  }) {
    if (isAdmin) {
      return timeEntries;
    }

    final currentMember = getCurrentUserTeamMember(currentUserId);
    if (currentMember == null) {
      return [];
    }

    final currentFirebaseUid = currentMember.firebaseUid;

    if (isManager) {
      final managerProjectIds =
          projects.where((p) => p.teamMemberIds.contains(teamMemberId ?? currentMember.id)).map((p) => p.id).toSet();

      final teamMembersOnManagerProjects = <String>{};
      for (final project in projects) {
        if (managerProjectIds.contains(project.id)) {
          for (final memberId in project.teamMemberIds) {
            final member = getTeamMemberById(memberId);
            if (member?.firebaseUid != null) {
              teamMembersOnManagerProjects.add(member!.firebaseUid!);
            }
          }
        }
      }

      if (currentFirebaseUid != null) {
        teamMembersOnManagerProjects.add(currentFirebaseUid);
      }

      return timeEntries.where((e) => teamMembersOnManagerProjects.contains(e.createdByUserId)).toList();
    }

    if (currentFirebaseUid == null) {
      return [];
    }

    return timeEntries.where((e) => e.createdByUserId == currentFirebaseUid).toList();
  }

  Set<String> getVisibleUserIds({
    required bool isAdmin,
    required bool isManager,
    String? teamMemberId,
    String? currentUserId,
  }) {
    if (isAdmin) {
      return teamMembers.map((m) => m.firebaseUid).whereType<String>().toSet();
    }

    final currentMember = getCurrentUserTeamMember(currentUserId);
    if (currentMember == null) {
      return {};
    }

    final currentFirebaseUid = currentMember.firebaseUid;

    if (isManager) {
      final managerProjectIds =
          projects.where((p) => p.teamMemberIds.contains(teamMemberId ?? currentMember.id)).map((p) => p.id).toSet();

      final visibleUids = <String>{};
      for (final project in projects) {
        if (managerProjectIds.contains(project.id)) {
          for (final memberId in project.teamMemberIds) {
            final member = getTeamMemberById(memberId);
            if (member?.firebaseUid != null) {
              visibleUids.add(member!.firebaseUid!);
            }
          }
        }
      }

      if (currentFirebaseUid != null) {
        visibleUids.add(currentFirebaseUid);
      }

      return visibleUids;
    }

    if (currentFirebaseUid != null) {
      return {currentFirebaseUid};
    }

    return {};
  }

  List<TimeEntry> getEntriesForDate(DateTime date) {
    return timeEntries.where((entry) {
      return entry.date.year == date.year && entry.date.month == date.month && entry.date.day == date.day;
    }).toList();
  }

  List<TimeEntry> getEntriesForWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    return timeEntries.where((entry) {
      return entry.date.isAfter(weekStart.subtract(const Duration(days: 1))) && entry.date.isBefore(weekEnd);
    }).toList();
  }

  int getTotalMinutesForDate(DateTime date) {
    return getEntriesForDate(date).fold(0, (sum, entry) => sum + entry.durationMinutes);
  }

  int getTotalMinutesForWeek(DateTime weekStart) {
    return getEntriesForWeek(weekStart).fold(0, (sum, entry) => sum + entry.durationMinutes);
  }

  Map<String, int> getMinutesByProject(DateTime start, DateTime end) {
    final entries = timeEntries.where((entry) {
      return entry.date.isAfter(start.subtract(const Duration(days: 1))) &&
          entry.date.isBefore(end.add(const Duration(days: 1)));
    });

    final Map<String, int> result = {};
    for (final entry in entries) {
      final projectId = entry.projectId ?? 'unassigned';
      result[projectId] = (result[projectId] ?? 0) + entry.durationMinutes;
    }
    return result;
  }

  List<TimeEntry> getDraftEntriesForCurrentUser(String? currentUserId) {
    if (currentUserId == null) return [];
    return timeEntries.where((e) => e.createdByUserId == currentUserId && e.isDraft).toList();
  }

  List<TimeEntry> getPendingEntries() {
    return timeEntries.where((e) => e.isPending).toList();
  }

  List<TimeEntry> getPendingEntriesForCurrentUser(String? currentUserId) {
    if (currentUserId == null) return [];
    return timeEntries.where((e) => e.createdByUserId == currentUserId && e.isPending).toList();
  }

  List<TimeEntry> getRejectedEntriesForCurrentUser(String? currentUserId) {
    if (currentUserId == null) return [];
    return timeEntries.where((e) => e.createdByUserId == currentUserId && e.isRejected).toList();
  }

  List<GridRow> getWeekGridData(DateTime weekStart, {required String? currentUserId}) {
    if (currentUserId == null) return [];

    final weekEnd = weekStart.add(const Duration(days: 7));
    final weekEntries =
        timeEntries
            .where(
              (e) =>
                  e.createdByUserId == currentUserId &&
                  e.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
                  e.date.isBefore(weekEnd),
            )
            .toList();

    final Map<String, GridRow> rows = {};

    for (final entry in weekEntries) {
      final sortedTags = List<String>.from(entry.tagIds)..sort();
      final key = '${entry.projectId ?? 'no-project'}|${entry.description}|${sortedTags.join(',')}';

      if (!rows.containsKey(key)) {
        rows[key] = GridRow(
          description: entry.description,
          projectId: entry.projectId,
          tagIds: entry.tagIds,
          dayMinutes: List.filled(7, 0),
          dayEntryIds: List.generate(7, (_) => <String>[]),
        );
      }

      final dayIndex = entry.date.difference(DateTime(weekStart.year, weekStart.month, weekStart.day)).inDays;
      if (dayIndex >= 0 && dayIndex < 7) {
        rows[key]!.dayMinutes[dayIndex] += entry.durationMinutes;
        rows[key]!.dayEntryIds[dayIndex].add(entry.id);
      }
    }

    return rows.values.toList();
  }

  @override
  void dispose() {
    _detachListeners();
    super.dispose();
  }
}
