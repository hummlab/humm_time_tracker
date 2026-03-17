// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrganizationInvite _$OrganizationInviteFromJson(Map<String, dynamic> json) {
  return _OrganizationInvite.fromJson(json);
}

/// @nodoc
mixin _$OrganizationInvite {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get organizationName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson)
  OrganizationRole get role => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this OrganizationInvite to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationInvite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationInviteCopyWith<OrganizationInvite> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationInviteCopyWith<$Res> {
  factory $OrganizationInviteCopyWith(OrganizationInvite value, $Res Function(OrganizationInvite) then) =
      _$OrganizationInviteCopyWithImpl<$Res, OrganizationInvite>;
  @useResult
  $Res call({
    String id,
    String organizationId,
    String organizationName,
    String email,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) OrganizationRole role,
    String status,
    @FirestoreDateTimeConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$OrganizationInviteCopyWithImpl<$Res, $Val extends OrganizationInvite>
    implements $OrganizationInviteCopyWith<$Res> {
  _$OrganizationInviteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationInvite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? organizationName = null,
    Object? email = null,
    Object? role = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            organizationId:
                null == organizationId
                    ? _value.organizationId
                    : organizationId // ignore: cast_nullable_to_non_nullable
                        as String,
            organizationName:
                null == organizationName
                    ? _value.organizationName
                    : organizationName // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            role:
                null == role
                    ? _value.role
                    : role // ignore: cast_nullable_to_non_nullable
                        as OrganizationRole,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrganizationInviteImplCopyWith<$Res> implements $OrganizationInviteCopyWith<$Res> {
  factory _$$OrganizationInviteImplCopyWith(
    _$OrganizationInviteImpl value,
    $Res Function(_$OrganizationInviteImpl) then,
  ) = __$$OrganizationInviteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String organizationId,
    String organizationName,
    String email,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) OrganizationRole role,
    String status,
    @FirestoreDateTimeConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$OrganizationInviteImplCopyWithImpl<$Res>
    extends _$OrganizationInviteCopyWithImpl<$Res, _$OrganizationInviteImpl>
    implements _$$OrganizationInviteImplCopyWith<$Res> {
  __$$OrganizationInviteImplCopyWithImpl(_$OrganizationInviteImpl _value, $Res Function(_$OrganizationInviteImpl) _then)
    : super(_value, _then);

  /// Create a copy of OrganizationInvite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? organizationName = null,
    Object? email = null,
    Object? role = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$OrganizationInviteImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        organizationId:
            null == organizationId
                ? _value.organizationId
                : organizationId // ignore: cast_nullable_to_non_nullable
                    as String,
        organizationName:
            null == organizationName
                ? _value.organizationName
                : organizationName // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        role:
            null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                    as OrganizationRole,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationInviteImpl extends _OrganizationInvite {
  const _$OrganizationInviteImpl({
    required this.id,
    required this.organizationId,
    required this.organizationName,
    required this.email,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) required this.role,
    required this.status,
    @FirestoreDateTimeConverter() required this.createdAt,
  }) : super._();

  factory _$OrganizationInviteImpl.fromJson(Map<String, dynamic> json) => _$$OrganizationInviteImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String organizationName;
  @override
  final String email;
  @override
  @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson)
  final OrganizationRole role;
  @override
  final String status;
  @override
  @FirestoreDateTimeConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'OrganizationInvite(id: $id, organizationId: $organizationId, organizationName: $organizationName, email: $email, role: $role, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationInviteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) || other.organizationId == organizationId) &&
            (identical(other.organizationName, organizationName) || other.organizationName == organizationName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, organizationId, organizationName, email, role, status, createdAt);

  /// Create a copy of OrganizationInvite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationInviteImplCopyWith<_$OrganizationInviteImpl> get copyWith =>
      __$$OrganizationInviteImplCopyWithImpl<_$OrganizationInviteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationInviteImplToJson(this);
  }
}

abstract class _OrganizationInvite extends OrganizationInvite {
  const factory _OrganizationInvite({
    required final String id,
    required final String organizationId,
    required final String organizationName,
    required final String email,
    @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson) required final OrganizationRole role,
    required final String status,
    @FirestoreDateTimeConverter() required final DateTime createdAt,
  }) = _$OrganizationInviteImpl;
  const _OrganizationInvite._() : super._();

  factory _OrganizationInvite.fromJson(Map<String, dynamic> json) = _$OrganizationInviteImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get organizationName;
  @override
  String get email;
  @override
  @JsonKey(fromJson: _organizationRoleFromJson, toJson: _organizationRoleToJson)
  OrganizationRole get role;
  @override
  String get status;
  @override
  @FirestoreDateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of OrganizationInvite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationInviteImplCopyWith<_$OrganizationInviteImpl> get copyWith => throw _privateConstructorUsedError;
}
