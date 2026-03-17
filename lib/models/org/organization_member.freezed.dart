// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrganizationMember _$OrganizationMemberFromJson(Map<String, dynamic> json) {
  return _OrganizationMember.fromJson(json);
}

/// @nodoc
mixin _$OrganizationMember {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson)
  OrganizationRole get role => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get invitedByUserId => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this OrganizationMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationMemberCopyWith<OrganizationMember> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationMemberCopyWith<$Res> {
  factory $OrganizationMemberCopyWith(OrganizationMember value, $Res Function(OrganizationMember) then) =
      _$OrganizationMemberCopyWithImpl<$Res, OrganizationMember>;
  @useResult
  $Res call({
    String id,
    String userId,
    String email,
    String? displayName,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) OrganizationRole role,
    @FirestoreDateTimeConverter() DateTime createdAt,
    String? invitedByUserId,
    bool isActive,
  });
}

/// @nodoc
class _$OrganizationMemberCopyWithImpl<$Res, $Val extends OrganizationMember>
    implements $OrganizationMemberCopyWith<$Res> {
  _$OrganizationMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? role = null,
    Object? createdAt = null,
    Object? invitedByUserId = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            displayName:
                freezed == displayName
                    ? _value.displayName
                    : displayName // ignore: cast_nullable_to_non_nullable
                        as String?,
            role:
                null == role
                    ? _value.role
                    : role // ignore: cast_nullable_to_non_nullable
                        as OrganizationRole,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            invitedByUserId:
                freezed == invitedByUserId
                    ? _value.invitedByUserId
                    : invitedByUserId // ignore: cast_nullable_to_non_nullable
                        as String?,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrganizationMemberImplCopyWith<$Res> implements $OrganizationMemberCopyWith<$Res> {
  factory _$$OrganizationMemberImplCopyWith(
    _$OrganizationMemberImpl value,
    $Res Function(_$OrganizationMemberImpl) then,
  ) = __$$OrganizationMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String email,
    String? displayName,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) OrganizationRole role,
    @FirestoreDateTimeConverter() DateTime createdAt,
    String? invitedByUserId,
    bool isActive,
  });
}

/// @nodoc
class __$$OrganizationMemberImplCopyWithImpl<$Res>
    extends _$OrganizationMemberCopyWithImpl<$Res, _$OrganizationMemberImpl>
    implements _$$OrganizationMemberImplCopyWith<$Res> {
  __$$OrganizationMemberImplCopyWithImpl(_$OrganizationMemberImpl _value, $Res Function(_$OrganizationMemberImpl) _then)
    : super(_value, _then);

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? role = null,
    Object? createdAt = null,
    Object? invitedByUserId = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$OrganizationMemberImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        displayName:
            freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                    as String?,
        role:
            null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                    as OrganizationRole,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        invitedByUserId:
            freezed == invitedByUserId
                ? _value.invitedByUserId
                : invitedByUserId // ignore: cast_nullable_to_non_nullable
                    as String?,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationMemberImpl extends _OrganizationMember {
  const _$OrganizationMemberImpl({
    required this.id,
    required this.userId,
    required this.email,
    this.displayName,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) required this.role,
    @FirestoreDateTimeConverter() required this.createdAt,
    this.invitedByUserId,
    this.isActive = true,
  }) : super._();

  factory _$OrganizationMemberImpl.fromJson(Map<String, dynamic> json) => _$$OrganizationMemberImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson)
  final OrganizationRole role;
  @override
  @FirestoreDateTimeConverter()
  final DateTime createdAt;
  @override
  final String? invitedByUserId;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'OrganizationMember(id: $id, userId: $userId, email: $email, displayName: $displayName, role: $role, createdAt: $createdAt, invitedByUserId: $invitedByUserId, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) || other.displayName == displayName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.invitedByUserId, invitedByUserId) || other.invitedByUserId == invitedByUserId) &&
            (identical(other.isActive, isActive) || other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, email, displayName, role, createdAt, invitedByUserId, isActive);

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationMemberImplCopyWith<_$OrganizationMemberImpl> get copyWith =>
      __$$OrganizationMemberImplCopyWithImpl<_$OrganizationMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationMemberImplToJson(this);
  }
}

abstract class _OrganizationMember extends OrganizationMember {
  const factory _OrganizationMember({
    required final String id,
    required final String userId,
    required final String email,
    final String? displayName,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) required final OrganizationRole role,
    @FirestoreDateTimeConverter() required final DateTime createdAt,
    final String? invitedByUserId,
    final bool isActive,
  }) = _$OrganizationMemberImpl;
  const _OrganizationMember._() : super._();

  factory _OrganizationMember.fromJson(Map<String, dynamic> json) = _$OrganizationMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson)
  OrganizationRole get role;
  @override
  @FirestoreDateTimeConverter()
  DateTime get createdAt;
  @override
  String? get invitedByUserId;
  @override
  bool get isActive;

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationMemberImplCopyWith<_$OrganizationMemberImpl> get copyWith => throw _privateConstructorUsedError;
}
