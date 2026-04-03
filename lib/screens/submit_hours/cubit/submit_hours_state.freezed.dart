// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submit_hours_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SubmitHoursState {
  List<TimeEntry> get draftEntries => throw _privateConstructorUsedError;
  List<TimeEntry> get pendingEntries => throw _privateConstructorUsedError;
  List<TimeEntry> get rejectedEntries => throw _privateConstructorUsedError;
  List<SubmitHoursDateSection> get draftSections =>
      throw _privateConstructorUsedError;
  List<SubmitHoursDateSection> get pendingSections =>
      throw _privateConstructorUsedError;
  List<SubmitHoursDateSection> get rejectedSections =>
      throw _privateConstructorUsedError;
  List<String> get selectedEntryIds => throw _privateConstructorUsedError;
  SubmitHoursQuickSelectPeriod get activeQuickSelect =>
      throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  int get totalDraftMinutes => throw _privateConstructorUsedError;
  int get totalPendingMinutes => throw _privateConstructorUsedError;
  int get totalRejectedMinutes => throw _privateConstructorUsedError;
  int get selectedTotalMinutes => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of SubmitHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmitHoursStateCopyWith<SubmitHoursState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitHoursStateCopyWith<$Res> {
  factory $SubmitHoursStateCopyWith(
    SubmitHoursState value,
    $Res Function(SubmitHoursState) then,
  ) = _$SubmitHoursStateCopyWithImpl<$Res, SubmitHoursState>;
  @useResult
  $Res call({
    List<TimeEntry> draftEntries,
    List<TimeEntry> pendingEntries,
    List<TimeEntry> rejectedEntries,
    List<SubmitHoursDateSection> draftSections,
    List<SubmitHoursDateSection> pendingSections,
    List<SubmitHoursDateSection> rejectedSections,
    List<String> selectedEntryIds,
    SubmitHoursQuickSelectPeriod activeQuickSelect,
    bool isSubmitting,
    int totalDraftMinutes,
    int totalPendingMinutes,
    int totalRejectedMinutes,
    int selectedTotalMinutes,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class _$SubmitHoursStateCopyWithImpl<$Res, $Val extends SubmitHoursState>
    implements $SubmitHoursStateCopyWith<$Res> {
  _$SubmitHoursStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubmitHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draftEntries = null,
    Object? pendingEntries = null,
    Object? rejectedEntries = null,
    Object? draftSections = null,
    Object? pendingSections = null,
    Object? rejectedSections = null,
    Object? selectedEntryIds = null,
    Object? activeQuickSelect = null,
    Object? isSubmitting = null,
    Object? totalDraftMinutes = null,
    Object? totalPendingMinutes = null,
    Object? totalRejectedMinutes = null,
    Object? selectedTotalMinutes = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            draftEntries:
                null == draftEntries
                    ? _value.draftEntries
                    : draftEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            pendingEntries:
                null == pendingEntries
                    ? _value.pendingEntries
                    : pendingEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            rejectedEntries:
                null == rejectedEntries
                    ? _value.rejectedEntries
                    : rejectedEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            draftSections:
                null == draftSections
                    ? _value.draftSections
                    : draftSections // ignore: cast_nullable_to_non_nullable
                        as List<SubmitHoursDateSection>,
            pendingSections:
                null == pendingSections
                    ? _value.pendingSections
                    : pendingSections // ignore: cast_nullable_to_non_nullable
                        as List<SubmitHoursDateSection>,
            rejectedSections:
                null == rejectedSections
                    ? _value.rejectedSections
                    : rejectedSections // ignore: cast_nullable_to_non_nullable
                        as List<SubmitHoursDateSection>,
            selectedEntryIds:
                null == selectedEntryIds
                    ? _value.selectedEntryIds
                    : selectedEntryIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            activeQuickSelect:
                null == activeQuickSelect
                    ? _value.activeQuickSelect
                    : activeQuickSelect // ignore: cast_nullable_to_non_nullable
                        as SubmitHoursQuickSelectPeriod,
            isSubmitting:
                null == isSubmitting
                    ? _value.isSubmitting
                    : isSubmitting // ignore: cast_nullable_to_non_nullable
                        as bool,
            totalDraftMinutes:
                null == totalDraftMinutes
                    ? _value.totalDraftMinutes
                    : totalDraftMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
            totalPendingMinutes:
                null == totalPendingMinutes
                    ? _value.totalPendingMinutes
                    : totalPendingMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
            totalRejectedMinutes:
                null == totalRejectedMinutes
                    ? _value.totalRejectedMinutes
                    : totalRejectedMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
            selectedTotalMinutes:
                null == selectedTotalMinutes
                    ? _value.selectedTotalMinutes
                    : selectedTotalMinutes // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SubmitHoursStateImplCopyWith<$Res>
    implements $SubmitHoursStateCopyWith<$Res> {
  factory _$$SubmitHoursStateImplCopyWith(
    _$SubmitHoursStateImpl value,
    $Res Function(_$SubmitHoursStateImpl) then,
  ) = __$$SubmitHoursStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TimeEntry> draftEntries,
    List<TimeEntry> pendingEntries,
    List<TimeEntry> rejectedEntries,
    List<SubmitHoursDateSection> draftSections,
    List<SubmitHoursDateSection> pendingSections,
    List<SubmitHoursDateSection> rejectedSections,
    List<String> selectedEntryIds,
    SubmitHoursQuickSelectPeriod activeQuickSelect,
    bool isSubmitting,
    int totalDraftMinutes,
    int totalPendingMinutes,
    int totalRejectedMinutes,
    int selectedTotalMinutes,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class __$$SubmitHoursStateImplCopyWithImpl<$Res>
    extends _$SubmitHoursStateCopyWithImpl<$Res, _$SubmitHoursStateImpl>
    implements _$$SubmitHoursStateImplCopyWith<$Res> {
  __$$SubmitHoursStateImplCopyWithImpl(
    _$SubmitHoursStateImpl _value,
    $Res Function(_$SubmitHoursStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubmitHoursState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draftEntries = null,
    Object? pendingEntries = null,
    Object? rejectedEntries = null,
    Object? draftSections = null,
    Object? pendingSections = null,
    Object? rejectedSections = null,
    Object? selectedEntryIds = null,
    Object? activeQuickSelect = null,
    Object? isSubmitting = null,
    Object? totalDraftMinutes = null,
    Object? totalPendingMinutes = null,
    Object? totalRejectedMinutes = null,
    Object? selectedTotalMinutes = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$SubmitHoursStateImpl(
        draftEntries:
            null == draftEntries
                ? _value._draftEntries
                : draftEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        pendingEntries:
            null == pendingEntries
                ? _value._pendingEntries
                : pendingEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        rejectedEntries:
            null == rejectedEntries
                ? _value._rejectedEntries
                : rejectedEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        draftSections:
            null == draftSections
                ? _value._draftSections
                : draftSections // ignore: cast_nullable_to_non_nullable
                    as List<SubmitHoursDateSection>,
        pendingSections:
            null == pendingSections
                ? _value._pendingSections
                : pendingSections // ignore: cast_nullable_to_non_nullable
                    as List<SubmitHoursDateSection>,
        rejectedSections:
            null == rejectedSections
                ? _value._rejectedSections
                : rejectedSections // ignore: cast_nullable_to_non_nullable
                    as List<SubmitHoursDateSection>,
        selectedEntryIds:
            null == selectedEntryIds
                ? _value._selectedEntryIds
                : selectedEntryIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        activeQuickSelect:
            null == activeQuickSelect
                ? _value.activeQuickSelect
                : activeQuickSelect // ignore: cast_nullable_to_non_nullable
                    as SubmitHoursQuickSelectPeriod,
        isSubmitting:
            null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                    as bool,
        totalDraftMinutes:
            null == totalDraftMinutes
                ? _value.totalDraftMinutes
                : totalDraftMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
        totalPendingMinutes:
            null == totalPendingMinutes
                ? _value.totalPendingMinutes
                : totalPendingMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
        totalRejectedMinutes:
            null == totalRejectedMinutes
                ? _value.totalRejectedMinutes
                : totalRejectedMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
        selectedTotalMinutes:
            null == selectedTotalMinutes
                ? _value.selectedTotalMinutes
                : selectedTotalMinutes // ignore: cast_nullable_to_non_nullable
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

class _$SubmitHoursStateImpl implements _SubmitHoursState {
  const _$SubmitHoursStateImpl({
    required final List<TimeEntry> draftEntries,
    required final List<TimeEntry> pendingEntries,
    required final List<TimeEntry> rejectedEntries,
    required final List<SubmitHoursDateSection> draftSections,
    required final List<SubmitHoursDateSection> pendingSections,
    required final List<SubmitHoursDateSection> rejectedSections,
    required final List<String> selectedEntryIds,
    required this.activeQuickSelect,
    required this.isSubmitting,
    required this.totalDraftMinutes,
    required this.totalPendingMinutes,
    required this.totalRejectedMinutes,
    required this.selectedTotalMinutes,
    this.toastMessage,
    this.toastType,
  }) : _draftEntries = draftEntries,
       _pendingEntries = pendingEntries,
       _rejectedEntries = rejectedEntries,
       _draftSections = draftSections,
       _pendingSections = pendingSections,
       _rejectedSections = rejectedSections,
       _selectedEntryIds = selectedEntryIds;

  final List<TimeEntry> _draftEntries;
  @override
  List<TimeEntry> get draftEntries {
    if (_draftEntries is EqualUnmodifiableListView) return _draftEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_draftEntries);
  }

  final List<TimeEntry> _pendingEntries;
  @override
  List<TimeEntry> get pendingEntries {
    if (_pendingEntries is EqualUnmodifiableListView) return _pendingEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingEntries);
  }

  final List<TimeEntry> _rejectedEntries;
  @override
  List<TimeEntry> get rejectedEntries {
    if (_rejectedEntries is EqualUnmodifiableListView) return _rejectedEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rejectedEntries);
  }

  final List<SubmitHoursDateSection> _draftSections;
  @override
  List<SubmitHoursDateSection> get draftSections {
    if (_draftSections is EqualUnmodifiableListView) return _draftSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_draftSections);
  }

  final List<SubmitHoursDateSection> _pendingSections;
  @override
  List<SubmitHoursDateSection> get pendingSections {
    if (_pendingSections is EqualUnmodifiableListView) return _pendingSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingSections);
  }

  final List<SubmitHoursDateSection> _rejectedSections;
  @override
  List<SubmitHoursDateSection> get rejectedSections {
    if (_rejectedSections is EqualUnmodifiableListView)
      return _rejectedSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rejectedSections);
  }

  final List<String> _selectedEntryIds;
  @override
  List<String> get selectedEntryIds {
    if (_selectedEntryIds is EqualUnmodifiableListView)
      return _selectedEntryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedEntryIds);
  }

  @override
  final SubmitHoursQuickSelectPeriod activeQuickSelect;
  @override
  final bool isSubmitting;
  @override
  final int totalDraftMinutes;
  @override
  final int totalPendingMinutes;
  @override
  final int totalRejectedMinutes;
  @override
  final int selectedTotalMinutes;
  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;

  @override
  String toString() {
    return 'SubmitHoursState(draftEntries: $draftEntries, pendingEntries: $pendingEntries, rejectedEntries: $rejectedEntries, draftSections: $draftSections, pendingSections: $pendingSections, rejectedSections: $rejectedSections, selectedEntryIds: $selectedEntryIds, activeQuickSelect: $activeQuickSelect, isSubmitting: $isSubmitting, totalDraftMinutes: $totalDraftMinutes, totalPendingMinutes: $totalPendingMinutes, totalRejectedMinutes: $totalRejectedMinutes, selectedTotalMinutes: $selectedTotalMinutes, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitHoursStateImpl &&
            const DeepCollectionEquality().equals(
              other._draftEntries,
              _draftEntries,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingEntries,
              _pendingEntries,
            ) &&
            const DeepCollectionEquality().equals(
              other._rejectedEntries,
              _rejectedEntries,
            ) &&
            const DeepCollectionEquality().equals(
              other._draftSections,
              _draftSections,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingSections,
              _pendingSections,
            ) &&
            const DeepCollectionEquality().equals(
              other._rejectedSections,
              _rejectedSections,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedEntryIds,
              _selectedEntryIds,
            ) &&
            (identical(other.activeQuickSelect, activeQuickSelect) ||
                other.activeQuickSelect == activeQuickSelect) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.totalDraftMinutes, totalDraftMinutes) ||
                other.totalDraftMinutes == totalDraftMinutes) &&
            (identical(other.totalPendingMinutes, totalPendingMinutes) ||
                other.totalPendingMinutes == totalPendingMinutes) &&
            (identical(other.totalRejectedMinutes, totalRejectedMinutes) ||
                other.totalRejectedMinutes == totalRejectedMinutes) &&
            (identical(other.selectedTotalMinutes, selectedTotalMinutes) ||
                other.selectedTotalMinutes == selectedTotalMinutes) &&
            (identical(other.toastMessage, toastMessage) ||
                other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) ||
                other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_draftEntries),
    const DeepCollectionEquality().hash(_pendingEntries),
    const DeepCollectionEquality().hash(_rejectedEntries),
    const DeepCollectionEquality().hash(_draftSections),
    const DeepCollectionEquality().hash(_pendingSections),
    const DeepCollectionEquality().hash(_rejectedSections),
    const DeepCollectionEquality().hash(_selectedEntryIds),
    activeQuickSelect,
    isSubmitting,
    totalDraftMinutes,
    totalPendingMinutes,
    totalRejectedMinutes,
    selectedTotalMinutes,
    toastMessage,
    toastType,
  );

  /// Create a copy of SubmitHoursState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitHoursStateImplCopyWith<_$SubmitHoursStateImpl> get copyWith =>
      __$$SubmitHoursStateImplCopyWithImpl<_$SubmitHoursStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SubmitHoursState implements SubmitHoursState {
  const factory _SubmitHoursState({
    required final List<TimeEntry> draftEntries,
    required final List<TimeEntry> pendingEntries,
    required final List<TimeEntry> rejectedEntries,
    required final List<SubmitHoursDateSection> draftSections,
    required final List<SubmitHoursDateSection> pendingSections,
    required final List<SubmitHoursDateSection> rejectedSections,
    required final List<String> selectedEntryIds,
    required final SubmitHoursQuickSelectPeriod activeQuickSelect,
    required final bool isSubmitting,
    required final int totalDraftMinutes,
    required final int totalPendingMinutes,
    required final int totalRejectedMinutes,
    required final int selectedTotalMinutes,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$SubmitHoursStateImpl;

  @override
  List<TimeEntry> get draftEntries;
  @override
  List<TimeEntry> get pendingEntries;
  @override
  List<TimeEntry> get rejectedEntries;
  @override
  List<SubmitHoursDateSection> get draftSections;
  @override
  List<SubmitHoursDateSection> get pendingSections;
  @override
  List<SubmitHoursDateSection> get rejectedSections;
  @override
  List<String> get selectedEntryIds;
  @override
  SubmitHoursQuickSelectPeriod get activeQuickSelect;
  @override
  bool get isSubmitting;
  @override
  int get totalDraftMinutes;
  @override
  int get totalPendingMinutes;
  @override
  int get totalRejectedMinutes;
  @override
  int get selectedTotalMinutes;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of SubmitHoursState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitHoursStateImplCopyWith<_$SubmitHoursStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
