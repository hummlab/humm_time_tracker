// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clickup_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClickupSettingsState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  bool get isSyncing => throw _privateConstructorUsedError;
  ClickUpSettings? get settings => throw _privateConstructorUsedError;
  List<ClickUpWorkspace> get workspaces => throw _privateConstructorUsedError;
  List<ClickUpSpace> get spaces => throw _privateConstructorUsedError;
  Map<String, List<ClickUpFolder>> get foldersBySpace => throw _privateConstructorUsedError;
  Map<String, List<ClickUpList>> get folderlessListsBySpace => throw _privateConstructorUsedError;
  String? get selectedWorkspaceId => throw _privateConstructorUsedError;
  List<String> get selectedListIds => throw _privateConstructorUsedError;
  Map<String, String> get listProjectAssignments => throw _privateConstructorUsedError;
  Set<String> get expandedSpaces => throw _privateConstructorUsedError;
  Set<String> get expandedFolders => throw _privateConstructorUsedError;
  List<Project> get projects => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of ClickupSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickupSettingsStateCopyWith<ClickupSettingsState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickupSettingsStateCopyWith<$Res> {
  factory $ClickupSettingsStateCopyWith(ClickupSettingsState value, $Res Function(ClickupSettingsState) then) =
      _$ClickupSettingsStateCopyWithImpl<$Res, ClickupSettingsState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isSaving,
    bool isSyncing,
    ClickUpSettings? settings,
    List<ClickUpWorkspace> workspaces,
    List<ClickUpSpace> spaces,
    Map<String, List<ClickUpFolder>> foldersBySpace,
    Map<String, List<ClickUpList>> folderlessListsBySpace,
    String? selectedWorkspaceId,
    List<String> selectedListIds,
    Map<String, String> listProjectAssignments,
    Set<String> expandedSpaces,
    Set<String> expandedFolders,
    List<Project> projects,
    String? toastMessage,
    AppToastType? toastType,
  });

  $ClickUpSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$ClickupSettingsStateCopyWithImpl<$Res, $Val extends ClickupSettingsState>
    implements $ClickupSettingsStateCopyWith<$Res> {
  _$ClickupSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickupSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isSyncing = null,
    Object? settings = freezed,
    Object? workspaces = null,
    Object? spaces = null,
    Object? foldersBySpace = null,
    Object? folderlessListsBySpace = null,
    Object? selectedWorkspaceId = freezed,
    Object? selectedListIds = null,
    Object? listProjectAssignments = null,
    Object? expandedSpaces = null,
    Object? expandedFolders = null,
    Object? projects = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            isSaving:
                null == isSaving
                    ? _value.isSaving
                    : isSaving // ignore: cast_nullable_to_non_nullable
                        as bool,
            isSyncing:
                null == isSyncing
                    ? _value.isSyncing
                    : isSyncing // ignore: cast_nullable_to_non_nullable
                        as bool,
            settings:
                freezed == settings
                    ? _value.settings
                    : settings // ignore: cast_nullable_to_non_nullable
                        as ClickUpSettings?,
            workspaces:
                null == workspaces
                    ? _value.workspaces
                    : workspaces // ignore: cast_nullable_to_non_nullable
                        as List<ClickUpWorkspace>,
            spaces:
                null == spaces
                    ? _value.spaces
                    : spaces // ignore: cast_nullable_to_non_nullable
                        as List<ClickUpSpace>,
            foldersBySpace:
                null == foldersBySpace
                    ? _value.foldersBySpace
                    : foldersBySpace // ignore: cast_nullable_to_non_nullable
                        as Map<String, List<ClickUpFolder>>,
            folderlessListsBySpace:
                null == folderlessListsBySpace
                    ? _value.folderlessListsBySpace
                    : folderlessListsBySpace // ignore: cast_nullable_to_non_nullable
                        as Map<String, List<ClickUpList>>,
            selectedWorkspaceId:
                freezed == selectedWorkspaceId
                    ? _value.selectedWorkspaceId
                    : selectedWorkspaceId // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedListIds:
                null == selectedListIds
                    ? _value.selectedListIds
                    : selectedListIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            listProjectAssignments:
                null == listProjectAssignments
                    ? _value.listProjectAssignments
                    : listProjectAssignments // ignore: cast_nullable_to_non_nullable
                        as Map<String, String>,
            expandedSpaces:
                null == expandedSpaces
                    ? _value.expandedSpaces
                    : expandedSpaces // ignore: cast_nullable_to_non_nullable
                        as Set<String>,
            expandedFolders:
                null == expandedFolders
                    ? _value.expandedFolders
                    : expandedFolders // ignore: cast_nullable_to_non_nullable
                        as Set<String>,
            projects:
                null == projects
                    ? _value.projects
                    : projects // ignore: cast_nullable_to_non_nullable
                        as List<Project>,
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

  /// Create a copy of ClickupSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClickUpSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $ClickUpSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClickupSettingsStateImplCopyWith<$Res> implements $ClickupSettingsStateCopyWith<$Res> {
  factory _$$ClickupSettingsStateImplCopyWith(
    _$ClickupSettingsStateImpl value,
    $Res Function(_$ClickupSettingsStateImpl) then,
  ) = __$$ClickupSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isSaving,
    bool isSyncing,
    ClickUpSettings? settings,
    List<ClickUpWorkspace> workspaces,
    List<ClickUpSpace> spaces,
    Map<String, List<ClickUpFolder>> foldersBySpace,
    Map<String, List<ClickUpList>> folderlessListsBySpace,
    String? selectedWorkspaceId,
    List<String> selectedListIds,
    Map<String, String> listProjectAssignments,
    Set<String> expandedSpaces,
    Set<String> expandedFolders,
    List<Project> projects,
    String? toastMessage,
    AppToastType? toastType,
  });

  @override
  $ClickUpSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$ClickupSettingsStateImplCopyWithImpl<$Res>
    extends _$ClickupSettingsStateCopyWithImpl<$Res, _$ClickupSettingsStateImpl>
    implements _$$ClickupSettingsStateImplCopyWith<$Res> {
  __$$ClickupSettingsStateImplCopyWithImpl(
    _$ClickupSettingsStateImpl _value,
    $Res Function(_$ClickupSettingsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClickupSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isSyncing = null,
    Object? settings = freezed,
    Object? workspaces = null,
    Object? spaces = null,
    Object? foldersBySpace = null,
    Object? folderlessListsBySpace = null,
    Object? selectedWorkspaceId = freezed,
    Object? selectedListIds = null,
    Object? listProjectAssignments = null,
    Object? expandedSpaces = null,
    Object? expandedFolders = null,
    Object? projects = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$ClickupSettingsStateImpl(
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        isSaving:
            null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                    as bool,
        isSyncing:
            null == isSyncing
                ? _value.isSyncing
                : isSyncing // ignore: cast_nullable_to_non_nullable
                    as bool,
        settings:
            freezed == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                    as ClickUpSettings?,
        workspaces:
            null == workspaces
                ? _value._workspaces
                : workspaces // ignore: cast_nullable_to_non_nullable
                    as List<ClickUpWorkspace>,
        spaces:
            null == spaces
                ? _value._spaces
                : spaces // ignore: cast_nullable_to_non_nullable
                    as List<ClickUpSpace>,
        foldersBySpace:
            null == foldersBySpace
                ? _value._foldersBySpace
                : foldersBySpace // ignore: cast_nullable_to_non_nullable
                    as Map<String, List<ClickUpFolder>>,
        folderlessListsBySpace:
            null == folderlessListsBySpace
                ? _value._folderlessListsBySpace
                : folderlessListsBySpace // ignore: cast_nullable_to_non_nullable
                    as Map<String, List<ClickUpList>>,
        selectedWorkspaceId:
            freezed == selectedWorkspaceId
                ? _value.selectedWorkspaceId
                : selectedWorkspaceId // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedListIds:
            null == selectedListIds
                ? _value._selectedListIds
                : selectedListIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        listProjectAssignments:
            null == listProjectAssignments
                ? _value._listProjectAssignments
                : listProjectAssignments // ignore: cast_nullable_to_non_nullable
                    as Map<String, String>,
        expandedSpaces:
            null == expandedSpaces
                ? _value._expandedSpaces
                : expandedSpaces // ignore: cast_nullable_to_non_nullable
                    as Set<String>,
        expandedFolders:
            null == expandedFolders
                ? _value._expandedFolders
                : expandedFolders // ignore: cast_nullable_to_non_nullable
                    as Set<String>,
        projects:
            null == projects
                ? _value._projects
                : projects // ignore: cast_nullable_to_non_nullable
                    as List<Project>,
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

class _$ClickupSettingsStateImpl implements _ClickupSettingsState {
  const _$ClickupSettingsStateImpl({
    this.isLoading = true,
    this.isSaving = false,
    this.isSyncing = false,
    this.settings,
    final List<ClickUpWorkspace> workspaces = const [],
    final List<ClickUpSpace> spaces = const [],
    final Map<String, List<ClickUpFolder>> foldersBySpace = const {},
    final Map<String, List<ClickUpList>> folderlessListsBySpace = const {},
    this.selectedWorkspaceId,
    final List<String> selectedListIds = const [],
    final Map<String, String> listProjectAssignments = const {},
    final Set<String> expandedSpaces = const <String>{},
    final Set<String> expandedFolders = const <String>{},
    final List<Project> projects = const [],
    this.toastMessage,
    this.toastType,
  }) : _workspaces = workspaces,
       _spaces = spaces,
       _foldersBySpace = foldersBySpace,
       _folderlessListsBySpace = folderlessListsBySpace,
       _selectedListIds = selectedListIds,
       _listProjectAssignments = listProjectAssignments,
       _expandedSpaces = expandedSpaces,
       _expandedFolders = expandedFolders,
       _projects = projects;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isSyncing;
  @override
  final ClickUpSettings? settings;
  final List<ClickUpWorkspace> _workspaces;
  @override
  @JsonKey()
  List<ClickUpWorkspace> get workspaces {
    if (_workspaces is EqualUnmodifiableListView) return _workspaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workspaces);
  }

  final List<ClickUpSpace> _spaces;
  @override
  @JsonKey()
  List<ClickUpSpace> get spaces {
    if (_spaces is EqualUnmodifiableListView) return _spaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spaces);
  }

  final Map<String, List<ClickUpFolder>> _foldersBySpace;
  @override
  @JsonKey()
  Map<String, List<ClickUpFolder>> get foldersBySpace {
    if (_foldersBySpace is EqualUnmodifiableMapView) return _foldersBySpace;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_foldersBySpace);
  }

  final Map<String, List<ClickUpList>> _folderlessListsBySpace;
  @override
  @JsonKey()
  Map<String, List<ClickUpList>> get folderlessListsBySpace {
    if (_folderlessListsBySpace is EqualUnmodifiableMapView) return _folderlessListsBySpace;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_folderlessListsBySpace);
  }

  @override
  final String? selectedWorkspaceId;
  final List<String> _selectedListIds;
  @override
  @JsonKey()
  List<String> get selectedListIds {
    if (_selectedListIds is EqualUnmodifiableListView) return _selectedListIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedListIds);
  }

  final Map<String, String> _listProjectAssignments;
  @override
  @JsonKey()
  Map<String, String> get listProjectAssignments {
    if (_listProjectAssignments is EqualUnmodifiableMapView) return _listProjectAssignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_listProjectAssignments);
  }

  final Set<String> _expandedSpaces;
  @override
  @JsonKey()
  Set<String> get expandedSpaces {
    if (_expandedSpaces is EqualUnmodifiableSetView) return _expandedSpaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_expandedSpaces);
  }

  final Set<String> _expandedFolders;
  @override
  @JsonKey()
  Set<String> get expandedFolders {
    if (_expandedFolders is EqualUnmodifiableSetView) return _expandedFolders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_expandedFolders);
  }

  final List<Project> _projects;
  @override
  @JsonKey()
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;

  @override
  String toString() {
    return 'ClickupSettingsState(isLoading: $isLoading, isSaving: $isSaving, isSyncing: $isSyncing, settings: $settings, workspaces: $workspaces, spaces: $spaces, foldersBySpace: $foldersBySpace, folderlessListsBySpace: $folderlessListsBySpace, selectedWorkspaceId: $selectedWorkspaceId, selectedListIds: $selectedListIds, listProjectAssignments: $listProjectAssignments, expandedSpaces: $expandedSpaces, expandedFolders: $expandedFolders, projects: $projects, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickupSettingsStateImpl &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) || other.isSaving == isSaving) &&
            (identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing) &&
            (identical(other.settings, settings) || other.settings == settings) &&
            const DeepCollectionEquality().equals(other._workspaces, _workspaces) &&
            const DeepCollectionEquality().equals(other._spaces, _spaces) &&
            const DeepCollectionEquality().equals(other._foldersBySpace, _foldersBySpace) &&
            const DeepCollectionEquality().equals(other._folderlessListsBySpace, _folderlessListsBySpace) &&
            (identical(other.selectedWorkspaceId, selectedWorkspaceId) ||
                other.selectedWorkspaceId == selectedWorkspaceId) &&
            const DeepCollectionEquality().equals(other._selectedListIds, _selectedListIds) &&
            const DeepCollectionEquality().equals(other._listProjectAssignments, _listProjectAssignments) &&
            const DeepCollectionEquality().equals(other._expandedSpaces, _expandedSpaces) &&
            const DeepCollectionEquality().equals(other._expandedFolders, _expandedFolders) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.toastMessage, toastMessage) || other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) || other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isSaving,
    isSyncing,
    settings,
    const DeepCollectionEquality().hash(_workspaces),
    const DeepCollectionEquality().hash(_spaces),
    const DeepCollectionEquality().hash(_foldersBySpace),
    const DeepCollectionEquality().hash(_folderlessListsBySpace),
    selectedWorkspaceId,
    const DeepCollectionEquality().hash(_selectedListIds),
    const DeepCollectionEquality().hash(_listProjectAssignments),
    const DeepCollectionEquality().hash(_expandedSpaces),
    const DeepCollectionEquality().hash(_expandedFolders),
    const DeepCollectionEquality().hash(_projects),
    toastMessage,
    toastType,
  );

  /// Create a copy of ClickupSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickupSettingsStateImplCopyWith<_$ClickupSettingsStateImpl> get copyWith =>
      __$$ClickupSettingsStateImplCopyWithImpl<_$ClickupSettingsStateImpl>(this, _$identity);
}

abstract class _ClickupSettingsState implements ClickupSettingsState {
  const factory _ClickupSettingsState({
    final bool isLoading,
    final bool isSaving,
    final bool isSyncing,
    final ClickUpSettings? settings,
    final List<ClickUpWorkspace> workspaces,
    final List<ClickUpSpace> spaces,
    final Map<String, List<ClickUpFolder>> foldersBySpace,
    final Map<String, List<ClickUpList>> folderlessListsBySpace,
    final String? selectedWorkspaceId,
    final List<String> selectedListIds,
    final Map<String, String> listProjectAssignments,
    final Set<String> expandedSpaces,
    final Set<String> expandedFolders,
    final List<Project> projects,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$ClickupSettingsStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  bool get isSyncing;
  @override
  ClickUpSettings? get settings;
  @override
  List<ClickUpWorkspace> get workspaces;
  @override
  List<ClickUpSpace> get spaces;
  @override
  Map<String, List<ClickUpFolder>> get foldersBySpace;
  @override
  Map<String, List<ClickUpList>> get folderlessListsBySpace;
  @override
  String? get selectedWorkspaceId;
  @override
  List<String> get selectedListIds;
  @override
  Map<String, String> get listProjectAssignments;
  @override
  Set<String> get expandedSpaces;
  @override
  Set<String> get expandedFolders;
  @override
  List<Project> get projects;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of ClickupSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickupSettingsStateImplCopyWith<_$ClickupSettingsStateImpl> get copyWith => throw _privateConstructorUsedError;
}
