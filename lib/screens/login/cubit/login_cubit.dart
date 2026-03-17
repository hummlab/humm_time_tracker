import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_providers/auth/auth_data_provider.dart';
import 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(this._authDataProvider) : super(LoginState.initial());

  final AuthDataProvider _authDataProvider;

  void toggleMode() {
    emit(state.copyWith(isSignUp: !state.isSignUp, errorMessage: null));
  }

  void toggleObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> signIn(String email, String password) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    final ok = await _authDataProvider.signIn(email, password);
    emit(state.copyWith(isSubmitting: false, errorMessage: ok ? null : 'Invalid email or password'));
  }

  Future<void> signUp(String email, String password) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    final ok = await _authDataProvider.signUp(email, password);
    emit(state.copyWith(isSubmitting: false, errorMessage: ok ? null : 'Failed to create account'));
  }

  Future<void> sendPasswordReset(String email) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    final ok = await _authDataProvider.sendPasswordResetEmail(email);
    emit(
      state.copyWith(
        isSubmitting: false,
        errorMessage: ok ? null : 'Failed to send reset email',
        successMessage: ok ? 'Password reset email sent' : null,
      ),
    );
  }

  void clearMessages() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }
}
