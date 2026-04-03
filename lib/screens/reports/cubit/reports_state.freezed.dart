// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReportsState {
  ReportPeriod get selectedPeriod => throw _privateConstructorUsedError;
  DateTimeRange<DateTime> get selectedRange =>
      throw _privateConstructorUsedError;
  List<String> get selectedProjectIds => throw _privateConstructorUsedError;
  List<String> get selectedClientIds => throw _privateConstructorUsedError;
  List<String> get selectedTagIds => throw _privateConstructorUsedError;
  List<String> get selectedMemberIds => throw _privateConstructorUsedError;
  GroupBy get groupBy => throw _privateConstructorUsedError;
  SortBy get sortBy => throw _privateConstructorUsedError;
  bool get sortDescending => throw _privateConstructorUsedError;
  List<TimeEntry> get filteredEntries => throw _privateConstructorUsedError;
  int get totalMatchingEntries => throw _privateConstructorUsedError;
  bool get hasMoreEntries => throw _privateConstructorUsedError;
  Map<String, int> get minutesByProject => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;
  int get uniqueDays => throw _privateConstructorUsedError;
  List<Project> get filteredProjects => throw _privateConstructorUsedError;
  List<Client> get filteredClients => throw _privateConstructorUsedError;
  List<TeamMember> get filteredMembers => throw _privateConstructorUsedError;
  List<Tag> get tags => throw _privateConstructorUsedError;
  bool get canChangeMembers => throw _privateConstructorUsedError;
  bool get hasFilters => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportsStateCopyWith<ReportsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportsStateCopyWith<$Res> {
  factory $ReportsStateCopyWith(
    ReportsState value,
    $Res Function(ReportsState) then,
  ) = _$ReportsStateCopyWithImpl<$Res, ReportsState>;
  @useResult
  $Res call({
    ReportPeriod selectedPeriod,
    DateTimeRange<DateTime> selectedRange,
    List<String> selectedProjectIds,
    List<String> selectedClientIds,
    List<String> selectedTagIds,
    List<String> selectedMemberIds,
    GroupBy groupBy,
    SortBy sortBy,
    bool sortDescending,
    List<TimeEntry> filteredEntries,
    int totalMatchingEntries,
    bool hasMoreEntries,
    Map<String, int> minutesByProject,
    int totalMinutes,
    int uniqueDays,
    List<Project> filteredProjects,
    List<Client> filteredClients,
    List<TeamMember> filteredMembers,
    List<Tag> tags,
    bool canChangeMembers,
    bool hasFilters,
    bool isLoading,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class _$ReportsStateCopyWithImpl<$Res, $Val extends ReportsState>
    implements $ReportsStateCopyWith<$Res> {
  _$ReportsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedPeriod = null,
    Object? selectedRange = null,
    Object? selectedProjectIds = null,
    Object? selectedClientIds = null,
    Object? selectedTagIds = null,
    Object? selectedMemberIds = null,
    Object? groupBy = null,
    Object? sortBy = null,
    Object? sortDescending = null,
    Object? filteredEntries = null,
    Object? totalMatchingEntries = null,
    Object? hasMoreEntries = null,
    Object? minutesByProject = null,
    Object? totalMinutes = null,
    Object? uniqueDays = null,
    Object? filteredProjects = null,
    Object? filteredClients = null,
    Object? filteredMembers = null,
    Object? tags = null,
    Object? canChangeMembers = null,
    Object? hasFilters = null,
    Object? isLoading = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedPeriod:
                null == selectedPeriod
                    ? _value.selectedPeriod
                    : selectedPeriod // ignore: cast_nullable_to_non_nullable
                        as ReportPeriod,
            selectedRange:
                null == selectedRange
                    ? _value.selectedRange
                    : selectedRange // ignore: cast_nullable_to_non_nullable
                        as DateTimeRange<DateTime>,
            selectedProjectIds:
                null == selectedProjectIds
                    ? _value.selectedProjectIds
                    : selectedProjectIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            selectedClientIds:
                null == selectedClientIds
                    ? _value.selectedClientIds
                    : selectedClientIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            selectedTagIds:
                null == selectedTagIds
                    ? _value.selectedTagIds
                    : selectedTagIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            selectedMemberIds:
                null == selectedMemberIds
                    ? _value.selectedMemberIds
                    : selectedMemberIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            groupBy:
                null == groupBy
                    ? _value.groupBy
                    : groupBy // ignore: cast_nullable_to_non_nullable
                        as GroupBy,
            sortBy:
                null == sortBy
                    ? _value.sortBy
                    : sortBy // ignore: cast_nullable_to_non_nullable
                        as SortBy,
            sortDescending:
                null == sortDescending
                    ? _value.sortDescending
                    : sortDescending // ignore: cast_nullable_to_non_nullable
                        as bool,
            filteredEntries:
                null == filteredEntries
                    ? _value.filteredEntries
                    : filteredEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            totalMatchingEntries:
                null == totalMatchingEntries
                    ? _value.totalMatchingEntries
                    : totalMatchingEntries // ignore: cast_nullable_to_non_nullable
                        as int,
            hasMoreEntries:
                null == hasMoreEntries
                    ? _value.hasMoreEntries
                    : hasMoreEntries // ignore: cast_nullable_to_non_nullable
                        as bool,
            minutesByProject:
                null == minutesByProject
                    ? _value.minutesByProject
                    : minutesByProject // ignore: cast_nullable_to_non_nullable
                        as Map<String, int>,
            totalMinutes:
                null == totalMinutes
                    ? _value.totalMinutes
                    : totalMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
            uniqueDays:
                null == uniqueDays
                    ? _value.uniqueDays
                    : uniqueDays // ignore: cast_nullable_to_non_nullable
                        as int,
            filteredProjects:
                null == filteredProjects
                    ? _value.filteredProjects
                    : filteredProjects // ignore: cast_nullable_to_non_nullable
                        as List<Project>,
            filteredClients:
                null == filteredClients
                    ? _value.filteredClients
                    : filteredClients // ignore: cast_nullable_to_non_nullable
                        as List<Client>,
            filteredMembers:
                null == filteredMembers
                    ? _value.filteredMembers
                    : filteredMembers // ignore: cast_nullable_to_non_nullable
                        as List<TeamMember>,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<Tag>,
            canChangeMembers:
                null == canChangeMembers
                    ? _value.canChangeMembers
                    : canChangeMembers // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasFilters:
                null == hasFilters
                    ? _value.hasFilters
                    : hasFilters // ignore: cast_nullable_to_non_nullable
                        as bool,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportsStateImplCopyWith<$Res>
    implements $ReportsStateCopyWith<$Res> {
  factory _$$ReportsStateImplCopyWith(
    _$ReportsStateImpl value,
    $Res Function(_$ReportsStateImpl) then,
  ) = __$$ReportsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReportPeriod selectedPeriod,
    DateTimeRange<DateTime> selectedRange,
    List<String> selectedProjectIds,
    List<String> selectedClientIds,
    List<String> selectedTagIds,
    List<String> selectedMemberIds,
    GroupBy groupBy,
    SortBy sortBy,
    bool sortDescending,
    List<TimeEntry> filteredEntries,
    int totalMatchingEntries,
    bool hasMoreEntries,
    Map<String, int> minutesByProject,
    int totalMinutes,
    int uniqueDays,
    List<Project> filteredProjects,
    List<Client> filteredClients,
    List<TeamMember> filteredMembers,
    List<Tag> tags,
    bool canChangeMembers,
    bool hasFilters,
    bool isLoading,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class __$$ReportsStateImplCopyWithImpl<$Res>
    extends _$ReportsStateCopyWithImpl<$Res, _$ReportsStateImpl>
    implements _$$ReportsStateImplCopyWith<$Res> {
  __$$ReportsStateImplCopyWithImpl(
    _$ReportsStateImpl _value,
    $Res Function(_$ReportsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedPeriod = null,
    Object? selectedRange = null,
    Object? selectedProjectIds = null,
    Object? selectedClientIds = null,
    Object? selectedTagIds = null,
    Object? selectedMemberIds = null,
    Object? groupBy = null,
    Object? sortBy = null,
    Object? sortDescending = null,
    Object? filteredEntries = null,
    Object? totalMatchingEntries = null,
    Object? hasMoreEntries = null,
    Object? minutesByProject = null,
    Object? totalMinutes = null,
    Object? uniqueDays = null,
    Object? filteredProjects = null,
    Object? filteredClients = null,
    Object? filteredMembers = null,
    Object? tags = null,
    Object? canChangeMembers = null,
    Object? hasFilters = null,
    Object? isLoading = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$ReportsStateImpl(
        selectedPeriod:
            null == selectedPeriod
                ? _value.selectedPeriod
                : selectedPeriod // ignore: cast_nullable_to_non_nullable
                    as ReportPeriod,
        selectedRange:
            null == selectedRange
                ? _value.selectedRange
                : selectedRange // ignore: cast_nullable_to_non_nullable
                    as DateTimeRange<DateTime>,
        selectedProjectIds:
            null == selectedProjectIds
                ? _value._selectedProjectIds
                : selectedProjectIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        selectedClientIds:
            null == selectedClientIds
                ? _value._selectedClientIds
                : selectedClientIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        selectedTagIds:
            null == selectedTagIds
                ? _value._selectedTagIds
                : selectedTagIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        selectedMemberIds:
            null == selectedMemberIds
                ? _value._selectedMemberIds
                : selectedMemberIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        groupBy:
            null == groupBy
                ? _value.groupBy
                : groupBy // ignore: cast_nullable_to_non_nullable
                    as GroupBy,
        sortBy:
            null == sortBy
                ? _value.sortBy
                : sortBy // ignore: cast_nullable_to_non_nullable
                    as SortBy,
        sortDescending:
            null == sortDescending
                ? _value.sortDescending
                : sortDescending // ignore: cast_nullable_to_non_nullable
                    as bool,
        filteredEntries:
            null == filteredEntries
                ? _value._filteredEntries
                : filteredEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        totalMatchingEntries:
            null == totalMatchingEntries
                ? _value.totalMatchingEntries
                : totalMatchingEntries // ignore: cast_nullable_to_non_nullable
                    as int,
        hasMoreEntries:
            null == hasMoreEntries
                ? _value.hasMoreEntries
                : hasMoreEntries // ignore: cast_nullable_to_non_nullable
                    as bool,
        minutesByProject:
            null == minutesByProject
                ? _value._minutesByProject
                : minutesByProject // ignore: cast_nullable_to_non_nullable
                    as Map<String, int>,
        totalMinutes:
            null == totalMinutes
                ? _value.totalMinutes
                : totalMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
        uniqueDays:
            null == uniqueDays
                ? _value.uniqueDays
                : uniqueDays // ignore: cast_nullable_to_non_nullable
                    as int,
        filteredProjects:
            null == filteredProjects
                ? _value._filteredProjects
                : filteredProjects // ignore: cast_nullable_to_non_nullable
                    as List<Project>,
        filteredClients:
            null == filteredClients
                ? _value._filteredClients
                : filteredClients // ignore: cast_nullable_to_non_nullable
                    as List<Client>,
        filteredMembers:
            null == filteredMembers
                ? _value._filteredMembers
                : filteredMembers // ignore: cast_nullable_to_non_nullable
                    as List<TeamMember>,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<Tag>,
        canChangeMembers:
            null == canChangeMembers
                ? _value.canChangeMembers
                : canChangeMembers // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasFilters:
            null == hasFilters
                ? _value.hasFilters
                : hasFilters // ignore: cast_nullable_to_non_nullable
                    as bool,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc

class _$ReportsStateImpl implements _ReportsState {
  const _$ReportsStateImpl({
    required this.selectedPeriod,
    required this.selectedRange,
    required final List<String> selectedProjectIds,
    required final List<String> selectedClientIds,
    required final List<String> selectedTagIds,
    required final List<String> selectedMemberIds,
    required this.groupBy,
    required this.sortBy,
    required this.sortDescending,
    required final List<TimeEntry> filteredEntries,
    required this.totalMatchingEntries,
    required this.hasMoreEntries,
    required final Map<String, int> minutesByProject,
    required this.totalMinutes,
    required this.uniqueDays,
    required final List<Project> filteredProjects,
    required final List<Client> filteredClients,
    required final List<TeamMember> filteredMembers,
    required final List<Tag> tags,
    required this.canChangeMembers,
    required this.hasFilters,
    required this.isLoading,
    this.toastMessage,
    this.toastType,
  }) : _selectedProjectIds = selectedProjectIds,
       _selectedClientIds = selectedClientIds,
       _selectedTagIds = selectedTagIds,
       _selectedMemberIds = selectedMemberIds,
       _filteredEntries = filteredEntries,
       _minutesByProject = minutesByProject,
       _filteredProjects = filteredProjects,
       _filteredClients = filteredClients,
       _filteredMembers = filteredMembers,
       _tags = tags;

  @override
  final ReportPeriod selectedPeriod;
  @override
  final DateTimeRange<DateTime> selectedRange;
  final List<String> _selectedProjectIds;
  @override
  List<String> get selectedProjectIds {
    if (_selectedProjectIds is EqualUnmodifiableListView)
      return _selectedProjectIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedProjectIds);
  }

  final List<String> _selectedClientIds;
  @override
  List<String> get selectedClientIds {
    if (_selectedClientIds is EqualUnmodifiableListView)
      return _selectedClientIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedClientIds);
  }

  final List<String> _selectedTagIds;
  @override
  List<String> get selectedTagIds {
    if (_selectedTagIds is EqualUnmodifiableListView) return _selectedTagIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTagIds);
  }

  final List<String> _selectedMemberIds;
  @override
  List<String> get selectedMemberIds {
    if (_selectedMemberIds is EqualUnmodifiableListView)
      return _selectedMemberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedMemberIds);
  }

  @override
  final GroupBy groupBy;
  @override
  final SortBy sortBy;
  @override
  final bool sortDescending;
  final List<TimeEntry> _filteredEntries;
  @override
  List<TimeEntry> get filteredEntries {
    if (_filteredEntries is EqualUnmodifiableListView) return _filteredEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredEntries);
  }

  @override
  final int totalMatchingEntries;
  @override
  final bool hasMoreEntries;
  final Map<String, int> _minutesByProject;
  @override
  Map<String, int> get minutesByProject {
    if (_minutesByProject is EqualUnmodifiableMapView) return _minutesByProject;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_minutesByProject);
  }

  @override
  final int totalMinutes;
  @override
  final int uniqueDays;
  final List<Project> _filteredProjects;
  @override
  List<Project> get filteredProjects {
    if (_filteredProjects is EqualUnmodifiableListView)
      return _filteredProjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredProjects);
  }

  final List<Client> _filteredClients;
  @override
  List<Client> get filteredClients {
    if (_filteredClients is EqualUnmodifiableListView) return _filteredClients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredClients);
  }

  final List<TeamMember> _filteredMembers;
  @override
  List<TeamMember> get filteredMembers {
    if (_filteredMembers is EqualUnmodifiableListView) return _filteredMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredMembers);
  }

  final List<Tag> _tags;
  @override
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final bool canChangeMembers;
  @override
  final bool hasFilters;
  @override
  final bool isLoading;
  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;

  @override
  String toString() {
    return 'ReportsState(selectedPeriod: $selectedPeriod, selectedRange: $selectedRange, selectedProjectIds: $selectedProjectIds, selectedClientIds: $selectedClientIds, selectedTagIds: $selectedTagIds, selectedMemberIds: $selectedMemberIds, groupBy: $groupBy, sortBy: $sortBy, sortDescending: $sortDescending, filteredEntries: $filteredEntries, totalMatchingEntries: $totalMatchingEntries, hasMoreEntries: $hasMoreEntries, minutesByProject: $minutesByProject, totalMinutes: $totalMinutes, uniqueDays: $uniqueDays, filteredProjects: $filteredProjects, filteredClients: $filteredClients, filteredMembers: $filteredMembers, tags: $tags, canChangeMembers: $canChangeMembers, hasFilters: $hasFilters, isLoading: $isLoading, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportsStateImpl &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.selectedRange, selectedRange) ||
                other.selectedRange == selectedRange) &&
            const DeepCollectionEquality().equals(
              other._selectedProjectIds,
              _selectedProjectIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedClientIds,
              _selectedClientIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedTagIds,
              _selectedTagIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedMemberIds,
              _selectedMemberIds,
            ) &&
            (identical(other.groupBy, groupBy) || other.groupBy == groupBy) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortDescending, sortDescending) ||
                other.sortDescending == sortDescending) &&
            const DeepCollectionEquality().equals(
              other._filteredEntries,
              _filteredEntries,
            ) &&
            (identical(other.totalMatchingEntries, totalMatchingEntries) ||
                other.totalMatchingEntries == totalMatchingEntries) &&
            (identical(other.hasMoreEntries, hasMoreEntries) ||
                other.hasMoreEntries == hasMoreEntries) &&
            const DeepCollectionEquality().equals(
              other._minutesByProject,
              _minutesByProject,
            ) &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes) &&
            (identical(other.uniqueDays, uniqueDays) ||
                other.uniqueDays == uniqueDays) &&
            const DeepCollectionEquality().equals(
              other._filteredProjects,
              _filteredProjects,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredClients,
              _filteredClients,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredMembers,
              _filteredMembers,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.canChangeMembers, canChangeMembers) ||
                other.canChangeMembers == canChangeMembers) &&
            (identical(other.hasFilters, hasFilters) ||
                other.hasFilters == hasFilters) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.toastMessage, toastMessage) ||
                other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) ||
                other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    selectedPeriod,
    selectedRange,
    const DeepCollectionEquality().hash(_selectedProjectIds),
    const DeepCollectionEquality().hash(_selectedClientIds),
    const DeepCollectionEquality().hash(_selectedTagIds),
    const DeepCollectionEquality().hash(_selectedMemberIds),
    groupBy,
    sortBy,
    sortDescending,
    const DeepCollectionEquality().hash(_filteredEntries),
    totalMatchingEntries,
    hasMoreEntries,
    const DeepCollectionEquality().hash(_minutesByProject),
    totalMinutes,
    uniqueDays,
    const DeepCollectionEquality().hash(_filteredProjects),
    const DeepCollectionEquality().hash(_filteredClients),
    const DeepCollectionEquality().hash(_filteredMembers),
    const DeepCollectionEquality().hash(_tags),
    canChangeMembers,
    hasFilters,
    isLoading,
    toastMessage,
    toastType,
  ]);

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportsStateImplCopyWith<_$ReportsStateImpl> get copyWith =>
      __$$ReportsStateImplCopyWithImpl<_$ReportsStateImpl>(this, _$identity);
}

abstract class _ReportsState implements ReportsState {
  const factory _ReportsState({
    required final ReportPeriod selectedPeriod,
    required final DateTimeRange<DateTime> selectedRange,
    required final List<String> selectedProjectIds,
    required final List<String> selectedClientIds,
    required final List<String> selectedTagIds,
    required final List<String> selectedMemberIds,
    required final GroupBy groupBy,
    required final SortBy sortBy,
    required final bool sortDescending,
    required final List<TimeEntry> filteredEntries,
    required final int totalMatchingEntries,
    required final bool hasMoreEntries,
    required final Map<String, int> minutesByProject,
    required final int totalMinutes,
    required final int uniqueDays,
    required final List<Project> filteredProjects,
    required final List<Client> filteredClients,
    required final List<TeamMember> filteredMembers,
    required final List<Tag> tags,
    required final bool canChangeMembers,
    required final bool hasFilters,
    required final bool isLoading,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$ReportsStateImpl;

  @override
  ReportPeriod get selectedPeriod;
  @override
  DateTimeRange<DateTime> get selectedRange;
  @override
  List<String> get selectedProjectIds;
  @override
  List<String> get selectedClientIds;
  @override
  List<String> get selectedTagIds;
  @override
  List<String> get selectedMemberIds;
  @override
  GroupBy get groupBy;
  @override
  SortBy get sortBy;
  @override
  bool get sortDescending;
  @override
  List<TimeEntry> get filteredEntries;
  @override
  int get totalMatchingEntries;
  @override
  bool get hasMoreEntries;
  @override
  Map<String, int> get minutesByProject;
  @override
  int get totalMinutes;
  @override
  int get uniqueDays;
  @override
  List<Project> get filteredProjects;
  @override
  List<Client> get filteredClients;
  @override
  List<TeamMember> get filteredMembers;
  @override
  List<Tag> get tags;
  @override
  bool get canChangeMembers;
  @override
  bool get hasFilters;
  @override
  bool get isLoading;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of ReportsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportsStateImplCopyWith<_$ReportsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
