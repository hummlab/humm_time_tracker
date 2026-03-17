// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isAuthenticated => throw _privateConstructorUsedError;
  bool get isClient => throw _privateConstructorUsedError;
  bool get needsOrganizationSetup => throw _privateConstructorUsedError;
  bool get accessDenied => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) = _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isAuthenticated,
    bool isClient,
    bool needsOrganizationSetup,
    bool accessDenied,
    String? errorMessage,
  });
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isAuthenticated = null,
    Object? isClient = null,
    Object? needsOrganizationSetup = null,
    Object? accessDenied = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            isAuthenticated:
                null == isAuthenticated
                    ? _value.isAuthenticated
                    : isAuthenticated // ignore: cast_nullable_to_non_nullable
                        as bool,
            isClient:
                null == isClient
                    ? _value.isClient
                    : isClient // ignore: cast_nullable_to_non_nullable
                        as bool,
            needsOrganizationSetup:
                null == needsOrganizationSetup
                    ? _value.needsOrganizationSetup
                    : needsOrganizationSetup // ignore: cast_nullable_to_non_nullable
                        as bool,
            accessDenied:
                null == accessDenied
                    ? _value.accessDenied
                    : accessDenied // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(_$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isAuthenticated,
    bool isClient,
    bool needsOrganizationSetup,
    bool accessDenied,
    String? errorMessage,
  });
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(_$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isAuthenticated = null,
    Object? isClient = null,
    Object? needsOrganizationSetup = null,
    Object? accessDenied = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$AuthStateImpl(
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        isAuthenticated:
            null == isAuthenticated
                ? _value.isAuthenticated
                : isAuthenticated // ignore: cast_nullable_to_non_nullable
                    as bool,
        isClient:
            null == isClient
                ? _value.isClient
                : isClient // ignore: cast_nullable_to_non_nullable
                    as bool,
        needsOrganizationSetup:
            null == needsOrganizationSetup
                ? _value.needsOrganizationSetup
                : needsOrganizationSetup // ignore: cast_nullable_to_non_nullable
                    as bool,
        accessDenied:
            null == accessDenied
                ? _value.accessDenied
                : accessDenied // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl({
    this.isLoading = true,
    this.isAuthenticated = false,
    this.isClient = false,
    this.needsOrganizationSetup = false,
    this.accessDenied = false,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isAuthenticated;
  @override
  @JsonKey()
  final bool isClient;
  @override
  @JsonKey()
  final bool needsOrganizationSetup;
  @override
  @JsonKey()
  final bool accessDenied;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, isAuthenticated: $isAuthenticated, isClient: $isClient, needsOrganizationSetup: $needsOrganizationSetup, accessDenied: $accessDenied, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated) &&
            (identical(other.isClient, isClient) || other.isClient == isClient) &&
            (identical(other.needsOrganizationSetup, needsOrganizationSetup) ||
                other.needsOrganizationSetup == needsOrganizationSetup) &&
            (identical(other.accessDenied, accessDenied) || other.accessDenied == accessDenied) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isAuthenticated,
    isClient,
    needsOrganizationSetup,
    accessDenied,
    errorMessage,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState({
    final bool isLoading,
    final bool isAuthenticated,
    final bool isClient,
    final bool needsOrganizationSetup,
    final bool accessDenied,
    final String? errorMessage,
  }) = _$AuthStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isAuthenticated;
  @override
  bool get isClient;
  @override
  bool get needsOrganizationSetup;
  @override
  bool get accessDenied;
  @override
  String? get errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith => throw _privateConstructorUsedError;
}
