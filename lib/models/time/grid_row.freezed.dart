// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grid_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GridRow _$GridRowFromJson(Map<String, dynamic> json) {
  return _GridRow.fromJson(json);
}

/// @nodoc
mixin _$GridRow {
  String get description => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;
  List<String> get tagIds => throw _privateConstructorUsedError;
  List<int> get dayMinutes => throw _privateConstructorUsedError;
  List<List<String>> get dayEntryIds => throw _privateConstructorUsedError;

  /// Serializes this GridRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GridRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GridRowCopyWith<GridRow> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GridRowCopyWith<$Res> {
  factory $GridRowCopyWith(GridRow value, $Res Function(GridRow) then) = _$GridRowCopyWithImpl<$Res, GridRow>;
  @useResult
  $Res call({
    String description,
    String? projectId,
    List<String> tagIds,
    List<int> dayMinutes,
    List<List<String>> dayEntryIds,
  });
}

/// @nodoc
class _$GridRowCopyWithImpl<$Res, $Val extends GridRow> implements $GridRowCopyWith<$Res> {
  _$GridRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GridRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? projectId = freezed,
    Object? tagIds = null,
    Object? dayMinutes = null,
    Object? dayEntryIds = null,
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
            dayMinutes:
                null == dayMinutes
                    ? _value.dayMinutes
                    : dayMinutes // ignore: cast_nullable_to_non_nullable
                        as List<int>,
            dayEntryIds:
                null == dayEntryIds
                    ? _value.dayEntryIds
                    : dayEntryIds // ignore: cast_nullable_to_non_nullable
                        as List<List<String>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GridRowImplCopyWith<$Res> implements $GridRowCopyWith<$Res> {
  factory _$$GridRowImplCopyWith(_$GridRowImpl value, $Res Function(_$GridRowImpl) then) =
      __$$GridRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String description,
    String? projectId,
    List<String> tagIds,
    List<int> dayMinutes,
    List<List<String>> dayEntryIds,
  });
}

/// @nodoc
class __$$GridRowImplCopyWithImpl<$Res> extends _$GridRowCopyWithImpl<$Res, _$GridRowImpl>
    implements _$$GridRowImplCopyWith<$Res> {
  __$$GridRowImplCopyWithImpl(_$GridRowImpl _value, $Res Function(_$GridRowImpl) _then) : super(_value, _then);

  /// Create a copy of GridRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? projectId = freezed,
    Object? tagIds = null,
    Object? dayMinutes = null,
    Object? dayEntryIds = null,
  }) {
    return _then(
      _$GridRowImpl(
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
        dayMinutes:
            null == dayMinutes
                ? _value._dayMinutes
                : dayMinutes // ignore: cast_nullable_to_non_nullable
                    as List<int>,
        dayEntryIds:
            null == dayEntryIds
                ? _value._dayEntryIds
                : dayEntryIds // ignore: cast_nullable_to_non_nullable
                    as List<List<String>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GridRowImpl extends _GridRow {
  const _$GridRowImpl({
    required this.description,
    this.projectId,
    final List<String> tagIds = const [],
    final List<int> dayMinutes = const [],
    final List<List<String>> dayEntryIds = const [],
  }) : _tagIds = tagIds,
       _dayMinutes = dayMinutes,
       _dayEntryIds = dayEntryIds,
       super._();

  factory _$GridRowImpl.fromJson(Map<String, dynamic> json) => _$$GridRowImplFromJson(json);

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

  final List<int> _dayMinutes;
  @override
  @JsonKey()
  List<int> get dayMinutes {
    if (_dayMinutes is EqualUnmodifiableListView) return _dayMinutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dayMinutes);
  }

  final List<List<String>> _dayEntryIds;
  @override
  @JsonKey()
  List<List<String>> get dayEntryIds {
    if (_dayEntryIds is EqualUnmodifiableListView) return _dayEntryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dayEntryIds);
  }

  @override
  String toString() {
    return 'GridRow(description: $description, projectId: $projectId, tagIds: $tagIds, dayMinutes: $dayMinutes, dayEntryIds: $dayEntryIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GridRowImpl &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.projectId, projectId) || other.projectId == projectId) &&
            const DeepCollectionEquality().equals(other._tagIds, _tagIds) &&
            const DeepCollectionEquality().equals(other._dayMinutes, _dayMinutes) &&
            const DeepCollectionEquality().equals(other._dayEntryIds, _dayEntryIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    description,
    projectId,
    const DeepCollectionEquality().hash(_tagIds),
    const DeepCollectionEquality().hash(_dayMinutes),
    const DeepCollectionEquality().hash(_dayEntryIds),
  );

  /// Create a copy of GridRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GridRowImplCopyWith<_$GridRowImpl> get copyWith => __$$GridRowImplCopyWithImpl<_$GridRowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GridRowImplToJson(this);
  }
}

abstract class _GridRow extends GridRow {
  const factory _GridRow({
    required final String description,
    final String? projectId,
    final List<String> tagIds,
    final List<int> dayMinutes,
    final List<List<String>> dayEntryIds,
  }) = _$GridRowImpl;
  const _GridRow._() : super._();

  factory _GridRow.fromJson(Map<String, dynamic> json) = _$GridRowImpl.fromJson;

  @override
  String get description;
  @override
  String? get projectId;
  @override
  List<String> get tagIds;
  @override
  List<int> get dayMinutes;
  @override
  List<List<String>> get dayEntryIds;

  /// Create a copy of GridRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GridRowImplCopyWith<_$GridRowImpl> get copyWith => throw _privateConstructorUsedError;
}
