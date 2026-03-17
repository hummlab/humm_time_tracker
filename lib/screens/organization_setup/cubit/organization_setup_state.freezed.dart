// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_setup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrganizationSetupState {
  List<Organization> get organizations => throw _privateConstructorUsedError;
  List<OrganizationInvite> get invites => throw _privateConstructorUsedError;
  bool get isLoadingOrganizations => throw _privateConstructorUsedError;
  bool get isLoadingInvites => throw _privateConstructorUsedError;
  bool get isSigningOut => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationSetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationSetupStateCopyWith<OrganizationSetupState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationSetupStateCopyWith<$Res> {
  factory $OrganizationSetupStateCopyWith(OrganizationSetupState value, $Res Function(OrganizationSetupState) then) =
      _$OrganizationSetupStateCopyWithImpl<$Res, OrganizationSetupState>;
  @useResult
  $Res call({
    List<Organization> organizations,
    List<OrganizationInvite> invites,
    bool isLoadingOrganizations,
    bool isLoadingInvites,
    bool isSigningOut,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class _$OrganizationSetupStateCopyWithImpl<$Res, $Val extends OrganizationSetupState>
    implements $OrganizationSetupStateCopyWith<$Res> {
  _$OrganizationSetupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationSetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizations = null,
    Object? invites = null,
    Object? isLoadingOrganizations = null,
    Object? isLoadingInvites = null,
    Object? isSigningOut = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            organizations:
                null == organizations
                    ? _value.organizations
                    : organizations // ignore: cast_nullable_to_non_nullable
                        as List<Organization>,
            invites:
                null == invites
                    ? _value.invites
                    : invites // ignore: cast_nullable_to_non_nullable
                        as List<OrganizationInvite>,
            isLoadingOrganizations:
                null == isLoadingOrganizations
                    ? _value.isLoadingOrganizations
                    : isLoadingOrganizations // ignore: cast_nullable_to_non_nullable
                        as bool,
            isLoadingInvites:
                null == isLoadingInvites
                    ? _value.isLoadingInvites
                    : isLoadingInvites // ignore: cast_nullable_to_non_nullable
                        as bool,
            isSigningOut:
                null == isSigningOut
                    ? _value.isSigningOut
                    : isSigningOut // ignore: cast_nullable_to_non_nullable
                        as bool,
            toastMessage:
                freezed == toastMessage
                    ? _value.toastMessage
                    : toastMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
            toastType:
                freezed == toastType
                    ? _value.toastType
                    : toastType // ignore: cast_nullable_to_non_nullable
                        as AppToastType?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrganizationSetupStateImplCopyWith<$Res> implements $OrganizationSetupStateCopyWith<$Res> {
  factory _$$OrganizationSetupStateImplCopyWith(
    _$OrganizationSetupStateImpl value,
    $Res Function(_$OrganizationSetupStateImpl) then,
  ) = __$$OrganizationSetupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Organization> organizations,
    List<OrganizationInvite> invites,
    bool isLoadingOrganizations,
    bool isLoadingInvites,
    bool isSigningOut,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class __$$OrganizationSetupStateImplCopyWithImpl<$Res>
    extends _$OrganizationSetupStateCopyWithImpl<$Res, _$OrganizationSetupStateImpl>
    implements _$$OrganizationSetupStateImplCopyWith<$Res> {
  __$$OrganizationSetupStateImplCopyWithImpl(
    _$OrganizationSetupStateImpl _value,
    $Res Function(_$OrganizationSetupStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrganizationSetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizations = null,
    Object? invites = null,
    Object? isLoadingOrganizations = null,
    Object? isLoadingInvites = null,
    Object? isSigningOut = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$OrganizationSetupStateImpl(
        organizations:
            null == organizations
                ? _value._organizations
                : organizations // ignore: cast_nullable_to_non_nullable
                    as List<Organization>,
        invites:
            null == invites
                ? _value._invites
                : invites // ignore: cast_nullable_to_non_nullable
                    as List<OrganizationInvite>,
        isLoadingOrganizations:
            null == isLoadingOrganizations
                ? _value.isLoadingOrganizations
                : isLoadingOrganizations // ignore: cast_nullable_to_non_nullable
                    as bool,
        isLoadingInvites:
            null == isLoadingInvites
                ? _value.isLoadingInvites
                : isLoadingInvites // ignore: cast_nullable_to_non_nullable
                    as bool,
        isSigningOut:
            null == isSigningOut
                ? _value.isSigningOut
                : isSigningOut // ignore: cast_nullable_to_non_nullable
                    as bool,
        toastMessage:
            freezed == toastMessage
                ? _value.toastMessage
                : toastMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
        toastType:
            freezed == toastType
                ? _value.toastType
                : toastType // ignore: cast_nullable_to_non_nullable
                    as AppToastType?,
      ),
    );
  }
}

/// @nodoc

class _$OrganizationSetupStateImpl implements _OrganizationSetupState {
  const _$OrganizationSetupStateImpl({
    final List<Organization> organizations = const [],
    final List<OrganizationInvite> invites = const [],
    this.isLoadingOrganizations = false,
    this.isLoadingInvites = false,
    this.isSigningOut = false,
    this.toastMessage,
    this.toastType,
  }) : _organizations = organizations,
       _invites = invites;

  final List<Organization> _organizations;
  @override
  @JsonKey()
  List<Organization> get organizations {
    if (_organizations is EqualUnmodifiableListView) return _organizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_organizations);
  }

  final List<OrganizationInvite> _invites;
  @override
  @JsonKey()
  List<OrganizationInvite> get invites {
    if (_invites is EqualUnmodifiableListView) return _invites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invites);
  }

  @override
  @JsonKey()
  final bool isLoadingOrganizations;
  @override
  @JsonKey()
  final bool isLoadingInvites;
  @override
  @JsonKey()
  final bool isSigningOut;
  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;

  @override
  String toString() {
    return 'OrganizationSetupState(organizations: $organizations, invites: $invites, isLoadingOrganizations: $isLoadingOrganizations, isLoadingInvites: $isLoadingInvites, isSigningOut: $isSigningOut, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationSetupStateImpl &&
            const DeepCollectionEquality().equals(other._organizations, _organizations) &&
            const DeepCollectionEquality().equals(other._invites, _invites) &&
            (identical(other.isLoadingOrganizations, isLoadingOrganizations) ||
                other.isLoadingOrganizations == isLoadingOrganizations) &&
            (identical(other.isLoadingInvites, isLoadingInvites) || other.isLoadingInvites == isLoadingInvites) &&
            (identical(other.isSigningOut, isSigningOut) || other.isSigningOut == isSigningOut) &&
            (identical(other.toastMessage, toastMessage) || other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) || other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_organizations),
    const DeepCollectionEquality().hash(_invites),
    isLoadingOrganizations,
    isLoadingInvites,
    isSigningOut,
    toastMessage,
    toastType,
  );

  /// Create a copy of OrganizationSetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationSetupStateImplCopyWith<_$OrganizationSetupStateImpl> get copyWith =>
      __$$OrganizationSetupStateImplCopyWithImpl<_$OrganizationSetupStateImpl>(this, _$identity);
}

abstract class _OrganizationSetupState implements OrganizationSetupState {
  const factory _OrganizationSetupState({
    final List<Organization> organizations,
    final List<OrganizationInvite> invites,
    final bool isLoadingOrganizations,
    final bool isLoadingInvites,
    final bool isSigningOut,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$OrganizationSetupStateImpl;

  @override
  List<Organization> get organizations;
  @override
  List<OrganizationInvite> get invites;
  @override
  bool get isLoadingOrganizations;
  @override
  bool get isLoadingInvites;
  @override
  bool get isSigningOut;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of OrganizationSetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationSetupStateImplCopyWith<_$OrganizationSetupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
