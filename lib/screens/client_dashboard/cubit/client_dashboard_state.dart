import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/org/organization.dart';
import 'package:time_tracker/models/org/organization_invite.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/models/time/time_entry.dart';

part 'client_dashboard_state.freezed.dart';

@freezed
class ClientDashboardState with _$ClientDashboardState {
  const factory ClientDashboardState({
    required DateTime selectedMonth,
    Client? client,
    @Default([]) List<Project> projects,
    @Default([]) List<TimeEntry> timeEntries,
    @Default([]) List<Tag> tags,
    @Default([]) List<Tag> usedTags,
    @Default([]) List<TimeEntry> filteredEntries,
    @Default([]) List<String> selectedTagIds,
    @Default([]) List<Organization> organizations,
    @Default([]) List<OrganizationInvite> pendingInvites,
    String? activeOrganizationId,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isPreview,
    @Default(false) bool isSigningOut,
  }) = _ClientDashboardState;

  factory ClientDashboardState.initial() => ClientDashboardState(selectedMonth: DateTime.now());
}
