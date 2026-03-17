// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tags_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TagsState {
  List<Tag> get tags => throw _privateConstructorUsedError;
  Map<String, int> get entryCountsByTagId => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  String? get toastMessage => throw _privateConstructorUsedError;
  AppToastType? get toastType => throw _privateConstructorUsedError;

  /// Create a copy of TagsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagsStateCopyWith<TagsState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagsStateCopyWith<$Res> {
  factory $TagsStateCopyWith(TagsState value, $Res Function(TagsState) then) = _$TagsStateCopyWithImpl<$Res, TagsState>;
  @useResult
  $Res call({
    List<Tag> tags,
    Map<String, int> entryCountsByTagId,
    bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class _$TagsStateCopyWithImpl<$Res, $Val extends TagsState> implements $TagsStateCopyWith<$Res> {
  _$TagsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
    Object? entryCountsByTagId = null,
    Object? isProcessing = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _value.copyWith(
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<Tag>,
            entryCountsByTagId:
                null == entryCountsByTagId
                    ? _value.entryCountsByTagId
                    : entryCountsByTagId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$TagsStateImplCopyWith<$Res> implements $TagsStateCopyWith<$Res> {
  factory _$$TagsStateImplCopyWith(_$TagsStateImpl value, $Res Function(_$TagsStateImpl) then) =
      __$$TagsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Tag> tags,
    Map<String, int> entryCountsByTagId,
    bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  });
}

/// @nodoc
class __$$TagsStateImplCopyWithImpl<$Res> extends _$TagsStateCopyWithImpl<$Res, _$TagsStateImpl>
    implements _$$TagsStateImplCopyWith<$Res> {
  __$$TagsStateImplCopyWithImpl(_$TagsStateImpl _value, $Res Function(_$TagsStateImpl) _then) : super(_value, _then);

  /// Create a copy of TagsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
    Object? entryCountsByTagId = null,
    Object? isProcessing = null,
    Object? toastMessage = freezed,
    Object? toastType = freezed,
  }) {
    return _then(
      _$TagsStateImpl(
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<Tag>,
        entryCountsByTagId:
            null == entryCountsByTagId
                ? _value._entryCountsByTagId
                : entryCountsByTagId // ignore: cast_nullable_to_non_nullable
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

class _$TagsStateImpl implements _TagsState {
  const _$TagsStateImpl({
    final List<Tag> tags = const [],
    final Map<String, int> entryCountsByTagId = const {},
    this.isProcessing = false,
    this.toastMessage,
    this.toastType,
  }) : _tags = tags,
       _entryCountsByTagId = entryCountsByTagId;

  final List<Tag> _tags;
  @override
  @JsonKey()
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final Map<String, int> _entryCountsByTagId;
  @override
  @JsonKey()
  Map<String, int> get entryCountsByTagId {
    if (_entryCountsByTagId is EqualUnmodifiableMapView) return _entryCountsByTagId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_entryCountsByTagId);
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
    return 'TagsState(tags: $tags, entryCountsByTagId: $entryCountsByTagId, isProcessing: $isProcessing, toastMessage: $toastMessage, toastType: $toastType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagsStateImpl &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._entryCountsByTagId, _entryCountsByTagId) &&
            (identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing) &&
            (identical(other.toastMessage, toastMessage) || other.toastMessage == toastMessage) &&
            (identical(other.toastType, toastType) || other.toastType == toastType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_entryCountsByTagId),
    isProcessing,
    toastMessage,
    toastType,
  );

  /// Create a copy of TagsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagsStateImplCopyWith<_$TagsStateImpl> get copyWith =>
      __$$TagsStateImplCopyWithImpl<_$TagsStateImpl>(this, _$identity);
}

abstract class _TagsState implements TagsState {
  const factory _TagsState({
    final List<Tag> tags,
    final Map<String, int> entryCountsByTagId,
    final bool isProcessing,
    final String? toastMessage,
    final AppToastType? toastType,
  }) = _$TagsStateImpl;

  @override
  List<Tag> get tags;
  @override
  Map<String, int> get entryCountsByTagId;
  @override
  bool get isProcessing;
  @override
  String? get toastMessage;
  @override
  AppToastType? get toastType;

  /// Create a copy of TagsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagsStateImplCopyWith<_$TagsStateImpl> get copyWith => throw _privateConstructorUsedError;
}
