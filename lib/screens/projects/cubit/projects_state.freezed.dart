// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProjectCardData {
  Project get project => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  List<TeamMember> get teamMembers => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;
  int get thisMonthMinutes => throw _privateConstructorUsedError;

  /// Create a copy of ProjectCardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectCardDataCopyWith<ProjectCardData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCardDataCopyWith<$Res> {
  factory $ProjectCardDataCopyWith(ProjectCardData value, $Res Function(ProjectCardData) then) =
      _$ProjectCardDataCopyWithImpl<$Res, ProjectCardData>;
  @useResult
  $Res call({
    Project project,
    String? clientName,
    List<TeamMember> teamMembers,
    int totalMinutes,
    int thisMonthMinutes,
  });

  $ProjectCopyWith<$Res> get project;
}

/// @nodoc
class _$ProjectCardDataCopyWithImpl<$Res, $Val extends ProjectCardData> implements $ProjectCardDataCopyWith<$Res> {
  _$ProjectCardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectCardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = null,
    Object? clientName = freezed,
    Object? teamMembers = null,
    Object? totalMinutes = null,
    Object? thisMonthMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            project:
                null == project
                    ? _value.project
                    : project // ignore: cast_nullable_to_non_nullable
                        as Project,
            clientName:
                freezed == clientName
                    ? _value.clientName
                    : clientName // ignore: cast_nullable_to_non_nullable
                        as String?,
            teamMembers:
                null == teamMembers
                    ? _value.teamMembers
                    : teamMembers // ignore: cast_nullable_to_non_nullable
                        as List<TeamMember>,
            totalMinutes:
                null == totalMinutes
                    ? _value.totalMinutes
                    : totalMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
            thisMonthMinutes:
                null == thisMonthMinutes
                    ? _value.thisMonthMinutes
                    : thisMonthMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }

  /// Create a copy of ProjectCardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProjectCopyWith<$Res> get project {
    return $ProjectCopyWith<$Res>(_value.project, (value) {
      return _then(_value.copyWith(project: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProjectCardDataImplCopyWith<$Res> implements $ProjectCardDataCopyWith<$Res> {
  factory _$$ProjectCardDataImplCopyWith(_$ProjectCardDataImpl value, $Res Function(_$ProjectCardDataImpl) then) =
      __$$ProjectCardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Project project,
    String? clientName,
    List<TeamMember> teamMembers,
    int totalMinutes,
    int thisMonthMinutes,
  });

  @override
  $ProjectCopyWith<$Res> get project;
}

/// @nodoc
class __$$ProjectCardDataImplCopyWithImpl<$Res> extends _$ProjectCardDataCopyWithImpl<$Res, _$ProjectCardDataImpl>
    implements _$$ProjectCardDataImplCopyWith<$Res> {
  __$$ProjectCardDataImplCopyWithImpl(_$ProjectCardDataImpl _value, $Res Function(_$ProjectCardDataImpl) _then)
    : super(_value, _then);

  /// Create a copy of ProjectCardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = null,
    Object? clientName = freezed,
    Object? teamMembers = null,
    Object? totalMinutes = null,
    Object? thisMonthMinutes = null,
  }) {
    return _then(
      _$ProjectCardDataImpl(
        project:
            null == project
                ? _value.project
                : project // ignore: cast_nullable_to_non_nullable
                    as Project,
        clientName:
            freezed == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                    as String?,
        teamMembers:
            null == teamMembers
                ? _value._teamMembers
                : teamMembers // ignore: cast_nullable_to_non_nullable
                    as List<TeamMember>,
        totalMinutes:
            null == totalMinutes
                ? _value.totalMinutes
                : totalMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
        thisMonthMinutes:
            null == thisMonthMinutes
                ? _value.thisMonthMinutes
                : thisMonthMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$ProjectCardDataImpl implements _ProjectCardData {
  const _$ProjectCardDataImpl({
    required this.project,
    this.clientName,
    final List<TeamMember> teamMembers = const <TeamMember>[],
    this.totalMinutes = 0,
    this.thisMonthMinutes = 0,
  }) : _teamMembers = teamMembers;

  @override
  final Project project;
  @override
  final String? clientName;
  final List<TeamMember> _teamMembers;
  @override
  @JsonKey()
  List<TeamMember> get teamMembers {
    if (_teamMembers is EqualUnmodifiableListView) return _teamMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamMembers);
  }

  @override
  @JsonKey()
  final int totalMinutes;
  @override
  @JsonKey()
  final int thisMonthMinutes;

  @override
  String toString() {
    return 'ProjectCardData(project: $project, clientName: $clientName, teamMembers: $teamMembers, totalMinutes: $totalMinutes, thisMonthMinutes: $thisMonthMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectCardDataImpl &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.clientName, clientName) || other.clientName == clientName) &&
            const DeepCollectionEquality().equals(other._teamMembers, _teamMembers) &&
            (identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes) &&
            (identical(other.thisMonthMinutes, thisMonthMinutes) || other.thisMonthMinutes == thisMonthMinutes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    project,
    clientName,
    const DeepCollectionEquality().hash(_teamMembers),
    totalMinutes,
    thisMonthMinutes,
  );

  /// Create a copy of ProjectCardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectCardDataImplCopyWith<_$ProjectCardDataImpl> get copyWith =>
      __$$ProjectCardDataImplCopyWithImpl<_$ProjectCardDataImpl>(this, _$identity);
}

abstract class _ProjectCardData implements ProjectCardData {
  const factory _ProjectCardData({
    required final Project project,
    final String? clientName,
    final List<TeamMember> teamMembers,
    final int totalMinutes,
    final int thisMonthMinutes,
  }) = _$ProjectCardDataImpl;

  @override
  Project get project;
  @override
  String? get clientName;
  @override
  List<TeamMember> get teamMembers;
  @override
  int get totalMinutes;
  @override
  int get thisMonthMinutes;

  /// Create a copy of ProjectCardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectCardDataImplCopyWith<_$ProjectCardDataImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProjectsState {
  List<ProjectCardData> get cards => throw _privateConstructorUsedError;
  List<Client> get clients => throw _privateConstructorUsedError;
  List<TeamMember> get teamMembers => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectsStateCopyWith<ProjectsState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectsStateCopyWith<$Res> {
  factory $ProjectsStateCopyWith(ProjectsState value, $Res Function(ProjectsState) then) =
      _$ProjectsStateCopyWithImpl<$Res, ProjectsState>;
  @useResult
  $Res call({
    List<ProjectCardData> cards,
    List<Client> clients,
    List<TeamMember> teamMembers,
    bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class _$ProjectsStateCopyWithImpl<$Res, $Val extends ProjectsState> implements $ProjectsStateCopyWith<$Res> {
  _$ProjectsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? clients = null,
    Object? teamMembers = null,
    Object? isProcessing = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            cards:
                null == cards
                    ? _value.cards
                    : cards // ignore: cast_nullable_to_non_nullable
                        as List<ProjectCardData>,
            clients:
                null == clients
                    ? _value.clients
                    : clients // ignore: cast_nullable_to_non_nullable
                        as List<Client>,
            teamMembers:
                null == teamMembers
                    ? _value.teamMembers
                    : teamMembers // ignore: cast_nullable_to_non_nullable
                        as List<TeamMember>,
            isProcessing:
                null == isProcessing
                    ? _value.isProcessing
                    : isProcessing // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ProjectsStateImplCopyWith<$Res> implements $ProjectsStateCopyWith<$Res> {
  factory _$$ProjectsStateImplCopyWith(_$ProjectsStateImpl value, $Res Function(_$ProjectsStateImpl) then) =
      __$$ProjectsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ProjectCardData> cards,
    List<Client> clients,
    List<TeamMember> teamMembers,
    bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class __$$ProjectsStateImplCopyWithImpl<$Res> extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsStateImpl>
    implements _$$ProjectsStateImplCopyWith<$Res> {
  __$$ProjectsStateImplCopyWithImpl(_$ProjectsStateImpl _value, $Res Function(_$ProjectsStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? clients = null,
    Object? teamMembers = null,
    Object? isProcessing = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$ProjectsStateImpl(
        cards:
            null == cards
                ? _value._cards
                : cards // ignore: cast_nullable_to_non_nullable
                    as List<ProjectCardData>,
        clients:
            null == clients
                ? _value._clients
                : clients // ignore: cast_nullable_to_non_nullable
                    as List<Client>,
        teamMembers:
            null == teamMembers
                ? _value._teamMembers
                : teamMembers // ignore: cast_nullable_to_non_nullable
                    as List<TeamMember>,
        isProcessing:
            null == isProcessing
                ? _value.isProcessing
                : isProcessing // ignore: cast_nullable_to_non_nullable
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

class _$ProjectsStateImpl implements _ProjectsState {
  const _$ProjectsStateImpl({
    final List<ProjectCardData> cards = const [],
    final List<Client> clients = const [],
    final List<TeamMember> teamMembers = const [],
    this.isProcessing = false,
    this.toastMessage,
    this.toastType,
  }) : _cards = cards,
       _clients = clients,
       _teamMembers = teamMembers;

  final List<ProjectCardData> _cards;
  @override
  @JsonKey()
  List<ProjectCardData> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  final List<Client> _clients;
  @override
  @JsonKey()
  List<Client> get clients {
    if (_clients is EqualUnmodifiableListView) return _clients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clients);
  }

  final List<TeamMember> _teamMembers;
  @override
  @JsonKey()
  List<TeamMember> get teamMembers {
    if (_teamMembers is EqualUnmodifiableListView) return _teamMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamMembers);
  }

  @override
  @JsonKey()
  final bool isProcessing;
  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;

  @override
  String toString() {
    return 'ProjectsState(cards: $cards, clients: $clients, teamMembers: $teamMembers, isProcessing: $isProcessing, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsStateImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            const DeepCollectionEquality().equals(other._clients, _clients) &&
            const DeepCollectionEquality().equals(other._teamMembers, _teamMembers) &&
            (identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing) &&
            (identical(other.toastMessage, toastMessage) || other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) || other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_cards),
    const DeepCollectionEquality().hash(_clients),
    const DeepCollectionEquality().hash(_teamMembers),
    isProcessing,
    toastMessage,
    toastType,
  );

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsStateImplCopyWith<_$ProjectsStateImpl> get copyWith =>
      __$$ProjectsStateImplCopyWithImpl<_$ProjectsStateImpl>(this, _$identity);
}

abstract class _ProjectsState implements ProjectsState {
  const factory _ProjectsState({
    final List<ProjectCardData> cards,
    final List<Client> clients,
    final List<TeamMember> teamMembers,
    final bool isProcessing,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$ProjectsStateImpl;

  @override
  List<ProjectCardData> get cards;
  @override
  List<Client> get clients;
  @override
  List<TeamMember> get teamMembers;
  @override
  bool get isProcessing;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of ProjectsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectsStateImplCopyWith<_$ProjectsStateImpl> get copyWith => throw _privateConstructorUsedError;
}
