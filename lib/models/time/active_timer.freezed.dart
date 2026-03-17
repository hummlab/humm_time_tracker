// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActiveTimer _$ActiveTimerFromJson(Map<String, dynamic> json) {
  return _ActiveTimer.fromJson(json);
}

/// @nodoc
mixin _$ActiveTimer {
  String get description => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;
  List<String> get tagIds => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get startTime => throw _privateConstructorUsedError;
  int? get targetMinutes => throw _privateConstructorUsedError;

  /// Serializes this ActiveTimer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveTimer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveTimerCopyWith<ActiveTimer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveTimerCopyWith<$Res> {
  factory $ActiveTimerCopyWith(ActiveTimer value, $Res Function(ActiveTimer) then) =
      _$ActiveTimerCopyWithImpl<$Res, ActiveTimer>;
  @useResult
  $Res call({
    String description,
    String? projectId,
    List<String> tagIds,
    @FirestoreDateTimeConverter() DateTime startTime,
    int? targetMinutes,
  });
}

/// @nodoc
class _$ActiveTimerCopyWithImpl<$Res, $Val extends ActiveTimer> implements $ActiveTimerCopyWith<$Res> {
  _$ActiveTimerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveTimer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? projectId = freezed,
    Object? tagIds = null,
    Object? startTime = null,
    Object? targetMinutes = freezed,
  }) {
    return _then(
      _value.copyWith(
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            projectId:
                freezed == projectId
                    ? _value.projectId
                    : projectId // ignore: cast_nullable_to_non_nullable
                        as String?,
            tagIds:
                null == tagIds
                    ? _value.tagIds
                    : tagIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            startTime:
                null == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            targetMinutes:
                freezed == targetMinutes
                    ? _value.targetMinutes
                    : targetMinutes // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActiveTimerImplCopyWith<$Res> implements $ActiveTimerCopyWith<$Res> {
  factory _$$ActiveTimerImplCopyWith(_$ActiveTimerImpl value, $Res Function(_$ActiveTimerImpl) then) =
      __$$ActiveTimerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String description,
    String? projectId,
    List<String> tagIds,
    @FirestoreDateTimeConverter() DateTime startTime,
    int? targetMinutes,
  });
}

/// @nodoc
class __$$ActiveTimerImplCopyWithImpl<$Res> extends _$ActiveTimerCopyWithImpl<$Res, _$ActiveTimerImpl>
    implements _$$ActiveTimerImplCopyWith<$Res> {
  __$$ActiveTimerImplCopyWithImpl(_$ActiveTimerImpl _value, $Res Function(_$ActiveTimerImpl) _then)
    : super(_value, _then);

  /// Create a copy of ActiveTimer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? projectId = freezed,
    Object? tagIds = null,
    Object? startTime = null,
    Object? targetMinutes = freezed,
  }) {
    return _then(
      _$ActiveTimerImpl(
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        projectId:
            freezed == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                    as String?,
        tagIds:
            null == tagIds
                ? _value._tagIds
                : tagIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        startTime:
            null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        targetMinutes:
            freezed == targetMinutes
                ? _value.targetMinutes
                : targetMinutes // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveTimerImpl extends _ActiveTimer {
  const _$ActiveTimerImpl({
    required this.description,
    this.projectId,
    final List<String> tagIds = const [],
    @FirestoreDateTimeConverter() required this.startTime,
    this.targetMinutes,
  }) : _tagIds = tagIds,
       super._();

  factory _$ActiveTimerImpl.fromJson(Map<String, dynamic> json) => _$$ActiveTimerImplFromJson(json);

  @override
  final String description;
  @override
  final String? projectId;
  final List<String> _tagIds;
  @override
  @JsonKey()
  List<String> get tagIds {
    if (_tagIds is EqualUnmodifiableListView) return _tagIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagIds);
  }

  @override
  @FirestoreDateTimeConverter()
  final DateTime startTime;
  @override
  final int? targetMinutes;

  @override
  String toString() {
    return 'ActiveTimer(description: $description, projectId: $projectId, tagIds: $tagIds, startTime: $startTime, targetMinutes: $targetMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveTimerImpl &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.projectId, projectId) || other.projectId == projectId) &&
            const DeepCollectionEquality().equals(other._tagIds, _tagIds) &&
            (identical(other.startTime, startTime) || other.startTime == startTime) &&
            (identical(other.targetMinutes, targetMinutes) || other.targetMinutes == targetMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    description,
    projectId,
    const DeepCollectionEquality().hash(_tagIds),
    startTime,
    targetMinutes,
  );

  /// Create a copy of ActiveTimer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveTimerImplCopyWith<_$ActiveTimerImpl> get copyWith =>
      __$$ActiveTimerImplCopyWithImpl<_$ActiveTimerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveTimerImplToJson(this);
  }
}

abstract class _ActiveTimer extends ActiveTimer {
  const factory _ActiveTimer({
    required final String description,
    final String? projectId,
    final List<String> tagIds,
    @FirestoreDateTimeConverter() required final DateTime startTime,
    final int? targetMinutes,
  }) = _$ActiveTimerImpl;
  const _ActiveTimer._() : super._();

  factory _ActiveTimer.fromJson(Map<String, dynamic> json) = _$ActiveTimerImpl.fromJson;

  @override
  String get description;
  @override
  String? get projectId;
  @override
  List<String> get tagIds;
  @override
  @FirestoreDateTimeConverter()
  DateTime get startTime;
  @override
  int? get targetMinutes;

  /// Create a copy of ActiveTimer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveTimerImplCopyWith<_$ActiveTimerImpl> get copyWith => throw _privateConstructorUsedError;
}
