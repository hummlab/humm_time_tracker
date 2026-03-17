import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'team_state.freezed.dart';

@freezed
class TeamMemberCardData with _$TeamMemberCardData {
  const factory TeamMemberCardData({
    required TeamMember member,
    @Default(0) int projectCount,
    @Default(<String>[]) List<String> projectNames,
  }) = _TeamMemberCardData;
}

@freezed
class TeamState with _$TeamState {
  const factory TeamState({
    @Default([]) List<TeamMemberCardData> cards,
    @Default(false) bool isAdmin,
    @Default(false) bool isManager,
    @Default(false) bool isSigningOut,
    String? toastMessage,
    AppToastType? toastType,
  }) = _TeamState;

  factory TeamState.initial() => const TeamState();
}
