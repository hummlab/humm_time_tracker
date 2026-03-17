import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_providers/time/time_data_provider.dart';
import 'main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit(this._authDataProvider, this._timeDataProvider) : super(MainState.initial()) {
    _authDataProvider.addListener(_syncFromProvider);
    _syncFromProvider();
  }

  final AuthDataProvider _authDataProvider;
  final TimeDataProvider _timeDataProvider;

  void _syncFromProvider() {
    emit(
      state.copyWith(
        isClient: _authDataProvider.isClient,
        isAdmin: _authDataProvider.isAdmin,
        isManager: _authDataProvider.isManager,
        hasManagerAccess: _authDataProvider.hasManagerAccess,
        activeOrganizationId: _authDataProvider.activeOrganizationId,
        organizations: _authDataProvider.organizations,
        pendingInvitesCount: _authDataProvider.pendingInvites.length,
        userRole: _authDataProvider.userRole,
        userEmail: _authDataProvider.user?.email,
        isLoading: _authDataProvider.isLoading,
      ),
    );
  }

  void selectTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  Future<void> switchOrganization(String organizationId) async {
    if (organizationId == _authDataProvider.activeOrganizationId) {
      return;
    }

    await _authDataProvider.setActiveOrganization(organizationId);
    _timeDataProvider.clear();
    _timeDataProvider.init();
  }

  Future<void> refreshOrganizationsAndReload(String? beforeOrgId) async {
    await _authDataProvider.refreshOrganizations();
    final afterOrgId = _authDataProvider.activeOrganizationId;
    if (beforeOrgId != afterOrgId) {
      _timeDataProvider.clear();
      _timeDataProvider.init();
    }
  }

  void initTimeData() {
    _timeDataProvider.init();
  }

  void signOut() {
    _timeDataProvider.clear();
    _authDataProvider.signOut();
  }

  @override
  void dispose() {
    _authDataProvider.removeListener(_syncFromProvider);
    super.dispose();
  }
}
