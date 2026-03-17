// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LoginState {
  bool get isSignUp => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get obscurePassword => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginStateCopyWith<LoginState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call({bool isSignUp, bool isSubmitting, bool obscurePassword, String? errorMessage, String? successMessage});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSignUp = null,
    Object? isSubmitting = null,
    Object? obscurePassword = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isSignUp:
                null == isSignUp
                    ? _value.isSignUp
                    : isSignUp // ignore: cast_nullable_to_non_nullable
                        as bool,
            isSubmitting:
                null == isSubmitting
                    ? _value.isSubmitting
                    : isSubmitting // ignore: cast_nullable_to_non_nullable
                        as bool,
            obscurePassword:
                null == obscurePassword
                    ? _value.obscurePassword
                    : obscurePassword // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            successMessage:
                freezed == successMessage
                    ? _value.successMessage
                    : successMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(_$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isSignUp, bool isSubmitting, bool obscurePassword, String? errorMessage, String? successMessage});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(_$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSignUp = null,
    Object? isSubmitting = null,
    Object? obscurePassword = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$LoginStateImpl(
        isSignUp:
            null == isSignUp
                ? _value.isSignUp
                : isSignUp // ignore: cast_nullable_to_non_nullable
                    as bool,
        isSubmitting:
            null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                    as bool,
        obscurePassword:
            null == obscurePassword
                ? _value.obscurePassword
                : obscurePassword // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        successMessage:
            freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl({
    this.isSignUp = false,
    this.isSubmitting = false,
    this.obscurePassword = true,
    this.errorMessage,
    this.successMessage,
  });

  @override
  @JsonKey()
  final bool isSignUp;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final bool obscurePassword;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'LoginState(isSignUp: $isSignUp, isSubmitting: $isSubmitting, obscurePassword: $obscurePassword, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.isSignUp, isSignUp) || other.isSignUp == isSignUp) &&
            (identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting) &&
            (identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) || other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSignUp, isSubmitting, obscurePassword, errorMessage, successMessage);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState({
    final bool isSignUp,
    final bool isSubmitting,
    final bool obscurePassword,
    final String? errorMessage,
    final String? successMessage,
  }) = _$LoginStateImpl;

  @override
  bool get isSignUp;
  @override
  bool get isSubmitting;
  @override
  bool get obscurePassword;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith => throw _privateConstructorUsedError;
}
