import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit(this._authDataProvider) : super(AuthState.initial()) {
    _authDataProvider.addListener(_syncFromProvider);
    _syncFromProvider();
  }

  final AuthDataProvider _authDataProvider;

  void _syncFromProvider() {
    if (_authDataProvider.isLoading || _authDataProvider.isCheckingAccess) {
      emit(state.copyWith(isLoading: true, isAuthenticated: false, errorMessage: null));
      return;
    }

    if (!_authDataProvider.isAuthenticated) {
      emit(
        state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          isClient: false,
          needsOrganizationSetup: false,
          accessDenied: false,
          errorMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        isClient: _authDataProvider.isClient,
        needsOrganizationSetup: _authDataProvider.needsOrganizationSetup,
        accessDenied: _authDataProvider.accessDenied,
      ),
    );
  }

  @override
  void dispose() {
    _authDataProvider.removeListener(_syncFromProvider);
    super.dispose();
  }
}
