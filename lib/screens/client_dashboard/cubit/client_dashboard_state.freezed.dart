// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClientDashboardState {
  DateTime get selectedMonth => throw _privateConstructorUsedError;
  Client? get client => throw _privateConstructorUsedError;
  List<Project> get projects => throw _privateConstructorUsedError;
  List<TimeEntry> get timeEntries => throw _privateConstructorUsedError;
  List<Tag> get tags => throw _privateConstructorUsedError;
  List<Tag> get usedTags => throw _privateConstructorUsedError;
  List<TimeEntry> get filteredEntries => throw _privateConstructorUsedError;
  List<String> get selectedTagIds => throw _privateConstructorUsedError;
  List<Organization> get organizations => throw _privateConstructorUsedError;
  List<OrganizationInvite> get pendingInvites => throw _privateConstructorUsedError;
  String? get activeOrganizationId => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get isPreview => throw _privateConstructorUsedError;
  bool get isSigningOut => throw _privateConstructorUsedError;

  /// Create a copy of ClientDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientDashboardStateCopyWith<ClientDashboardState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientDashboardStateCopyWith<$Res> {
  factory $ClientDashboardStateCopyWith(ClientDashboardState value, $Res Function(ClientDashboardState) then) =
      _$ClientDashboardStateCopyWithImpl<$Res, ClientDashboardState>;
  @useResult
  $Res call({
    DateTime selectedMonth,
    Client? client,
    List<Project> projects,
    List<TimeEntry> timeEntries,
    List<Tag> tags,
    List<Tag> usedTags,
    List<TimeEntry> filteredEntries,
    List<String> selectedTagIds,
    List<Organization> organizations,
    List<OrganizationInvite> pendingInvites,
    String? activeOrganizationId,
    bool isLoading,
    String? error,
    bool isPreview,
    bool isSigningOut,
  });

  $ClientCopyWith<$Res>? get client;
}

/// @nodoc
class _$ClientDashboardStateCopyWithImpl<$Res, $Val extends ClientDashboardState>
    implements $ClientDashboardStateCopyWith<$Res> {
  _$ClientDashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedMonth = null,
    Object? client = freezed,
    Object? projects = null,
    Object? timeEntries = null,
    Object? tags = null,
    Object? usedTags = null,
    Object? filteredEntries = null,
    Object? selectedTagIds = null,
    Object? organizations = null,
    Object? pendingInvites = null,
    Object? activeOrganizationId = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? isPreview = null,
    Object? isSigningOut = null,
  }) {
    return _then(
      _value.copyWith(
            selectedMonth:
                null == selectedMonth
                    ? _value.selectedMonth
                    : selectedMonth // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            client:
                freezed == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as Client?,
            projects:
                null == projects
                    ? _value.projects
                    : projects // ignore: cast_nullable_to_non_nullable
                        as List<Project>,
            timeEntries:
                null == timeEntries
                    ? _value.timeEntries
                    : timeEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<Tag>,
            usedTags:
                null == usedTags
                    ? _value.usedTags
                    : usedTags // ignore: cast_nullable_to_non_nullable
                        as List<Tag>,
            filteredEntries:
                null == filteredEntries
                    ? _value.filteredEntries
                    : filteredEntries // ignore: cast_nullable_to_non_nullable
                        as List<TimeEntry>,
            selectedTagIds:
                null == selectedTagIds
                    ? _value.selectedTagIds
                    : selectedTagIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            organizations:
                null == organizations
                    ? _value.organizations
                    : organizations // ignore: cast_nullable_to_non_nullable
                        as List<Organization>,
            pendingInvites:
                null == pendingInvites
                    ? _value.pendingInvites
                    : pendingInvites // ignore: cast_nullable_to_non_nullable
                        as List<OrganizationInvite>,
            activeOrganizationId:
                freezed == activeOrganizationId
                    ? _value.activeOrganizationId
                    : activeOrganizationId // ignore: cast_nullable_to_non_nullable
                        as String?,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
            isPreview:
                null == isPreview
                    ? _value.isPreview
                    : isPreview // ignore: cast_nullable_to_non_nullable
                        as bool,
            isSigningOut:
                null == isSigningOut
                    ? _value.isSigningOut
                    : isSigningOut // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ClientDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $ClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientDashboardStateImplCopyWith<$Res> implements $ClientDashboardStateCopyWith<$Res> {
  factory _$$ClientDashboardStateImplCopyWith(
    _$ClientDashboardStateImpl value,
    $Res Function(_$ClientDashboardStateImpl) then,
  ) = __$$ClientDashboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime selectedMonth,
    Client? client,
    List<Project> projects,
    List<TimeEntry> timeEntries,
    List<Tag> tags,
    List<Tag> usedTags,
    List<TimeEntry> filteredEntries,
    List<String> selectedTagIds,
    List<Organization> organizations,
    List<OrganizationInvite> pendingInvites,
    String? activeOrganizationId,
    bool isLoading,
    String? error,
    bool isPreview,
    bool isSigningOut,
  });

  @override
  $ClientCopyWith<$Res>? get client;
}

/// @nodoc
class __$$ClientDashboardStateImplCopyWithImpl<$Res>
    extends _$ClientDashboardStateCopyWithImpl<$Res, _$ClientDashboardStateImpl>
    implements _$$ClientDashboardStateImplCopyWith<$Res> {
  __$$ClientDashboardStateImplCopyWithImpl(
    _$ClientDashboardStateImpl _value,
    $Res Function(_$ClientDashboardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedMonth = null,
    Object? client = freezed,
    Object? projects = null,
    Object? timeEntries = null,
    Object? tags = null,
    Object? usedTags = null,
    Object? filteredEntries = null,
    Object? selectedTagIds = null,
    Object? organizations = null,
    Object? pendingInvites = null,
    Object? activeOrganizationId = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? isPreview = null,
    Object? isSigningOut = null,
  }) {
    return _then(
      _$ClientDashboardStateImpl(
        selectedMonth:
            null == selectedMonth
                ? _value.selectedMonth
                : selectedMonth // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        client:
            freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as Client?,
        projects:
            null == projects
                ? _value._projects
                : projects // ignore: cast_nullable_to_non_nullable
                    as List<Project>,
        timeEntries:
            null == timeEntries
                ? _value._timeEntries
                : timeEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<Tag>,
        usedTags:
            null == usedTags
                ? _value._usedTags
                : usedTags // ignore: cast_nullable_to_non_nullable
                    as List<Tag>,
        filteredEntries:
            null == filteredEntries
                ? _value._filteredEntries
                : filteredEntries // ignore: cast_nullable_to_non_nullable
                    as List<TimeEntry>,
        selectedTagIds:
            null == selectedTagIds
                ? _value._selectedTagIds
                : selectedTagIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        organizations:
            null == organizations
                ? _value._organizations
                : organizations // ignore: cast_nullable_to_non_nullable
                    as List<Organization>,
        pendingInvites:
            null == pendingInvites
                ? _value._pendingInvites
                : pendingInvites // ignore: cast_nullable_to_non_nullable
                    as List<OrganizationInvite>,
        activeOrganizationId:
            freezed == activeOrganizationId
                ? _value.activeOrganizationId
                : activeOrganizationId // ignore: cast_nullable_to_non_nullable
                    as String?,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
        isPreview:
            null == isPreview
                ? _value.isPreview
                : isPreview // ignore: cast_nullable_to_non_nullable
                    as bool,
        isSigningOut:
            null == isSigningOut
                ? _value.isSigningOut
                : isSigningOut // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$ClientDashboardStateImpl implements _ClientDashboardState {
  const _$ClientDashboardStateImpl({
    required this.selectedMonth,
    this.client,
    final List<Project> projects = const [],
    final List<TimeEntry> timeEntries = const [],
    final List<Tag> tags = const [],
    final List<Tag> usedTags = const [],
    final List<TimeEntry> filteredEntries = const [],
    final List<String> selectedTagIds = const [],
    final List<Organization> organizations = const [],
    final List<OrganizationInvite> pendingInvites = const [],
    this.activeOrganizationId,
    this.isLoading = false,
    this.error,
    this.isPreview = false,
    this.isSigningOut = false,
  }) : _projects = projects,
       _timeEntries = timeEntries,
       _tags = tags,
       _usedTags = usedTags,
       _filteredEntries = filteredEntries,
       _selectedTagIds = selectedTagIds,
       _organizations = organizations,
       _pendingInvites = pendingInvites;

  @override
  final DateTime selectedMonth;
  @override
  final Client? client;
  final List<Project> _projects;
  @override
  @JsonKey()
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  final List<TimeEntry> _timeEntries;
  @override
  @JsonKey()
  List<TimeEntry> get timeEntries {
    if (_timeEntries is EqualUnmodifiableListView) return _timeEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeEntries);
  }

  final List<Tag> _tags;
  @override
  @JsonKey()
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<Tag> _usedTags;
  @override
  @JsonKey()
  List<Tag> get usedTags {
    if (_usedTags is EqualUnmodifiableListView) return _usedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usedTags);
  }

  final List<TimeEntry> _filteredEntries;
  @override
  @JsonKey()
  List<TimeEntry> get filteredEntries {
    if (_filteredEntries is EqualUnmodifiableListView) return _filteredEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredEntries);
  }

  final List<String> _selectedTagIds;
  @override
  @JsonKey()
  List<String> get selectedTagIds {
    if (_selectedTagIds is EqualUnmodifiableListView) return _selectedTagIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTagIds);
  }

  final List<Organization> _organizations;
  @override
  @JsonKey()
  List<Organization> get organizations {
    if (_organizations is EqualUnmodifiableListView) return _organizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_organizations);
  }

  final List<OrganizationInvite> _pendingInvites;
  @override
  @JsonKey()
  List<OrganizationInvite> get pendingInvites {
    if (_pendingInvites is EqualUnmodifiableListView) return _pendingInvites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingInvites);
  }

  @override
  final String? activeOrganizationId;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isPreview;
  @override
  @JsonKey()
  final bool isSigningOut;

  @override
  String toString() {
    return 'ClientDashboardState(selectedMonth: $selectedMonth, client: $client, projects: $projects, timeEntries: $timeEntries, tags: $tags, usedTags: $usedTags, filteredEntries: $filteredEntries, selectedTagIds: $selectedTagIds, organizations: $organizations, pendingInvites: $pendingInvites, activeOrganizationId: $activeOrganizationId, isLoading: $isLoading, error: $error, isPreview: $isPreview, isSigningOut: $isSigningOut)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientDashboardStateImpl &&
            (identical(other.selectedMonth, selectedMonth) || other.selectedMonth == selectedMonth) &&
            (identical(other.client, client) || other.client == client) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            const DeepCollectionEquality().equals(other._timeEntries, _timeEntries) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._usedTags, _usedTags) &&
            const DeepCollectionEquality().equals(other._filteredEntries, _filteredEntries) &&
            const DeepCollectionEquality().equals(other._selectedTagIds, _selectedTagIds) &&
            const DeepCollectionEquality().equals(other._organizations, _organizations) &&
            const DeepCollectionEquality().equals(other._pendingInvites, _pendingInvites) &&
            (identical(other.activeOrganizationId, activeOrganizationId) ||
                other.activeOrganizationId == activeOrganizationId) &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isPreview, isPreview) || other.isPreview == isPreview) &&
            (identical(other.isSigningOut, isSigningOut) || other.isSigningOut == isSigningOut));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedMonth,
    client,
    const DeepCollectionEquality().hash(_projects),
    const DeepCollectionEquality().hash(_timeEntries),
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_usedTags),
    const DeepCollectionEquality().hash(_filteredEntries),
    const DeepCollectionEquality().hash(_selectedTagIds),
    const DeepCollectionEquality().hash(_organizations),
    const DeepCollectionEquality().hash(_pendingInvites),
    activeOrganizationId,
    isLoading,
    error,
    isPreview,
    isSigningOut,
  );

  /// Create a copy of ClientDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientDashboardStateImplCopyWith<_$ClientDashboardStateImpl> get copyWith =>
      __$$ClientDashboardStateImplCopyWithImpl<_$ClientDashboardStateImpl>(this, _$identity);
}

abstract class _ClientDashboardState implements ClientDashboardState {
  const factory _ClientDashboardState({
    required final DateTime selectedMonth,
    final Client? client,
    final List<Project> projects,
    final List<TimeEntry> timeEntries,
    final List<Tag> tags,
    final List<Tag> usedTags,
    final List<TimeEntry> filteredEntries,
    final List<String> selectedTagIds,
    final List<Organization> organizations,
    final List<OrganizationInvite> pendingInvites,
    final String? activeOrganizationId,
    final bool isLoading,
    final String? error,
    final bool isPreview,
    final bool isSigningOut,
  }) = _$ClientDashboardStateImpl;

  @override
  DateTime get selectedMonth;
  @override
  Client? get client;
  @override
  List<Project> get projects;
  @override
  List<TimeEntry> get timeEntries;
  @override
  List<Tag> get tags;
  @override
  List<Tag> get usedTags;
  @override
  List<TimeEntry> get filteredEntries;
  @override
  List<String> get selectedTagIds;
  @override
  List<Organization> get organizations;
  @override
  List<OrganizationInvite> get pendingInvites;
  @override
  String? get activeOrganizationId;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool get isPreview;
  @override
  bool get isSigningOut;

  /// Create a copy of ClientDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientDashboardStateImplCopyWith<_$ClientDashboardStateImpl> get copyWith => throw _privateConstructorUsedError;
}
