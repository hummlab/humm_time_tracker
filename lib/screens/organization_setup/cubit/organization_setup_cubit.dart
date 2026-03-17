import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_providers/time/time_data_provider.dart';
import 'package:time_tracker/models/org/organization_invite.dart';
import 'package:time_tracker/widgets/app_toast.dart';
import 'organization_setup_state.dart';

class OrganizationSetupCubit extends BaseCubit<OrganizationSetupState> {
  OrganizationSetupCubit(this._authDataProvider, this._timeDataProvider) : super(OrganizationSetupState.initial()) {
    _authDataProvider.addListener(_syncFromAuth);
    _syncFromAuth();
    _authDataProvider.refreshOrganizations();
  }

  final AuthDataProvider _authDataProvider;
  final TimeDataProvider _timeDataProvider;

  void _syncFromAuth() {
    emit(
      state.copyWith(
        organizations: _authDataProvider.organizations,
        invites: _authDataProvider.pendingInvites,
        isLoadingOrganizations: _authDataProvider.isLoadingOrganizations,
        isLoadingInvites: _authDataProvider.isLoadingInvites,
      ),
    );
  }

  Future<bool> createOrganization(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      emit(state.copyWith(toastMessage: 'Enter organization name', toastType: AppToastType.error));
      return false;
    }

    final success = await _authDataProvider.createOrganization(trimmed);
    if (!success) {
      emit(
        state.copyWith(
          toastMessage: _authDataProvider.error ?? 'Failed to create organization',
          toastType: AppToastType.error,
        ),
      );
      return false;
    }

    _timeDataProvider.init();
    emit(state.copyWith(toastMessage: 'Organization created', toastType: AppToastType.success));
    return true;
  }

  Future<bool> selectOrganization(String organizationId) async {
    await _authDataProvider.setActiveOrganization(organizationId);
    _timeDataProvider.init();
    return true;
  }

  Future<bool> acceptInvite(OrganizationInvite invite) async {
    final success = await _authDataProvider.acceptOrganizationInvite(invite);
    if (!success) {
      emit(
        state.copyWith(
          toastMessage: _authDataProvider.error ?? 'Failed to join organization',
          toastType: AppToastType.error,
        ),
      );
      return false;
    }

    _timeDataProvider.init();
    emit(state.copyWith(toastMessage: 'Joined ${invite.organizationName}', toastType: AppToastType.success));
    return true;
  }

  Future<void> signOut() async {
    if (state.isSigningOut) return;
    emit(state.copyWith(isSigningOut: true));
    try {
      await _authDataProvider.signOut();
    } finally {
      emit(state.copyWith(isSigningOut: false));
    }
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  @override
  void dispose() {
    _authDataProvider.removeListener(_syncFromAuth);
    super.dispose();
  }
}
