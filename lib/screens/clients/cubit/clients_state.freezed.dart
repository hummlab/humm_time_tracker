// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clients_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClientsState {
  List<Client> get clients => throw _privateConstructorUsedError;
  Map<String, int> get projectCountsByClientId =>
      throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of ClientsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientsStateCopyWith<ClientsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientsStateCopyWith<$Res> {
  factory $ClientsStateCopyWith(
    ClientsState value,
    $Res Function(ClientsState) then,
  ) = _$ClientsStateCopyWithImpl<$Res, ClientsState>;
  @useResult
  $Res call({
    List<Client> clients,
    Map<String, int> projectCountsByClientId,
    bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class _$ClientsStateCopyWithImpl<$Res, $Val extends ClientsState>
    implements $ClientsStateCopyWith<$Res> {
  _$ClientsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clients = null,
    Object? projectCountsByClientId = null,
    Object? isProcessing = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            clients:
                null == clients
                    ? _value.clients
                    : clients // ignore: cast_nullable_to_non_nullable
                        as List<Client>,
            projectCountsByClientId:
                null == projectCountsByClientId
                    ? _value.projectCountsByClientId
                    : projectCountsByClientId // ignore: cast_nullable_to_non_nullable
                        as Map<String, int>,
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
abstract class _$$ClientsStateImplCopyWith<$Res>
    implements $ClientsStateCopyWith<$Res> {
  factory _$$ClientsStateImplCopyWith(
    _$ClientsStateImpl value,
    $Res Function(_$ClientsStateImpl) then,
  ) = __$$ClientsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Client> clients,
    Map<String, int> projectCountsByClientId,
    bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class __$$ClientsStateImplCopyWithImpl<$Res>
    extends _$ClientsStateCopyWithImpl<$Res, _$ClientsStateImpl>
    implements _$$ClientsStateImplCopyWith<$Res> {
  __$$ClientsStateImplCopyWithImpl(
    _$ClientsStateImpl _value,
    $Res Function(_$ClientsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clients = null,
    Object? projectCountsByClientId = null,
    Object? isProcessing = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$ClientsStateImpl(
        clients:
            null == clients
                ? _value._clients
                : clients // ignore: cast_nullable_to_non_nullable
                    as List<Client>,
        projectCountsByClientId:
            null == projectCountsByClientId
                ? _value._projectCountsByClientId
                : projectCountsByClientId // ignore: cast_nullable_to_non_nullable
                    as Map<String, int>,
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

class _$ClientsStateImpl implements _ClientsState {
  const _$ClientsStateImpl({
    final List<Client> clients = const [],
    final Map<String, int> projectCountsByClientId = const {},
    this.isProcessing = false,
    this.toastMessage,
    this.toastType,
  }) : _clients = clients,
       _projectCountsByClientId = projectCountsByClientId;

  final List<Client> _clients;
  @override
  @JsonKey()
  List<Client> get clients {
    if (_clients is EqualUnmodifiableListView) return _clients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clients);
  }

  final Map<String, int> _projectCountsByClientId;
  @override
  @JsonKey()
  Map<String, int> get projectCountsByClientId {
    if (_projectCountsByClientId is EqualUnmodifiableMapView)
      return _projectCountsByClientId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_projectCountsByClientId);
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
    return 'ClientsState(clients: $clients, projectCountsByClientId: $projectCountsByClientId, isProcessing: $isProcessing, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientsStateImpl &&
            const DeepCollectionEquality().equals(other._clients, _clients) &&
            const DeepCollectionEquality().equals(
              other._projectCountsByClientId,
              _projectCountsByClientId,
            ) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.toastMessage, toastMessage) ||
                other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) ||
                other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_clients),
    const DeepCollectionEquality().hash(_projectCountsByClientId),
    isProcessing,
    toastMessage,
    toastType,
  );

  /// Create a copy of ClientsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientsStateImplCopyWith<_$ClientsStateImpl> get copyWith =>
      __$$ClientsStateImplCopyWithImpl<_$ClientsStateImpl>(this, _$identity);
}

abstract class _ClientsState implements ClientsState {
  const factory _ClientsState({
    final List<Client> clients,
    final Map<String, int> projectCountsByClientId,
    final bool isProcessing,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$ClientsStateImpl;

  @override
  List<Client> get clients;
  @override
  Map<String, int> get projectCountsByClientId;
  @override
  bool get isProcessing;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of ClientsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientsStateImplCopyWith<_$ClientsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
