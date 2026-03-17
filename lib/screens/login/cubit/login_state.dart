import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isSignUp,
    @Default(false) bool isSubmitting,
    @Default(true) bool obscurePassword,
    String? errorMessage,
    String? successMessage,
  }) = _LoginState;

  factory LoginState.initial() {
    return const LoginState();
  }
}
