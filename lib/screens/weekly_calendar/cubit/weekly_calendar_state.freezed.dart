// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WeeklyCalendarState {
  DateTime get weekStart => throw _privateConstructorUsedError;
  List<TimeEntry> get weekEntries => throw _privateConstructorUsedError;
  int get weekTotalMinutes => throw _privateConstructorUsedError;
  String? get currentUserId => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyCalendarStateCopyWith<WeeklyCalendarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyCalendarStateCopyWith<$Res> {
  factory $WeeklyCalendarStateCopyWith(
    WeeklyCalendarState value,
    $Res Function(WeeklyCalendarState) then,
  ) = _$WeeklyCalendarStateCopyWithImpl<$Res, WeeklyCalendarState>;
  @useResult
  $Res call({
    DateTime weekStart,
    List<TimeEntry> weekEntries,
    int weekTotalMinutes,
    String? currentUserId,
  });
}

/// @nodoc
class _$WeeklyCalendarStateCopyWithImpl<$Res, $Val extends WeeklyCalendarState>
    implements $WeeklyCalendarStateCopyWith<$Res> {
  _$WeeklyCalendarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekStart = null,
    Object? weekEntries = null,
    Object? weekTotalMinutes = null,
    Object? currentUserId = freezed,
  }) {
    return _then(
      _value.copyWith(
            weekStart:
                null == weekStart
                    ? _value.weekStart
                    : weekStart // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            weekEntries:
                null == weekEntries
                    ? _value.weekEntries
                    : weekEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            weekTotalMinutes:
                null == weekTotalMinutes
                    ? _value.weekTotalMinutes
                    : weekTotalMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
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
abstract class _$$WeeklyCalendarStateImplCopyWith<$Res>
    implements $WeeklyCalendarStateCopyWith<$Res> {
  factory _$$WeeklyCalendarStateImplCopyWith(
    _$WeeklyCalendarStateImpl value,
    $Res Function(_$WeeklyCalendarStateImpl) then,
  ) = __$$WeeklyCalendarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime weekStart,
    List<TimeEntry> weekEntries,
    int weekTotalMinutes,
    String? currentUserId,
  });
}

/// @nodoc
class __$$WeeklyCalendarStateImplCopyWithImpl<$Res>
    extends _$WeeklyCalendarStateCopyWithImpl<$Res, _$WeeklyCalendarStateImpl>
    implements _$$WeeklyCalendarStateImplCopyWith<$Res> {
  __$$WeeklyCalendarStateImplCopyWithImpl(
    _$WeeklyCalendarStateImpl _value,
    $Res Function(_$WeeklyCalendarStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklyCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekStart = null,
    Object? weekEntries = null,
    Object? weekTotalMinutes = null,
    Object? currentUserId = freezed,
  }) {
    return _then(
      _$WeeklyCalendarStateImpl(
        weekStart:
            null == weekStart
                ? _value.weekStart
                : weekStart // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        weekEntries:
            null == weekEntries
                ? _value._weekEntries
                : weekEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        weekTotalMinutes:
            null == weekTotalMinutes
                ? _value.weekTotalMinutes
                : weekTotalMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
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

class _$WeeklyCalendarStateImpl implements _WeeklyCalendarState {
  const _$WeeklyCalendarStateImpl({
    required this.weekStart,
    required final List<TimeEntry> weekEntries,
    required this.weekTotalMinutes,
    this.currentUserId,
  }) : _weekEntries = weekEntries;

  @override
  final DateTime weekStart;
  final List<TimeEntry> _weekEntries;
  @override
  List<TimeEntry> get weekEntries {
    if (_weekEntries is EqualUnmodifiableListView) return _weekEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekEntries);
  }

  @override
  final int weekTotalMinutes;
  @override
  final String? currentUserId;

  @override
  String toString() {
    return 'WeeklyCalendarState(weekStart: $weekStart, weekEntries: $weekEntries, weekTotalMinutes: $weekTotalMinutes, currentUserId: $currentUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyCalendarStateImpl &&
            (identical(other.weekStart, weekStart) ||
                other.weekStart == weekStart) &&
            const DeepCollectionEquality().equals(
              other._weekEntries,
              _weekEntries,
            ) &&
            (identical(other.weekTotalMinutes, weekTotalMinutes) ||
                other.weekTotalMinutes == weekTotalMinutes) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    weekStart,
    const DeepCollectionEquality().hash(_weekEntries),
    weekTotalMinutes,
    currentUserId,
  );

  /// Create a copy of WeeklyCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyCalendarStateImplCopyWith<_$WeeklyCalendarStateImpl> get copyWith =>
      __$$WeeklyCalendarStateImplCopyWithImpl<_$WeeklyCalendarStateImpl>(
        this,
        _$identity,
      );
}

abstract class _WeeklyCalendarState implements WeeklyCalendarState {
  const factory _WeeklyCalendarState({
    required final DateTime weekStart,
    required final List<TimeEntry> weekEntries,
    required final int weekTotalMinutes,
    final String? currentUserId,
  }) = _$WeeklyCalendarStateImpl;

  @override
  DateTime get weekStart;
  @override
  List<TimeEntry> get weekEntries;
  @override
  int get weekTotalMinutes;
  @override
  String? get currentUserId;

  /// Create a copy of WeeklyCalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyCalendarStateImplCopyWith<_$WeeklyCalendarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
