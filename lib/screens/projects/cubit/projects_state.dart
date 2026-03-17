import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'projects_state.freezed.dart';

@freezed
class ProjectCardData with _$ProjectCardData {
  const factory ProjectCardData({
    required Project project,
    String? clientName,
    @Default(<TeamMember>[]) List<TeamMember> teamMembers,
    @Default(0) int totalMinutes,
    @Default(0) int thisMonthMinutes,
  }) = _ProjectCardData;
}

@freezed
class ProjectsState with _$ProjectsState {
  const factory ProjectsState({
    @Default([]) List<ProjectCardData> cards,
    @Default([]) List<Client> clients,
    @Default([]) List<TeamMember> teamMembers,
    @Default(false) bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  }) = _ProjectsState;

  factory ProjectsState.initial() => const ProjectsState();
}
