// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson)
  TeamMemberRole get role => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get organizationIds => throw _privateConstructorUsedError;
  String? get defaultOrganizationId => throw _privateConstructorUsedError;
  String? get activeOrganizationId => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) = _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call({
    String id,
    String email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson) TeamMemberRole role,
    @FirestoreDateTimeConverter() DateTime createdAt,
    List<String> organizationIds,
    String? defaultOrganizationId,
    String? activeOrganizationId,
    String? clientId,
  });
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser> implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? createdAt = null,
    Object? organizationIds = null,
    Object? defaultOrganizationId = freezed,
    Object? activeOrganizationId = freezed,
    Object? clientId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
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
                        as TeamMemberRole,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            organizationIds:
                null == organizationIds
                    ? _value.organizationIds
                    : organizationIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            defaultOrganizationId:
                freezed == defaultOrganizationId
                    ? _value.defaultOrganizationId
                    : defaultOrganizationId // ignore: cast_nullable_to_non_nullable
                        as String?,
            activeOrganizationId:
                freezed == activeOrganizationId
                    ? _value.activeOrganizationId
                    : activeOrganizationId // ignore: cast_nullable_to_non_nullable
                        as String?,
            clientId:
                freezed == clientId
                    ? _value.clientId
                    : clientId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(_$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson) TeamMemberRole role,
    @FirestoreDateTimeConverter() DateTime createdAt,
    List<String> organizationIds,
    String? defaultOrganizationId,
    String? activeOrganizationId,
    String? clientId,
  });
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res> extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(_$AppUserImpl _value, $Res Function(_$AppUserImpl) _then) : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? createdAt = null,
    Object? organizationIds = null,
    Object? defaultOrganizationId = freezed,
    Object? activeOrganizationId = freezed,
    Object? clientId = freezed,
  }) {
    return _then(
      _$AppUserImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
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
                    as TeamMemberRole,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        organizationIds:
            null == organizationIds
                ? _value._organizationIds
                : organizationIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        defaultOrganizationId:
            freezed == defaultOrganizationId
                ? _value.defaultOrganizationId
                : defaultOrganizationId // ignore: cast_nullable_to_non_nullable
                    as String?,
        activeOrganizationId:
            freezed == activeOrganizationId
                ? _value.activeOrganizationId
                : activeOrganizationId // ignore: cast_nullable_to_non_nullable
                    as String?,
        clientId:
            freezed == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl extends _AppUser {
  const _$AppUserImpl({
    required this.id,
    required this.email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson) this.role = TeamMemberRole.regular,
    @FirestoreDateTimeConverter() required this.createdAt,
    final List<String> organizationIds = const [],
    this.defaultOrganizationId,
    this.activeOrganizationId,
    this.clientId,
  }) : _organizationIds = organizationIds,
       super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) => _$$AppUserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson)
  final TeamMemberRole role;
  @override
  @FirestoreDateTimeConverter()
  final DateTime createdAt;
  final List<String> _organizationIds;
  @override
  @JsonKey()
  List<String> get organizationIds {
    if (_organizationIds is EqualUnmodifiableListView) return _organizationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_organizationIds);
  }

  @override
  final String? defaultOrganizationId;
  @override
  final String? activeOrganizationId;
  @override
  final String? clientId;

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, role: $role, createdAt: $createdAt, organizationIds: $organizationIds, defaultOrganizationId: $defaultOrganizationId, activeOrganizationId: $activeOrganizationId, clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._organizationIds, _organizationIds) &&
            (identical(other.defaultOrganizationId, defaultOrganizationId) ||
                other.defaultOrganizationId == defaultOrganizationId) &&
            (identical(other.activeOrganizationId, activeOrganizationId) ||
                other.activeOrganizationId == activeOrganizationId) &&
            (identical(other.clientId, clientId) || other.clientId == clientId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    role,
    createdAt,
    const DeepCollectionEquality().hash(_organizationIds),
    defaultOrganizationId,
    activeOrganizationId,
    clientId,
  );

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith => __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(this);
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser({
    required final String id,
    required final String email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson) final TeamMemberRole role,
    @FirestoreDateTimeConverter() required final DateTime createdAt,
    final List<String> organizationIds,
    final String? defaultOrganizationId,
    final String? activeOrganizationId,
    final String? clientId,
  }) = _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson)
  TeamMemberRole get role;
  @override
  @FirestoreDateTimeConverter()
  DateTime get createdAt;
  @override
  List<String> get organizationIds;
  @override
  String? get defaultOrganizationId;
  @override
  String? get activeOrganizationId;
  @override
  String? get clientId;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith => throw _privateConstructorUsedError;
}
