import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(true) bool isLoading,
    @Default(false) bool isAuthenticated,
    @Default(false) bool isClient,
    @Default(false) bool needsOrganizationSetup,
    @Default(false) bool accessDenied,
    String? errorMessage,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState();
}
