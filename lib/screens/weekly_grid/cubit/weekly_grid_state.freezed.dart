// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_grid_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WeeklyGridState {
  DateTime get weekStart => throw _privateConstructorUsedError;
  List<GridRow> get rows => throw _privateConstructorUsedError;
  List<Project> get projects => throw _privateConstructorUsedError;
  String? get currentUserId => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyGridState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyGridStateCopyWith<WeeklyGridState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyGridStateCopyWith<$Res> {
  factory $WeeklyGridStateCopyWith(WeeklyGridState value, $Res Function(WeeklyGridState) then) =
      _$WeeklyGridStateCopyWithImpl<$Res, WeeklyGridState>;
  @useResult
  $Res call({DateTime weekStart, List<GridRow> rows, List<Project> projects, String? currentUserId});
}

/// @nodoc
class _$WeeklyGridStateCopyWithImpl<$Res, $Val extends WeeklyGridState> implements $WeeklyGridStateCopyWith<$Res> {
  _$WeeklyGridStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyGridState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? weekStart = null, Object? rows = null, Object? projects = null, Object? currentUserId = freezed}) {
    return _then(
      _value.copyWith(
            weekStart:
                null == weekStart
                    ? _value.weekStart
                    : weekStart // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            rows:
                null == rows
                    ? _value.rows
                    : rows // ignore: cast_nullable_to_non_nullable
                        as List<GridRow>,
            projects:
                null == projects
                    ? _value.projects
                    : projects // ignore: cast_nullable_to_non_nullable
                        as List<Project>,
            currentUserId:
                freezed == currentUserId
                    ? _value.currentUserId
                    : currentUserId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeeklyGridStateImplCopyWith<$Res> implements $WeeklyGridStateCopyWith<$Res> {
  factory _$$WeeklyGridStateImplCopyWith(_$WeeklyGridStateImpl value, $Res Function(_$WeeklyGridStateImpl) then) =
      __$$WeeklyGridStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime weekStart, List<GridRow> rows, List<Project> projects, String? currentUserId});
}

/// @nodoc
class __$$WeeklyGridStateImplCopyWithImpl<$Res> extends _$WeeklyGridStateCopyWithImpl<$Res, _$WeeklyGridStateImpl>
    implements _$$WeeklyGridStateImplCopyWith<$Res> {
  __$$WeeklyGridStateImplCopyWithImpl(_$WeeklyGridStateImpl _value, $Res Function(_$WeeklyGridStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of WeeklyGridState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? weekStart = null, Object? rows = null, Object? projects = null, Object? currentUserId = freezed}) {
    return _then(
      _$WeeklyGridStateImpl(
        weekStart:
            null == weekStart
                ? _value.weekStart
                : weekStart // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        rows:
            null == rows
                ? _value._rows
                : rows // ignore: cast_nullable_to_non_nullable
                    as List<GridRow>,
        projects:
            null == projects
                ? _value._projects
                : projects // ignore: cast_nullable_to_non_nullable
                    as List<Project>,
        currentUserId:
            freezed == currentUserId
                ? _value.currentUserId
                : currentUserId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$WeeklyGridStateImpl implements _WeeklyGridState {
  const _$WeeklyGridStateImpl({
    required this.weekStart,
    required final List<GridRow> rows,
    required final List<Project> projects,
    this.currentUserId,
  }) : _rows = rows,
       _projects = projects;

  @override
  final DateTime weekStart;
  final List<GridRow> _rows;
  @override
  List<GridRow> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  final String? currentUserId;

  @override
  String toString() {
    return 'WeeklyGridState(weekStart: $weekStart, rows: $rows, projects: $projects, currentUserId: $currentUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyGridStateImpl &&
            (identical(other.weekStart, weekStart) || other.weekStart == weekStart) &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.currentUserId, currentUserId) || other.currentUserId == currentUserId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    weekStart,
    const DeepCollectionEquality().hash(_rows),
    const DeepCollectionEquality().hash(_projects),
    currentUserId,
  );

  /// Create a copy of WeeklyGridState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyGridStateImplCopyWith<_$WeeklyGridStateImpl> get copyWith =>
      __$$WeeklyGridStateImplCopyWithImpl<_$WeeklyGridStateImpl>(this, _$identity);
}

abstract class _WeeklyGridState implements WeeklyGridState {
  const factory _WeeklyGridState({
    required final DateTime weekStart,
    required final List<GridRow> rows,
    required final List<Project> projects,
    final String? currentUserId,
  }) = _$WeeklyGridStateImpl;

  @override
  DateTime get weekStart;
  @override
  List<GridRow> get rows;
  @override
  List<Project> get projects;
  @override
  String? get currentUserId;

  /// Create a copy of WeeklyGridState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyGridStateImplCopyWith<_$WeeklyGridStateImpl> get copyWith => throw _privateConstructorUsedError;
}
