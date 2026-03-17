import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/org/organization.dart';
import 'package:time_tracker/models/org/team_member.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(0) int selectedIndex,
    @Default(false) bool isClient,
    @Default(false) bool isAdmin,
    @Default(false) bool isManager,
    @Default(false) bool hasManagerAccess,
    String? activeOrganizationId,
    @Default(<Organization>[]) List<Organization> organizations,
    @Default(0) int pendingInvitesCount,
    @Default(TeamMemberRole.regular) TeamMemberRole userRole,
    String? userEmail,
    @Default(false) bool isLoading,
  }) = _MainState;

  factory MainState.initial() {
    return const MainState();
  }
}
