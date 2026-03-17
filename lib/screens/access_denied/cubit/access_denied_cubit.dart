import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'package:time_tracker/data_providers/time/time_data_provider.dart';

import 'access_denied_state.dart';

class AccessDeniedCubit extends BaseCubit<AccessDeniedState> {
  AccessDeniedCubit(this._authDataProvider, this._timeDataProvider)
    : super(AccessDeniedState(email: _authDataProvider.user?.email ?? 'Unknown email')) {
    _authDataProvider.addListener(_syncFromAuth);
  }

  final AuthDataProvider _authDataProvider;
  final TimeDataProvider _timeDataProvider;

  void _syncFromAuth() {
    emit(state.copyWith(email: _authDataProvider.user?.email ?? 'Unknown email'));
  }

  void signOut() {
    _timeDataProvider.clear();
    _authDataProvider.signOut();
  }

  @override
  void dispose() {
    _authDataProvider.removeListener(_syncFromAuth);
    super.dispose();
  }
}
