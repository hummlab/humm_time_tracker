// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TeamMemberCardData {
  TeamMember get member => throw _privateConstructorUsedError;
  int get projectCount => throw _privateConstructorUsedError;
  List<String> get projectNames => throw _privateConstructorUsedError;

  /// Create a copy of TeamMemberCardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamMemberCardDataCopyWith<TeamMemberCardData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMemberCardDataCopyWith<$Res> {
  factory $TeamMemberCardDataCopyWith(TeamMemberCardData value, $Res Function(TeamMemberCardData) then) =
      _$TeamMemberCardDataCopyWithImpl<$Res, TeamMemberCardData>;
  @useResult
  $Res call({TeamMember member, int projectCount, List<String> projectNames});

  $TeamMemberCopyWith<$Res> get member;
}

/// @nodoc
class _$TeamMemberCardDataCopyWithImpl<$Res, $Val extends TeamMemberCardData>
    implements $TeamMemberCardDataCopyWith<$Res> {
  _$TeamMemberCardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamMemberCardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? member = null, Object? projectCount = null, Object? projectNames = null}) {
    return _then(
      _value.copyWith(
            member:
                null == member
                    ? _value.member
                    : member // ignore: cast_nullable_to_non_nullable
                        as TeamMember,
            projectCount:
                null == projectCount
                    ? _value.projectCount
                    : projectCount // ignore: cast_nullable_to_non_nullable
                        as int,
            projectNames:
                null == projectNames
                    ? _value.projectNames
                    : projectNames // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of TeamMemberCardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamMemberCopyWith<$Res> get member {
    return $TeamMemberCopyWith<$Res>(_value.member, (value) {
      return _then(_value.copyWith(member: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamMemberCardDataImplCopyWith<$Res> implements $TeamMemberCardDataCopyWith<$Res> {
  factory _$$TeamMemberCardDataImplCopyWith(
    _$TeamMemberCardDataImpl value,
    $Res Function(_$TeamMemberCardDataImpl) then,
  ) = __$$TeamMemberCardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TeamMember member, int projectCount, List<String> projectNames});

  @override
  $TeamMemberCopyWith<$Res> get member;
}

/// @nodoc
class __$$TeamMemberCardDataImplCopyWithImpl<$Res>
    extends _$TeamMemberCardDataCopyWithImpl<$Res, _$TeamMemberCardDataImpl>
    implements _$$TeamMemberCardDataImplCopyWith<$Res> {
  __$$TeamMemberCardDataImplCopyWithImpl(_$TeamMemberCardDataImpl _value, $Res Function(_$TeamMemberCardDataImpl) _then)
    : super(_value, _then);

  /// Create a copy of TeamMemberCardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? member = null, Object? projectCount = null, Object? projectNames = null}) {
    return _then(
      _$TeamMemberCardDataImpl(
        member:
            null == member
                ? _value.member
                : member // ignore: cast_nullable_to_non_nullable
                    as TeamMember,
        projectCount:
            null == projectCount
                ? _value.projectCount
                : projectCount // ignore: cast_nullable_to_non_nullable
                    as int,
        projectNames:
            null == projectNames
                ? _value._projectNames
                : projectNames // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$TeamMemberCardDataImpl implements _TeamMemberCardData {
  const _$TeamMemberCardDataImpl({
    required this.member,
    this.projectCount = 0,
    final List<String> projectNames = const <String>[],
  }) : _projectNames = projectNames;

  @override
  final TeamMember member;
  @override
  @JsonKey()
  final int projectCount;
  final List<String> _projectNames;
  @override
  @JsonKey()
  List<String> get projectNames {
    if (_projectNames is EqualUnmodifiableListView) return _projectNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectNames);
  }

  @override
  String toString() {
    return 'TeamMemberCardData(member: $member, projectCount: $projectCount, projectNames: $projectNames)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMemberCardDataImpl &&
            (identical(other.member, member) || other.member == member) &&
            (identical(other.projectCount, projectCount) || other.projectCount == projectCount) &&
            const DeepCollectionEquality().equals(other._projectNames, _projectNames));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, member, projectCount, const DeepCollectionEquality().hash(_projectNames));

  /// Create a copy of TeamMemberCardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMemberCardDataImplCopyWith<_$TeamMemberCardDataImpl> get copyWith =>
      __$$TeamMemberCardDataImplCopyWithImpl<_$TeamMemberCardDataImpl>(this, _$identity);
}

abstract class _TeamMemberCardData implements TeamMemberCardData {
  const factory _TeamMemberCardData({
    required final TeamMember member,
    final int projectCount,
    final List<String> projectNames,
  }) = _$TeamMemberCardDataImpl;

  @override
  TeamMember get member;
  @override
  int get projectCount;
  @override
  List<String> get projectNames;

  /// Create a copy of TeamMemberCardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamMemberCardDataImplCopyWith<_$TeamMemberCardDataImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TeamState {
  List<TeamMemberCardData> get cards => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  bool get isManager => throw _privateConstructorUsedError;
  bool get isSigningOut => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of TeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamStateCopyWith<TeamState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamStateCopyWith<$Res> {
  factory $TeamStateCopyWith(TeamState value, $Res Function(TeamState) then) = _$TeamStateCopyWithImpl<$Res, TeamState>;
  @useResult
  $Res call({
    List<TeamMemberCardData> cards,
    bool isAdmin,
    bool isManager,
    bool isSigningOut,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class _$TeamStateCopyWithImpl<$Res, $Val extends TeamState> implements $TeamStateCopyWith<$Res> {
  _$TeamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? isAdmin = null,
    Object? isManager = null,
    Object? isSigningOut = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            cards:
                null == cards
                    ? _value.cards
                    : cards // ignore: cast_nullable_to_non_nullable
                        as List<TeamMemberCardData>,
            isAdmin:
                null == isAdmin
                    ? _value.isAdmin
                    : isAdmin // ignore: cast_nullable_to_non_nullable
                        as bool,
            isManager:
                null == isManager
                    ? _value.isManager
                    : isManager // ignore: cast_nullable_to_non_nullable
                        as bool,
            isSigningOut:
                null == isSigningOut
                    ? _value.isSigningOut
                    : isSigningOut // ignore: cast_nullable_to_non_nullable
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
abstract class _$$TeamStateImplCopyWith<$Res> implements $TeamStateCopyWith<$Res> {
  factory _$$TeamStateImplCopyWith(_$TeamStateImpl value, $Res Function(_$TeamStateImpl) then) =
      __$$TeamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TeamMemberCardData> cards,
    bool isAdmin,
    bool isManager,
    bool isSigningOut,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class __$$TeamStateImplCopyWithImpl<$Res> extends _$TeamStateCopyWithImpl<$Res, _$TeamStateImpl>
    implements _$$TeamStateImplCopyWith<$Res> {
  __$$TeamStateImplCopyWithImpl(_$TeamStateImpl _value, $Res Function(_$TeamStateImpl) _then) : super(_value, _then);

  /// Create a copy of TeamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? isAdmin = null,
    Object? isManager = null,
    Object? isSigningOut = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$TeamStateImpl(
        cards:
            null == cards
                ? _value._cards
                : cards // ignore: cast_nullable_to_non_nullable
                    as List<TeamMemberCardData>,
        isAdmin:
            null == isAdmin
                ? _value.isAdmin
                : isAdmin // ignore: cast_nullable_to_non_nullable
                    as bool,
        isManager:
            null == isManager
                ? _value.isManager
                : isManager // ignore: cast_nullable_to_non_nullable
                    as bool,
        isSigningOut:
            null == isSigningOut
                ? _value.isSigningOut
                : isSigningOut // ignore: cast_nullable_to_non_nullable
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

class _$TeamStateImpl implements _TeamState {
  const _$TeamStateImpl({
    final List<TeamMemberCardData> cards = const [],
    this.isAdmin = false,
    this.isManager = false,
    this.isSigningOut = false,
    this.toastMessage,
    this.toastType,
  }) : _cards = cards;

  final List<TeamMemberCardData> _cards;
  @override
  @JsonKey()
  List<TeamMemberCardData> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  @JsonKey()
  final bool isAdmin;
  @override
  @JsonKey()
  final bool isManager;
  @override
  @JsonKey()
  final bool isSigningOut;
  @override
  final String? toastMessage;
  @override
  final AppToastType? toastType;

  @override
  String toString() {
    return 'TeamState(cards: $cards, isAdmin: $isAdmin, isManager: $isManager, isSigningOut: $isSigningOut, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamStateImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isManager, isManager) || other.isManager == isManager) &&
            (identical(other.isSigningOut, isSigningOut) || other.isSigningOut == isSigningOut) &&
            (identical(other.toastMessage, toastMessage) || other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) || other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_cards),
    isAdmin,
    isManager,
    isSigningOut,
    toastMessage,
    toastType,
  );

  /// Create a copy of TeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamStateImplCopyWith<_$TeamStateImpl> get copyWith =>
      __$$TeamStateImplCopyWithImpl<_$TeamStateImpl>(this, _$identity);
}

abstract class _TeamState implements TeamState {
  const factory _TeamState({
    final List<TeamMemberCardData> cards,
    final bool isAdmin,
    final bool isManager,
    final bool isSigningOut,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$TeamStateImpl;

  @override
  List<TeamMemberCardData> get cards;
  @override
  bool get isAdmin;
  @override
  bool get isManager;
  @override
  bool get isSigningOut;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of TeamState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamStateImplCopyWith<_$TeamStateImpl> get copyWith => throw _privateConstructorUsedError;
}
