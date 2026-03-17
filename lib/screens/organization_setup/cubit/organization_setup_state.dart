import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/org/organization.dart';
import 'package:time_tracker/models/org/organization_invite.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'organization_setup_state.freezed.dart';

@freezed
class OrganizationSetupState with _$OrganizationSetupState {
  const factory OrganizationSetupState({
    @Default([]) List<Organization> organizations,
    @Default([]) List<OrganizationInvite> invites,
    @Default(false) bool isLoadingOrganizations,
    @Default(false) bool isLoadingInvites,
    @Default(false) bool isSigningOut,
    String? toastMessage,
    AppToastType? toastType,
  }) = _OrganizationSetupState;

  factory OrganizationSetupState.initial() => const OrganizationSetupState();
}
