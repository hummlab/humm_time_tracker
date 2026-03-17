// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approve_hours_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApproveHoursState {
  List<TimeEntry> get pendingEntries => throw _privateConstructorUsedError;
  List<TimeEntry> get filteredEntries => throw _privateConstructorUsedError;
  List<ApproveHoursUserSection> get userSections => throw _privateConstructorUsedError;
  List<TeamMember> get usersWithPending => throw _privateConstructorUsedError;
  Map<String, int> get pendingCountsByUserId => throw _privateConstructorUsedError;
  String? get filterByUserId => throw _privateConstructorUsedError;
  List<String> get selectedEntryIds => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of ApproveHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApproveHoursStateCopyWith<ApproveHoursState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApproveHoursStateCopyWith<$Res> {
  factory $ApproveHoursStateCopyWith(ApproveHoursState value, $Res Function(ApproveHoursState) then) =
      _$ApproveHoursStateCopyWithImpl<$Res, ApproveHoursState>;
  @useResult
  $Res call({
    List<TimeEntry> pendingEntries,
    List<TimeEntry> filteredEntries,
    List<ApproveHoursUserSection> userSections,
    List<TeamMember> usersWithPending,
    Map<String, int> pendingCountsByUserId,
    String? filterByUserId,
    List<String> selectedEntryIds,
    bool isProcessing,
    int totalMinutes,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class _$ApproveHoursStateCopyWithImpl<$Res, $Val extends ApproveHoursState>
    implements $ApproveHoursStateCopyWith<$Res> {
  _$ApproveHoursStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApproveHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pendingEntries = null,
    Object? filteredEntries = null,
    Object? userSections = null,
    Object? usersWithPending = null,
    Object? pendingCountsByUserId = null,
    Object? filterByUserId = freezed,
    Object? selectedEntryIds = null,
    Object? isProcessing = null,
    Object? totalMinutes = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            pendingEntries:
                null == pendingEntries
                    ? _value.pendingEntries
                    : pendingEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            filteredEntries:
                null == filteredEntries
                    ? _value.filteredEntries
                    : filteredEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            userSections:
                null == userSections
                    ? _value.userSections
                    : userSections // ignore: cast_nullable_to_non_nullable
                        as List<ApproveHoursUserSection>,
            usersWithPending:
                null == usersWithPending
                    ? _value.usersWithPending
                    : usersWithPending // ignore: cast_nullable_to_non_nullable
                        as List<TeamMember>,
            pendingCountsByUserId:
                null == pendingCountsByUserId
                    ? _value.pendingCountsByUserId
                    : pendingCountsByUserId // ignore: cast_nullable_to_non_nullable
                        as Map<String, int>,
            filterByUserId:
                freezed == filterByUserId
                    ? _value.filterByUserId
                    : filterByUserId // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedEntryIds:
                null == selectedEntryIds
                    ? _value.selectedEntryIds
                    : selectedEntryIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            isProcessing:
                null == isProcessing
                    ? _value.isProcessing
                    : isProcessing // ignore: cast_nullable_to_non_nullable
                        as bool,
            totalMinutes:
                null == totalMinutes
                    ? _value.totalMinutes
                    : totalMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApproveHoursStateImplCopyWith<$Res> implements $ApproveHoursStateCopyWith<$Res> {
  factory _$$ApproveHoursStateImplCopyWith(_$ApproveHoursStateImpl value, $Res Function(_$ApproveHoursStateImpl) then) =
      __$$ApproveHoursStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TimeEntry> pendingEntries,
    List<TimeEntry> filteredEntries,
    List<ApproveHoursUserSection> userSections,
    List<TeamMember> usersWithPending,
    Map<String, int> pendingCountsByUserId,
    String? filterByUserId,
    List<String> selectedEntryIds,
    bool isProcessing,
    int totalMinutes,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class __$$ApproveHoursStateImplCopyWithImpl<$Res> extends _$ApproveHoursStateCopyWithImpl<$Res, _$ApproveHoursStateImpl>
    implements _$$ApproveHoursStateImplCopyWith<$Res> {
  __$$ApproveHoursStateImplCopyWithImpl(_$ApproveHoursStateImpl _value, $Res Function(_$ApproveHoursStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of ApproveHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pendingEntries = null,
    Object? filteredEntries = null,
    Object? userSections = null,
    Object? usersWithPending = null,
    Object? pendingCountsByUserId = null,
    Object? filterByUserId = freezed,
    Object? selectedEntryIds = null,
    Object? isProcessing = null,
    Object? totalMinutes = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$ApproveHoursStateImpl(
        pendingEntries:
            null == pendingEntries
                ? _value._pendingEntries
                : pendingEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        filteredEntries:
            null == filteredEntries
                ? _value._filteredEntries
                : filteredEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        userSections:
            null == userSections
                ? _value._userSections
                : userSections // ignore: cast_nullable_to_non_nullable
                    as List<ApproveHoursUserSection>,
        usersWithPending:
            null == usersWithPending
                ? _value._usersWithPending
                : usersWithPending // ignore: cast_nullable_to_non_nullable
                    as List<TeamMember>,
        pendingCountsByUserId:
            null == pendingCountsByUserId
                ? _value._pendingCountsByUserId
                : pendingCountsByUserId // ignore: cast_nullable_to_non_nullable
                    as Map<String, int>,
        filterByUserId:
            freezed == filterByUserId
                ? _value.filterByUserId
                : filterByUserId // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedEntryIds:
            null == selectedEntryIds
                ? _value._selectedEntryIds
                : selectedEntryIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        isProcessing:
            null == isProcessing
                ? _value.isProcessing
                : isProcessing // ignore: cast_nullable_to_non_nullable
                    as bool,
        totalMinutes:
            null == totalMinutes
                ? _value.totalMinutes
                : totalMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
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
      ),
    );
  }
}

/// @nodoc

class _$ApproveHoursStateImpl implements _ApproveHoursState {
  const _$ApproveHoursStateImpl({
    required final List<TimeEntry> pendingEntries,
    required final List<TimeEntry> filteredEntries,
    required final List<ApproveHoursUserSection> userSections,
    required final List<TeamMember> usersWithPending,
    required final Map<String, int> pendingCountsByUserId,
    this.filterByUserId,
    required final List<String> selectedEntryIds,
    required this.isProcessing,
    required this.totalMinutes,
    this.toastMessage,
    this.toastType,
  }) : _pendingEntries = pendingEntries,
       _filteredEntries = filteredEntries,
       _userSections = userSections,
       _usersWithPending = usersWithPending,
       _pendingCountsByUserId = pendingCountsByUserId,
       _selectedEntryIds = selectedEntryIds;

  final List<TimeEntry> _pendingEntries;
  @override
  List<TimeEntry> get pendingEntries {
    if (_pendingEntries is EqualUnmodifiableListView) return _pendingEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingEntries);
  }

  final List<TimeEntry> _filteredEntries;
  @override
  List<TimeEntry> get filteredEntries {
    if (_filteredEntries is EqualUnmodifiableListView) return _filteredEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredEntries);
  }

  final List<ApproveHoursUserSection> _userSections;
  @override
  List<ApproveHoursUserSection> get userSections {
    if (_userSections is EqualUnmodifiableListView) return _userSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userSections);
  }

  final List<TeamMember> _usersWithPending;
  @override
  List<TeamMember> get usersWithPending {
    if (_usersWithPending is EqualUnmodifiableListView) return _usersWithPending;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usersWithPending);
  }

  final Map<String, int> _pendingCountsByUserId;
  @override
  Map<String, int> get pendingCountsByUserId {
    if (_pendingCountsByUserId is EqualUnmodifiableMapView) return _pendingCountsByUserId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pendingCountsByUserId);
  }

  @override
  final String? filterByUserId;
  final List<String> _selectedEntryIds;
  @override
  List<String> get selectedEntryIds {
    if (_selectedEntryIds is EqualUnmodifiableListView) return _selectedEntryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedEntryIds);
  }

  @override
  final bool isProcessing;
  @override
  final int totalMinutes;
  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;

  @override
  String toString() {
    return 'ApproveHoursState(pendingEntries: $pendingEntries, filteredEntries: $filteredEntries, userSections: $userSections, usersWithPending: $usersWithPending, pendingCountsByUserId: $pendingCountsByUserId, filterByUserId: $filterByUserId, selectedEntryIds: $selectedEntryIds, isProcessing: $isProcessing, totalMinutes: $totalMinutes, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApproveHoursStateImpl &&
            const DeepCollectionEquality().equals(other._pendingEntries, _pendingEntries) &&
            const DeepCollectionEquality().equals(other._filteredEntries, _filteredEntries) &&
            const DeepCollectionEquality().equals(other._userSections, _userSections) &&
            const DeepCollectionEquality().equals(other._usersWithPending, _usersWithPending) &&
            const DeepCollectionEquality().equals(other._pendingCountsByUserId, _pendingCountsByUserId) &&
            (identical(other.filterByUserId, filterByUserId) || other.filterByUserId == filterByUserId) &&
            const DeepCollectionEquality().equals(other._selectedEntryIds, _selectedEntryIds) &&
            (identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing) &&
            (identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes) &&
            (identical(other.toastMessage, toastMessage) || other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) || other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_pendingEntries),
    const DeepCollectionEquality().hash(_filteredEntries),
    const DeepCollectionEquality().hash(_userSections),
    const DeepCollectionEquality().hash(_usersWithPending),
    const DeepCollectionEquality().hash(_pendingCountsByUserId),
    filterByUserId,
    const DeepCollectionEquality().hash(_selectedEntryIds),
    isProcessing,
    totalMinutes,
    toastMessage,
    toastType,
  );

  /// Create a copy of ApproveHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApproveHoursStateImplCopyWith<_$ApproveHoursStateImpl> get copyWith =>
      __$$ApproveHoursStateImplCopyWithImpl<_$ApproveHoursStateImpl>(this, _$identity);
}

abstract class _ApproveHoursState implements ApproveHoursState {
  const factory _ApproveHoursState({
    required final List<TimeEntry> pendingEntries,
    required final List<TimeEntry> filteredEntries,
    required final List<ApproveHoursUserSection> userSections,
    required final List<TeamMember> usersWithPending,
    required final Map<String, int> pendingCountsByUserId,
    final String? filterByUserId,
    required final List<String> selectedEntryIds,
    required final bool isProcessing,
    required final int totalMinutes,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$ApproveHoursStateImpl;

  @override
  List<TimeEntry> get pendingEntries;
  @override
  List<TimeEntry> get filteredEntries;
  @override
  List<ApproveHoursUserSection> get userSections;
  @override
  List<TeamMember> get usersWithPending;
  @override
  Map<String, int> get pendingCountsByUserId;
  @override
  String? get filterByUserId;
  @override
  List<String> get selectedEntryIds;
  @override
  bool get isProcessing;
  @override
  int get totalMinutes;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of ApproveHoursState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApproveHoursStateImplCopyWith<_$ApproveHoursStateImpl> get copyWith => throw _privateConstructorUsedError;
}
