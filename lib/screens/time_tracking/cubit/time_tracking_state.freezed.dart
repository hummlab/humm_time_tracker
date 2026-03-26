// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_tracking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TimeTrackingState {
  DateTime get selectedDate => throw _privateConstructorUsedError;
  List<TimeEntry> get entriesForDate => throw _privateConstructorUsedError;
  List<TimeEntry> get weekEntries => throw _privateConstructorUsedError;
  List<Project> get projects => throw _privateConstructorUsedError;
  List<Tag> get tags => throw _privateConstructorUsedError;
  ActiveTimer? get activeTimer => throw _privateConstructorUsedError;
  String? get currentUserId => throw _privateConstructorUsedError;
  TeamMember? get currentMember => throw _privateConstructorUsedError;
  bool get hasManagerAccess => throw _privateConstructorUsedError;
  bool get hasActiveTimer => throw _privateConstructorUsedError;
  bool get isStoppingTimer => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;
  TimeEntry? get editingEntry => throw _privateConstructorUsedError;

  /// Create a copy of TimeTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeTrackingStateCopyWith<TimeTrackingState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeTrackingStateCopyWith<$Res> {
  factory $TimeTrackingStateCopyWith(TimeTrackingState value, $Res Function(TimeTrackingState) then) =
      _$TimeTrackingStateCopyWithImpl<$Res, TimeTrackingState>;
  @useResult
  $Res call({
    DateTime selectedDate,
    List<TimeEntry> entriesForDate,
    List<TimeEntry> weekEntries,
    List<Project> projects,
    List<Tag> tags,
    ActiveTimer? activeTimer,
    String? currentUserId,
    TeamMember? currentMember,
    bool hasManagerAccess,
    bool hasActiveTimer,
    bool isStoppingTimer,
    String? toastMessage,
    AppToastType? toastType,
    TimeEntry? editingEntry,
  });

  $ActiveTimerCopyWith<$Res>? get activeTimer;
  $TeamMemberCopyWith<$Res>? get currentMember;
  $TimeEntryCopyWith<$Res>? get editingEntry;
}

/// @nodoc
class _$TimeTrackingStateCopyWithImpl<$Res, $Val extends TimeTrackingState>
    implements $TimeTrackingStateCopyWith<$Res> {
  _$TimeTrackingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? entriesForDate = null,
    Object? weekEntries = null,
    Object? projects = null,
    Object? tags = null,
    Object? activeTimer = freezed,
    Object? currentUserId = freezed,
    Object? currentMember = freezed,
    Object? hasManagerAccess = null,
    Object? hasActiveTimer = null,
    Object? isStoppingTimer = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
    Object? editingEntry = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedDate:
                null == selectedDate
                    ? _value.selectedDate
                    : selectedDate // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            entriesForDate:
                null == entriesForDate
                    ? _value.entriesForDate
                    : entriesForDate // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            weekEntries:
                null == weekEntries
                    ? _value.weekEntries
                    : weekEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            projects:
                null == projects
                    ? _value.projects
                    : projects // ignore: cast_nullable_to_non_nullable
                        as List<Project>,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<Tag>,
            activeTimer:
                freezed == activeTimer
                    ? _value.activeTimer
                    : activeTimer // ignore: cast_nullable_to_non_nullable
                        as ActiveTimer?,
            currentUserId:
                freezed == currentUserId
                    ? _value.currentUserId
                    : currentUserId // ignore: cast_nullable_to_non_nullable
                        as String?,
            currentMember:
                freezed == currentMember
                    ? _value.currentMember
                    : currentMember // ignore: cast_nullable_to_non_nullable
                        as TeamMember?,
            hasManagerAccess:
                null == hasManagerAccess
                    ? _value.hasManagerAccess
                    : hasManagerAccess // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasActiveTimer:
                null == hasActiveTimer
                    ? _value.hasActiveTimer
                    : hasActiveTimer // ignore: cast_nullable_to_non_nullable
                        as bool,
            isStoppingTimer:
                null == isStoppingTimer
                    ? _value.isStoppingTimer
                    : isStoppingTimer // ignore: cast_nullable_to_non_nullable
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
            editingEntry:
                freezed == editingEntry
                    ? _value.editingEntry
                    : editingEntry // ignore: cast_nullable_to_non_nullable
                        as TimeEntry?,
          )
          as $Val,
    );
  }

  /// Create a copy of TimeTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActiveTimerCopyWith<$Res>? get activeTimer {
    if (_value.activeTimer == null) {
      return null;
    }

    return $ActiveTimerCopyWith<$Res>(_value.activeTimer!, (value) {
      return _then(_value.copyWith(activeTimer: value) as $Val);
    });
  }

  /// Create a copy of TimeTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamMemberCopyWith<$Res>? get currentMember {
    if (_value.currentMember == null) {
      return null;
    }

    return $TeamMemberCopyWith<$Res>(_value.currentMember!, (value) {
      return _then(_value.copyWith(currentMember: value) as $Val);
    });
  }

  /// Create a copy of TimeTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeEntryCopyWith<$Res>? get editingEntry {
    if (_value.editingEntry == null) {
      return null;
    }

    return $TimeEntryCopyWith<$Res>(_value.editingEntry!, (value) {
      return _then(_value.copyWith(editingEntry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TimeTrackingStateImplCopyWith<$Res> implements $TimeTrackingStateCopyWith<$Res> {
  factory _$$TimeTrackingStateImplCopyWith(_$TimeTrackingStateImpl value, $Res Function(_$TimeTrackingStateImpl) then) =
      __$$TimeTrackingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime selectedDate,
    List<TimeEntry> entriesForDate,
    List<TimeEntry> weekEntries,
    List<Project> projects,
    List<Tag> tags,
    ActiveTimer? activeTimer,
    String? currentUserId,
    TeamMember? currentMember,
    bool hasManagerAccess,
    bool hasActiveTimer,
    bool isStoppingTimer,
    String? toastMessage,
    AppToastType? toastType,
    TimeEntry? editingEntry,
  });

  @override
  $ActiveTimerCopyWith<$Res>? get activeTimer;
  @override
  $TeamMemberCopyWith<$Res>? get currentMember;
  @override
  $TimeEntryCopyWith<$Res>? get editingEntry;
}

/// @nodoc
class __$$TimeTrackingStateImplCopyWithImpl<$Res> extends _$TimeTrackingStateCopyWithImpl<$Res, _$TimeTrackingStateImpl>
    implements _$$TimeTrackingStateImplCopyWith<$Res> {
  __$$TimeTrackingStateImplCopyWithImpl(_$TimeTrackingStateImpl _value, $Res Function(_$TimeTrackingStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of TimeTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? entriesForDate = null,
    Object? weekEntries = null,
    Object? projects = null,
    Object? tags = null,
    Object? activeTimer = freezed,
    Object? currentUserId = freezed,
    Object? currentMember = freezed,
    Object? hasManagerAccess = null,
    Object? hasActiveTimer = null,
    Object? isStoppingTimer = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
    Object? editingEntry = freezed,
  }) {
    return _then(
      _$TimeTrackingStateImpl(
        selectedDate:
            null == selectedDate
                ? _value.selectedDate
                : selectedDate // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        entriesForDate:
            null == entriesForDate
                ? _value._entriesForDate
                : entriesForDate // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        weekEntries:
            null == weekEntries
                ? _value._weekEntries
                : weekEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        projects:
            null == projects
                ? _value._projects
                : projects // ignore: cast_nullable_to_non_nullable
                    as List<Project>,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<Tag>,
        activeTimer:
            freezed == activeTimer
                ? _value.activeTimer
                : activeTimer // ignore: cast_nullable_to_non_nullable
                    as ActiveTimer?,
        currentUserId:
            freezed == currentUserId
                ? _value.currentUserId
                : currentUserId // ignore: cast_nullable_to_non_nullable
                    as String?,
        currentMember:
            freezed == currentMember
                ? _value.currentMember
                : currentMember // ignore: cast_nullable_to_non_nullable
                    as TeamMember?,
        hasManagerAccess:
            null == hasManagerAccess
                ? _value.hasManagerAccess
                : hasManagerAccess // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasActiveTimer:
            null == hasActiveTimer
                ? _value.hasActiveTimer
                : hasActiveTimer // ignore: cast_nullable_to_non_nullable
                    as bool,
        isStoppingTimer:
            null == isStoppingTimer
                ? _value.isStoppingTimer
                : isStoppingTimer // ignore: cast_nullable_to_non_nullable
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
        editingEntry:
            freezed == editingEntry
                ? _value.editingEntry
                : editingEntry // ignore: cast_nullable_to_non_nullable
                    as TimeEntry?,
      ),
    );
  }
}

/// @nodoc

class _$TimeTrackingStateImpl implements _TimeTrackingState {
  const _$TimeTrackingStateImpl({
    required this.selectedDate,
    required final List<TimeEntry> entriesForDate,
    required final List<TimeEntry> weekEntries,
    required final List<Project> projects,
    required final List<Tag> tags,
    this.activeTimer,
    this.currentUserId,
    this.currentMember,
    required this.hasManagerAccess,
    required this.hasActiveTimer,
    required this.isStoppingTimer,
    this.toastMessage,
    this.toastType,
    this.editingEntry,
  }) : _entriesForDate = entriesForDate,
       _weekEntries = weekEntries,
       _projects = projects,
       _tags = tags;

  @override
  final DateTime selectedDate;
  final List<TimeEntry> _entriesForDate;
  @override
  List<TimeEntry> get entriesForDate {
    if (_entriesForDate is EqualUnmodifiableListView) return _entriesForDate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entriesForDate);
  }

  final List<TimeEntry> _weekEntries;
  @override
  List<TimeEntry> get weekEntries {
    if (_weekEntries is EqualUnmodifiableListView) return _weekEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekEntries);
  }

  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  final List<Tag> _tags;
  @override
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final ActiveTimer? activeTimer;
  @override
  final String? currentUserId;
  @override
  final TeamMember? currentMember;
  @override
  final bool hasManagerAccess;
  @override
  final bool hasActiveTimer;
  @override
  final bool isStoppingTimer;
  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;
  @override
  final TimeEntry? editingEntry;

  @override
  String toString() {
    return 'TimeTrackingState(selectedDate: $selectedDate, entriesForDate: $entriesForDate, weekEntries: $weekEntries, projects: $projects, tags: $tags, activeTimer: $activeTimer, currentUserId: $currentUserId, currentMember: $currentMember, hasManagerAccess: $hasManagerAccess, hasActiveTimer: $hasActiveTimer, isStoppingTimer: $isStoppingTimer, toastMessage: $toastMessage, toastType: $toastType, editingEntry: $editingEntry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeTrackingStateImpl &&
            (identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._entriesForDate, _entriesForDate) &&
            const DeepCollectionEquality().equals(other._weekEntries, _weekEntries) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.activeTimer, activeTimer) || other.activeTimer == activeTimer) &&
            (identical(other.currentUserId, currentUserId) || other.currentUserId == currentUserId) &&
            (identical(other.currentMember, currentMember) || other.currentMember == currentMember) &&
            (identical(other.hasManagerAccess, hasManagerAccess) || other.hasManagerAccess == hasManagerAccess) &&
            (identical(other.hasActiveTimer, hasActiveTimer) || other.hasActiveTimer == hasActiveTimer) &&
            (identical(other.isStoppingTimer, isStoppingTimer) || other.isStoppingTimer == isStoppingTimer) &&
            (identical(other.toastMessage, toastMessage) || other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) || other.toastType == toastType) &&
            (identical(other.editingEntry, editingEntry) || other.editingEntry == editingEntry));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedDate,
    const DeepCollectionEquality().hash(_entriesForDate),
    const DeepCollectionEquality().hash(_weekEntries),
    const DeepCollectionEquality().hash(_projects),
    const DeepCollectionEquality().hash(_tags),
    activeTimer,
    currentUserId,
    currentMember,
    hasManagerAccess,
    hasActiveTimer,
    isStoppingTimer,
    toastMessage,
    toastType,
    editingEntry,
  );

  /// Create a copy of TimeTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeTrackingStateImplCopyWith<_$TimeTrackingStateImpl> get copyWith =>
      __$$TimeTrackingStateImplCopyWithImpl<_$TimeTrackingStateImpl>(this, _$identity);
}

abstract class _TimeTrackingState implements TimeTrackingState {
  const factory _TimeTrackingState({
    required final DateTime selectedDate,
    required final List<TimeEntry> entriesForDate,
    required final List<TimeEntry> weekEntries,
    required final List<Project> projects,
    required final List<Tag> tags,
    final ActiveTimer? activeTimer,
    final String? currentUserId,
    final TeamMember? currentMember,
    required final bool hasManagerAccess,
    required final bool hasActiveTimer,
    required final bool isStoppingTimer,
    final String? toastMessage,
    final AppToastType? toastType,
    final TimeEntry? editingEntry,
  }) = _$TimeTrackingStateImpl;

  @override
  DateTime get selectedDate;
  @override
  List<TimeEntry> get entriesForDate;
  @override
  List<TimeEntry> get weekEntries;
  @override
  List<Project> get projects;
  @override
  List<Tag> get tags;
  @override
  ActiveTimer? get activeTimer;
  @override
  String? get currentUserId;
  @override
  TeamMember? get currentMember;
  @override
  bool get hasManagerAccess;
  @override
  bool get hasActiveTimer;
  @override
  bool get isStoppingTimer;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;
  @override
  TimeEntry? get editingEntry;

  /// Create a copy of TimeTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeTrackingStateImplCopyWith<_$TimeTrackingStateImpl> get copyWith => throw _privateConstructorUsedError;
}
