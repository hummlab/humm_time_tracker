import 'package:freezed_annotation/freezed_annotation.dart';

part 'access_denied_state.freezed.dart';

@freezed
class AccessDeniedState with _$AccessDeniedState {
  const factory AccessDeniedState({required String email}) = _AccessDeniedState;

  factory AccessDeniedState.initial({required String email}) => AccessDeniedState(email: email);
}
