// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jira_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$JiraSettingsState {
  JiraSettings? get settings => throw _privateConstructorUsedError;
  List<JiraProject> get projects => throw _privateConstructorUsedError;
  List<String> get selectedProjectIds => throw _privateConstructorUsedError;
  bool get projectsLoaded => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  bool get isTesting => throw _privateConstructorUsedError;
  bool get isSyncing => throw _privateConstructorUsedError;
  bool get shouldClearApiToken => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of JiraSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JiraSettingsStateCopyWith<JiraSettingsState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JiraSettingsStateCopyWith<$Res> {
  factory $JiraSettingsStateCopyWith(JiraSettingsState value, $Res Function(JiraSettingsState) then) =
      _$JiraSettingsStateCopyWithImpl<$Res, JiraSettingsState>;
  @useResult
  $Res call({
    JiraSettings? settings,
    List<JiraProject> projects,
    List<String> selectedProjectIds,
    bool projectsLoaded,
    bool isLoading,
    bool isSaving,
    bool isTesting,
    bool isSyncing,
    bool shouldClearApiToken,
    String? toastMessage,
    AppToastType? toastType,
  });

  $JiraSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$JiraSettingsStateCopyWithImpl<$Res, $Val extends JiraSettingsState>
    implements $JiraSettingsStateCopyWith<$Res> {
  _$JiraSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JiraSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = freezed,
    Object? projects = null,
    Object? selectedProjectIds = null,
    Object? projectsLoaded = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isTesting = null,
    Object? isSyncing = null,
    Object? shouldClearApiToken = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            settings:
                freezed == settings
                    ? _value.settings
                    : settings // ignore: cast_nullable_to_non_nullable
                        as JiraSettings?,
            projects:
                null == projects
                    ? _value.projects
                    : projects // ignore: cast_nullable_to_non_nullable
                        as List<JiraProject>,
            selectedProjectIds:
                null == selectedProjectIds
                    ? _value.selectedProjectIds
                    : selectedProjectIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            projectsLoaded:
                null == projectsLoaded
                    ? _value.projectsLoaded
                    : projectsLoaded // ignore: cast_nullable_to_non_nullable
                        as bool,
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
            isTesting:
                null == isTesting
                    ? _value.isTesting
                    : isTesting // ignore: cast_nullable_to_non_nullable
                        as bool,
            isSyncing:
                null == isSyncing
                    ? _value.isSyncing
                    : isSyncing // ignore: cast_nullable_to_non_nullable
                        as bool,
            shouldClearApiToken:
                null == shouldClearApiToken
                    ? _value.shouldClearApiToken
                    : shouldClearApiToken // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of JiraSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JiraSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $JiraSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JiraSettingsStateImplCopyWith<$Res> implements $JiraSettingsStateCopyWith<$Res> {
  factory _$$JiraSettingsStateImplCopyWith(_$JiraSettingsStateImpl value, $Res Function(_$JiraSettingsStateImpl) then) =
      __$$JiraSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    JiraSettings? settings,
    List<JiraProject> projects,
    List<String> selectedProjectIds,
    bool projectsLoaded,
    bool isLoading,
    bool isSaving,
    bool isTesting,
    bool isSyncing,
    bool shouldClearApiToken,
    String? toastMessage,
    AppToastType? toastType,
  });

  @override
  $JiraSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$JiraSettingsStateImplCopyWithImpl<$Res> extends _$JiraSettingsStateCopyWithImpl<$Res, _$JiraSettingsStateImpl>
    implements _$$JiraSettingsStateImplCopyWith<$Res> {
  __$$JiraSettingsStateImplCopyWithImpl(_$JiraSettingsStateImpl _value, $Res Function(_$JiraSettingsStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of JiraSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = freezed,
    Object? projects = null,
    Object? selectedProjectIds = null,
    Object? projectsLoaded = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isTesting = null,
    Object? isSyncing = null,
    Object? shouldClearApiToken = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$JiraSettingsStateImpl(
        settings:
            freezed == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                    as JiraSettings?,
        projects:
            null == projects
                ? _value._projects
                : projects // ignore: cast_nullable_to_non_nullable
                    as List<JiraProject>,
        selectedProjectIds:
            null == selectedProjectIds
                ? _value._selectedProjectIds
                : selectedProjectIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        projectsLoaded:
            null == projectsLoaded
                ? _value.projectsLoaded
                : projectsLoaded // ignore: cast_nullable_to_non_nullable
                    as bool,
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
        isTesting:
            null == isTesting
                ? _value.isTesting
                : isTesting // ignore: cast_nullable_to_non_nullable
                    as bool,
        isSyncing:
            null == isSyncing
                ? _value.isSyncing
                : isSyncing // ignore: cast_nullable_to_non_nullable
                    as bool,
        shouldClearApiToken:
            null == shouldClearApiToken
                ? _value.shouldClearApiToken
                : shouldClearApiToken // ignore: cast_nullable_to_non_nullable
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

class _$JiraSettingsStateImpl implements _JiraSettingsState {
  const _$JiraSettingsStateImpl({
    this.settings,
    final List<JiraProject> projects = const [],
    final List<String> selectedProjectIds = const [],
    this.projectsLoaded = false,
    this.isLoading = false,
    this.isSaving = false,
    this.isTesting = false,
    this.isSyncing = false,
    this.shouldClearApiToken = false,
    this.toastMessage,
    this.toastType,
  }) : _projects = projects,
       _selectedProjectIds = selectedProjectIds;

  @override
  final JiraSettings? settings;
  final List<JiraProject> _projects;
  @override
  @JsonKey()
  List<JiraProject> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  final List<String> _selectedProjectIds;
  @override
  @JsonKey()
  List<String> get selectedProjectIds {
    if (_selectedProjectIds is EqualUnmodifiableListView) return _selectedProjectIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedProjectIds);
  }

  @override
  @JsonKey()
  final bool projectsLoaded;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isTesting;
  @override
  @JsonKey()
  final bool isSyncing;
  @override
  @JsonKey()
  final bool shouldClearApiToken;
  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;

  @override
  String toString() {
    return 'JiraSettingsState(settings: $settings, projects: $projects, selectedProjectIds: $selectedProjectIds, projectsLoaded: $projectsLoaded, isLoading: $isLoading, isSaving: $isSaving, isTesting: $isTesting, isSyncing: $isSyncing, shouldClearApiToken: $shouldClearApiToken, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JiraSettingsStateImpl &&
            (identical(other.settings, settings) || other.settings == settings) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            const DeepCollectionEquality().equals(other._selectedProjectIds, _selectedProjectIds) &&
            (identical(other.projectsLoaded, projectsLoaded) || other.projectsLoaded == projectsLoaded) &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) || other.isSaving == isSaving) &&
            (identical(other.isTesting, isTesting) || other.isTesting == isTesting) &&
            (identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing) &&
            (identical(other.shouldClearApiToken, shouldClearApiToken) ||
                other.shouldClearApiToken == shouldClearApiToken) &&
            (identical(other.toastMessage, toastMessage) || other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) || other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    settings,
    const DeepCollectionEquality().hash(_projects),
    const DeepCollectionEquality().hash(_selectedProjectIds),
    projectsLoaded,
    isLoading,
    isSaving,
    isTesting,
    isSyncing,
    shouldClearApiToken,
    toastMessage,
    toastType,
  );

  /// Create a copy of JiraSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JiraSettingsStateImplCopyWith<_$JiraSettingsStateImpl> get copyWith =>
      __$$JiraSettingsStateImplCopyWithImpl<_$JiraSettingsStateImpl>(this, _$identity);
}

abstract class _JiraSettingsState implements JiraSettingsState {
  const factory _JiraSettingsState({
    final JiraSettings? settings,
    final List<JiraProject> projects,
    final List<String> selectedProjectIds,
    final bool projectsLoaded,
    final bool isLoading,
    final bool isSaving,
    final bool isTesting,
    final bool isSyncing,
    final bool shouldClearApiToken,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$JiraSettingsStateImpl;

  @override
  JiraSettings? get settings;
  @override
  List<JiraProject> get projects;
  @override
  List<String> get selectedProjectIds;
  @override
  bool get projectsLoaded;
  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  bool get isTesting;
  @override
  bool get isSyncing;
  @override
  bool get shouldClearApiToken;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of JiraSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JiraSettingsStateImplCopyWith<_$JiraSettingsStateImpl> get copyWith => throw _privateConstructorUsedError;
}
