// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimeEntry _$TimeEntryFromJson(Map<String, dynamic> json) {
  return _TimeEntry.fromJson(json);
}

/// @nodoc
mixin _$TimeEntry {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get date => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;
  List<String> get tagIds => throw _privateConstructorUsedError;
  String get createdByUserId => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get clickUpTaskId => throw _privateConstructorUsedError;
  String? get jiraIssueKey => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timeEntryStatusFromJson, toJson: _timeEntryStatusToJson)
  TimeEntryStatus get status => throw _privateConstructorUsedError;
  String? get approvedByUserId => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get startTime => throw _privateConstructorUsedError;

  /// Serializes this TimeEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeEntryCopyWith<TimeEntry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeEntryCopyWith<$Res> {
  factory $TimeEntryCopyWith(TimeEntry value, $Res Function(TimeEntry) then) = _$TimeEntryCopyWithImpl<$Res, TimeEntry>;
  @useResult
  $Res call({
    String id,
    String description,
    int durationMinutes,
    @FirestoreDateTimeConverter() DateTime date,
    String? projectId,
    List<String> tagIds,
    String createdByUserId,
    @FirestoreDateTimeConverter() DateTime createdAt,
    String? clickUpTaskId,
    String? jiraIssueKey,
    @JsonKey(fromJson: _timeEntryStatusFromJson, toJson: _timeEntryStatusToJson) TimeEntryStatus status,
    String? approvedByUserId,
    @FirestoreNullableDateTimeConverter() DateTime? approvedAt,
    String? rejectionReason,
    @FirestoreNullableDateTimeConverter() DateTime? startTime,
  });
}

/// @nodoc
class _$TimeEntryCopyWithImpl<$Res, $Val extends TimeEntry> implements $TimeEntryCopyWith<$Res> {
  _$TimeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? durationMinutes = null,
    Object? date = null,
    Object? projectId = freezed,
    Object? tagIds = null,
    Object? createdByUserId = null,
    Object? createdAt = null,
    Object? clickUpTaskId = freezed,
    Object? jiraIssueKey = freezed,
    Object? status = null,
    Object? approvedByUserId = freezed,
    Object? approvedAt = freezed,
    Object? rejectionReason = freezed,
    Object? startTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            durationMinutes:
                null == durationMinutes
                    ? _value.durationMinutes
                    : durationMinutes // ignore: cast_nullable_to_non_nullable
                        as int,
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            projectId:
                freezed == projectId
                    ? _value.projectId
                    : projectId // ignore: cast_nullable_to_non_nullable
                        as String?,
            tagIds:
                null == tagIds
                    ? _value.tagIds
                    : tagIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            createdByUserId:
                null == createdByUserId
                    ? _value.createdByUserId
                    : createdByUserId // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            clickUpTaskId:
                freezed == clickUpTaskId
                    ? _value.clickUpTaskId
                    : clickUpTaskId // ignore: cast_nullable_to_non_nullable
                        as String?,
            jiraIssueKey:
                freezed == jiraIssueKey
                    ? _value.jiraIssueKey
                    : jiraIssueKey // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as TimeEntryStatus,
            approvedByUserId:
                freezed == approvedByUserId
                    ? _value.approvedByUserId
                    : approvedByUserId // ignore: cast_nullable_to_non_nullable
                        as String?,
            approvedAt:
                freezed == approvedAt
                    ? _value.approvedAt
                    : approvedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            rejectionReason:
                freezed == rejectionReason
                    ? _value.rejectionReason
                    : rejectionReason // ignore: cast_nullable_to_non_nullable
                        as String?,
            startTime:
                freezed == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimeEntryImplCopyWith<$Res> implements $TimeEntryCopyWith<$Res> {
  factory _$$TimeEntryImplCopyWith(_$TimeEntryImpl value, $Res Function(_$TimeEntryImpl) then) =
      __$$TimeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String description,
    int durationMinutes,
    @FirestoreDateTimeConverter() DateTime date,
    String? projectId,
    List<String> tagIds,
    String createdByUserId,
    @FirestoreDateTimeConverter() DateTime createdAt,
    String? clickUpTaskId,
    String? jiraIssueKey,
    @JsonKey(fromJson: _timeEntryStatusFromJson, toJson: _timeEntryStatusToJson) TimeEntryStatus status,
    String? approvedByUserId,
    @FirestoreNullableDateTimeConverter() DateTime? approvedAt,
    String? rejectionReason,
    @FirestoreNullableDateTimeConverter() DateTime? startTime,
  });
}

/// @nodoc
class __$$TimeEntryImplCopyWithImpl<$Res> extends _$TimeEntryCopyWithImpl<$Res, _$TimeEntryImpl>
    implements _$$TimeEntryImplCopyWith<$Res> {
  __$$TimeEntryImplCopyWithImpl(_$TimeEntryImpl _value, $Res Function(_$TimeEntryImpl) _then) : super(_value, _then);

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? durationMinutes = null,
    Object? date = null,
    Object? projectId = freezed,
    Object? tagIds = null,
    Object? createdByUserId = null,
    Object? createdAt = null,
    Object? clickUpTaskId = freezed,
    Object? jiraIssueKey = freezed,
    Object? status = null,
    Object? approvedByUserId = freezed,
    Object? approvedAt = freezed,
    Object? rejectionReason = freezed,
    Object? startTime = freezed,
  }) {
    return _then(
      _$TimeEntryImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        durationMinutes:
            null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                    as int,
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        projectId:
            freezed == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                    as String?,
        tagIds:
            null == tagIds
                ? _value._tagIds
                : tagIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        createdByUserId:
            null == createdByUserId
                ? _value.createdByUserId
                : createdByUserId // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        clickUpTaskId:
            freezed == clickUpTaskId
                ? _value.clickUpTaskId
                : clickUpTaskId // ignore: cast_nullable_to_non_nullable
                    as String?,
        jiraIssueKey:
            freezed == jiraIssueKey
                ? _value.jiraIssueKey
                : jiraIssueKey // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as TimeEntryStatus,
        approvedByUserId:
            freezed == approvedByUserId
                ? _value.approvedByUserId
                : approvedByUserId // ignore: cast_nullable_to_non_nullable
                    as String?,
        approvedAt:
            freezed == approvedAt
                ? _value.approvedAt
                : approvedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        rejectionReason:
            freezed == rejectionReason
                ? _value.rejectionReason
                : rejectionReason // ignore: cast_nullable_to_non_nullable
                    as String?,
        startTime:
            freezed == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeEntryImpl extends _TimeEntry {
  const _$TimeEntryImpl({
    required this.id,
    required this.description,
    required this.durationMinutes,
    @FirestoreDateTimeConverter() required this.date,
    this.projectId,
    final List<String> tagIds = const [],
    required this.createdByUserId,
    @FirestoreDateTimeConverter() required this.createdAt,
    this.clickUpTaskId,
    this.jiraIssueKey,
    @JsonKey(fromJson: _timeEntryStatusFromJson, toJson: _timeEntryStatusToJson) this.status = TimeEntryStatus.draft,
    this.approvedByUserId,
    @FirestoreNullableDateTimeConverter() this.approvedAt,
    this.rejectionReason,
    @FirestoreNullableDateTimeConverter() this.startTime,
  }) : _tagIds = tagIds,
       super._();

  factory _$TimeEntryImpl.fromJson(Map<String, dynamic> json) => _$$TimeEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String description;
  @override
  final int durationMinutes;
  @override
  @FirestoreDateTimeConverter()
  final DateTime date;
  @override
  final String? projectId;
  final List<String> _tagIds;
  @override
  @JsonKey()
  List<String> get tagIds {
    if (_tagIds is EqualUnmodifiableListView) return _tagIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagIds);
  }

  @override
  final String createdByUserId;
  @override
  @FirestoreDateTimeConverter()
  final DateTime createdAt;
  @override
  final String? clickUpTaskId;
  @override
  final String? jiraIssueKey;
  @override
  @JsonKey(fromJson: _timeEntryStatusFromJson, toJson: _timeEntryStatusToJson)
  final TimeEntryStatus status;
  @override
  final String? approvedByUserId;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? approvedAt;
  @override
  final String? rejectionReason;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? startTime;

  @override
  String toString() {
    return 'TimeEntry(id: $id, description: $description, durationMinutes: $durationMinutes, date: $date, projectId: $projectId, tagIds: $tagIds, createdByUserId: $createdByUserId, createdAt: $createdAt, clickUpTaskId: $clickUpTaskId, jiraIssueKey: $jiraIssueKey, status: $status, approvedByUserId: $approvedByUserId, approvedAt: $approvedAt, rejectionReason: $rejectionReason, startTime: $startTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.projectId, projectId) || other.projectId == projectId) &&
            const DeepCollectionEquality().equals(other._tagIds, _tagIds) &&
            (identical(other.createdByUserId, createdByUserId) || other.createdByUserId == createdByUserId) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.clickUpTaskId, clickUpTaskId) || other.clickUpTaskId == clickUpTaskId) &&
            (identical(other.jiraIssueKey, jiraIssueKey) || other.jiraIssueKey == jiraIssueKey) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvedByUserId, approvedByUserId) || other.approvedByUserId == approvedByUserId) &&
            (identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt) &&
            (identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason) &&
            (identical(other.startTime, startTime) || other.startTime == startTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    description,
    durationMinutes,
    date,
    projectId,
    const DeepCollectionEquality().hash(_tagIds),
    createdByUserId,
    createdAt,
    clickUpTaskId,
    jiraIssueKey,
    status,
    approvedByUserId,
    approvedAt,
    rejectionReason,
    startTime,
  );

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeEntryImplCopyWith<_$TimeEntryImpl> get copyWith =>
      __$$TimeEntryImplCopyWithImpl<_$TimeEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeEntryImplToJson(this);
  }
}

abstract class _TimeEntry extends TimeEntry {
  const factory _TimeEntry({
    required final String id,
    required final String description,
    required final int durationMinutes,
    @FirestoreDateTimeConverter() required final DateTime date,
    final String? projectId,
    final List<String> tagIds,
    required final String createdByUserId,
    @FirestoreDateTimeConverter() required final DateTime createdAt,
    final String? clickUpTaskId,
    final String? jiraIssueKey,
    @JsonKey(fromJson: _timeEntryStatusFromJson, toJson: _timeEntryStatusToJson) final TimeEntryStatus status,
    final String? approvedByUserId,
    @FirestoreNullableDateTimeConverter() final DateTime? approvedAt,
    final String? rejectionReason,
    @FirestoreNullableDateTimeConverter() final DateTime? startTime,
  }) = _$TimeEntryImpl;
  const _TimeEntry._() : super._();

  factory _TimeEntry.fromJson(Map<String, dynamic> json) = _$TimeEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get description;
  @override
  int get durationMinutes;
  @override
  @FirestoreDateTimeConverter()
  DateTime get date;
  @override
  String? get projectId;
  @override
  List<String> get tagIds;
  @override
  String get createdByUserId;
  @override
  @FirestoreDateTimeConverter()
  DateTime get createdAt;
  @override
  String? get clickUpTaskId;
  @override
  String? get jiraIssueKey;
  @override
  @JsonKey(fromJson: _timeEntryStatusFromJson, toJson: _timeEntryStatusToJson)
  TimeEntryStatus get status;
  @override
  String? get approvedByUserId;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get approvedAt;
  @override
  String? get rejectionReason;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get startTime;

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeEntryImplCopyWith<_$TimeEntryImpl> get copyWith => throw _privateConstructorUsedError;
}
