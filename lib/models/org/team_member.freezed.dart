// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TeamMember _$TeamMemberFromJson(Map<String, dynamic> json) {
  return _TeamMember.fromJson(json);
}

/// @nodoc
mixin _$TeamMember {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson)
  TeamMemberRole get role => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get firebaseUid => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TeamMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamMemberCopyWith<TeamMember> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMemberCopyWith<$Res> {
  factory $TeamMemberCopyWith(TeamMember value, $Res Function(TeamMember) then) =
      _$TeamMemberCopyWithImpl<$Res, TeamMember>;
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson) TeamMemberRole role,
    String? avatarUrl,
    String userId,
    String? firebaseUid,
    @FirestoreDateTimeConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$TeamMemberCopyWithImpl<$Res, $Val extends TeamMember> implements $TeamMemberCopyWith<$Res> {
  _$TeamMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? avatarUrl = freezed,
    Object? userId = null,
    Object? firebaseUid = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
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
            avatarUrl:
                freezed == avatarUrl
                    ? _value.avatarUrl
                    : avatarUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            firebaseUid:
                freezed == firebaseUid
                    ? _value.firebaseUid
                    : firebaseUid // ignore: cast_nullable_to_non_nullable
                        as String?,
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
abstract class _$$TeamMemberImplCopyWith<$Res> implements $TeamMemberCopyWith<$Res> {
  factory _$$TeamMemberImplCopyWith(_$TeamMemberImpl value, $Res Function(_$TeamMemberImpl) then) =
      __$$TeamMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson) TeamMemberRole role,
    String? avatarUrl,
    String userId,
    String? firebaseUid,
    @FirestoreDateTimeConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$TeamMemberImplCopyWithImpl<$Res> extends _$TeamMemberCopyWithImpl<$Res, _$TeamMemberImpl>
    implements _$$TeamMemberImplCopyWith<$Res> {
  __$$TeamMemberImplCopyWithImpl(_$TeamMemberImpl _value, $Res Function(_$TeamMemberImpl) _then) : super(_value, _then);

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? avatarUrl = freezed,
    Object? userId = null,
    Object? firebaseUid = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$TeamMemberImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
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
        avatarUrl:
            freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        firebaseUid:
            freezed == firebaseUid
                ? _value.firebaseUid
                : firebaseUid // ignore: cast_nullable_to_non_nullable
                    as String?,
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
class _$TeamMemberImpl extends _TeamMember {
  const _$TeamMemberImpl({
    required this.id,
    required this.name,
    required this.email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson) this.role = TeamMemberRole.regular,
    this.avatarUrl,
    required this.userId,
    this.firebaseUid,
    @FirestoreDateTimeConverter() required this.createdAt,
  }) : super._();

  factory _$TeamMemberImpl.fromJson(Map<String, dynamic> json) => _$$TeamMemberImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson)
  final TeamMemberRole role;
  @override
  final String? avatarUrl;
  @override
  final String userId;
  @override
  final String? firebaseUid;
  @override
  @FirestoreDateTimeConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'TeamMember(id: $id, name: $name, email: $email, role: $role, avatarUrl: $avatarUrl, userId: $userId, firebaseUid: $firebaseUid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, role, avatarUrl, userId, firebaseUid, createdAt);

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMemberImplCopyWith<_$TeamMemberImpl> get copyWith =>
      __$$TeamMemberImplCopyWithImpl<_$TeamMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMemberImplToJson(this);
  }
}

abstract class _TeamMember extends TeamMember {
  const factory _TeamMember({
    required final String id,
    required final String name,
    required final String email,
    @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson) final TeamMemberRole role,
    final String? avatarUrl,
    required final String userId,
    final String? firebaseUid,
    @FirestoreDateTimeConverter() required final DateTime createdAt,
  }) = _$TeamMemberImpl;
  const _TeamMember._() : super._();

  factory _TeamMember.fromJson(Map<String, dynamic> json) = _$TeamMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  @JsonKey(fromJson: _teamMemberRoleFromJson, toJson: _teamMemberRoleToJson)
  TeamMemberRole get role;
  @override
  String? get avatarUrl;
  @override
  String get userId;
  @override
  String? get firebaseUid;
  @override
  @FirestoreDateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamMemberImplCopyWith<_$TeamMemberImpl> get copyWith => throw _privateConstructorUsedError;
}
