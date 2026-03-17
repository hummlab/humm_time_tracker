// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  List<String> get teamMemberIds => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  List<String> get clickUpListIds => throw _privateConstructorUsedError;

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) = _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? clientId,
    List<String> teamMemberIds,
    String color,
    @FirestoreDateTimeConverter() DateTime createdAt,
    bool isActive,
    List<String> clickUpListIds,
  });
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project> implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? clientId = freezed,
    Object? teamMemberIds = null,
    Object? color = null,
    Object? createdAt = null,
    Object? isActive = null,
    Object? clickUpListIds = null,
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
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            clientId:
                freezed == clientId
                    ? _value.clientId
                    : clientId // ignore: cast_nullable_to_non_nullable
                        as String?,
            teamMemberIds:
                null == teamMemberIds
                    ? _value.teamMemberIds
                    : teamMemberIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            color:
                null == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            clickUpListIds:
                null == clickUpListIds
                    ? _value.clickUpListIds
                    : clickUpListIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(_$ProjectImpl value, $Res Function(_$ProjectImpl) then) =
      __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? clientId,
    List<String> teamMemberIds,
    String color,
    @FirestoreDateTimeConverter() DateTime createdAt,
    bool isActive,
    List<String> clickUpListIds,
  });
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res> extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(_$ProjectImpl _value, $Res Function(_$ProjectImpl) _then) : super(_value, _then);

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? clientId = freezed,
    Object? teamMemberIds = null,
    Object? color = null,
    Object? createdAt = null,
    Object? isActive = null,
    Object? clickUpListIds = null,
  }) {
    return _then(
      _$ProjectImpl(
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
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        clientId:
            freezed == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                    as String?,
        teamMemberIds:
            null == teamMemberIds
                ? _value._teamMemberIds
                : teamMemberIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        color:
            null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        clickUpListIds:
            null == clickUpListIds
                ? _value._clickUpListIds
                : clickUpListIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl extends _Project {
  const _$ProjectImpl({
    required this.id,
    required this.name,
    this.description,
    this.clientId,
    final List<String> teamMemberIds = const [],
    this.color = '#6366F1',
    @FirestoreDateTimeConverter() required this.createdAt,
    this.isActive = true,
    final List<String> clickUpListIds = const [],
  }) : _teamMemberIds = teamMemberIds,
       _clickUpListIds = clickUpListIds,
       super._();

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) => _$$ProjectImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? clientId;
  final List<String> _teamMemberIds;
  @override
  @JsonKey()
  List<String> get teamMemberIds {
    if (_teamMemberIds is EqualUnmodifiableListView) return _teamMemberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamMemberIds);
  }

  @override
  @JsonKey()
  final String color;
  @override
  @FirestoreDateTimeConverter()
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isActive;
  final List<String> _clickUpListIds;
  @override
  @JsonKey()
  List<String> get clickUpListIds {
    if (_clickUpListIds is EqualUnmodifiableListView) return _clickUpListIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clickUpListIds);
  }

  @override
  String toString() {
    return 'Project(id: $id, name: $name, description: $description, clientId: $clientId, teamMemberIds: $teamMemberIds, color: $color, createdAt: $createdAt, isActive: $isActive, clickUpListIds: $clickUpListIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.clientId, clientId) || other.clientId == clientId) &&
            const DeepCollectionEquality().equals(other._teamMemberIds, _teamMemberIds) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.isActive, isActive) || other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._clickUpListIds, _clickUpListIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    clientId,
    const DeepCollectionEquality().hash(_teamMemberIds),
    color,
    createdAt,
    isActive,
    const DeepCollectionEquality().hash(_clickUpListIds),
  );

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith => __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(this);
  }
}

abstract class _Project extends Project {
  const factory _Project({
    required final String id,
    required final String name,
    final String? description,
    final String? clientId,
    final List<String> teamMemberIds,
    final String color,
    @FirestoreDateTimeConverter() required final DateTime createdAt,
    final bool isActive,
    final List<String> clickUpListIds,
  }) = _$ProjectImpl;
  const _Project._() : super._();

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get clientId;
  @override
  List<String> get teamMemberIds;
  @override
  String get color;
  @override
  @FirestoreDateTimeConverter()
  DateTime get createdAt;
  @override
  bool get isActive;
  @override
  List<String> get clickUpListIds;

  /// Create a copy of Project
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith => throw _privateConstructorUsedError;
}
