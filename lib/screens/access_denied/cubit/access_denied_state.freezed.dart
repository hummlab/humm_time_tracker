// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'access_denied_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AccessDeniedState {
  String get email => throw _privateConstructorUsedError;

  /// Create a copy of AccessDeniedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccessDeniedStateCopyWith<AccessDeniedState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessDeniedStateCopyWith<$Res> {
  factory $AccessDeniedStateCopyWith(AccessDeniedState value, $Res Function(AccessDeniedState) then) =
      _$AccessDeniedStateCopyWithImpl<$Res, AccessDeniedState>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$AccessDeniedStateCopyWithImpl<$Res, $Val extends AccessDeniedState>
    implements $AccessDeniedStateCopyWith<$Res> {
  _$AccessDeniedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccessDeniedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _value.copyWith(
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccessDeniedStateImplCopyWith<$Res> implements $AccessDeniedStateCopyWith<$Res> {
  factory _$$AccessDeniedStateImplCopyWith(_$AccessDeniedStateImpl value, $Res Function(_$AccessDeniedStateImpl) then) =
      __$$AccessDeniedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$AccessDeniedStateImplCopyWithImpl<$Res> extends _$AccessDeniedStateCopyWithImpl<$Res, _$AccessDeniedStateImpl>
    implements _$$AccessDeniedStateImplCopyWith<$Res> {
  __$$AccessDeniedStateImplCopyWithImpl(_$AccessDeniedStateImpl _value, $Res Function(_$AccessDeniedStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of AccessDeniedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$AccessDeniedStateImpl(
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$AccessDeniedStateImpl implements _AccessDeniedState {
  const _$AccessDeniedStateImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'AccessDeniedState(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessDeniedStateImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AccessDeniedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessDeniedStateImplCopyWith<_$AccessDeniedStateImpl> get copyWith =>
      __$$AccessDeniedStateImplCopyWithImpl<_$AccessDeniedStateImpl>(this, _$identity);
}

abstract class _AccessDeniedState implements AccessDeniedState {
  const factory _AccessDeniedState({required final String email}) = _$AccessDeniedStateImpl;

  @override
  String get email;

  /// Create a copy of AccessDeniedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccessDeniedStateImplCopyWith<_$AccessDeniedStateImpl> get copyWith => throw _privateConstructorUsedError;
}
