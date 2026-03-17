// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clickup_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClickUpTask _$ClickUpTaskFromJson(Map<String, dynamic> json) {
  return _ClickUpTask.fromJson(json);
}

/// @nodoc
mixin _$ClickUpTask {
  String get id => throw _privateConstructorUsedError;
  String? get customId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get statusColor => throw _privateConstructorUsedError;
  String? get priority => throw _privateConstructorUsedError;
  String? get priorityColor => throw _privateConstructorUsedError;
  String? get listId => throw _privateConstructorUsedError;
  String? get listName => throw _privateConstructorUsedError;
  String? get folderId => throw _privateConstructorUsedError;
  String? get folderName => throw _privateConstructorUsedError;
  String? get spaceId => throw _privateConstructorUsedError;
  String? get spaceName => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get dateCreated => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get dateUpdated => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get dateClosed => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get dueDate => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get startDate => throw _privateConstructorUsedError;
  int? get timeEstimate => throw _privateConstructorUsedError;
  int? get timeSpent => throw _privateConstructorUsedError;
  List<ClickUpAssignee> get assignees => throw _privateConstructorUsedError;
  List<ClickUpTag> get tags => throw _privateConstructorUsedError;
  String? get parent => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get syncedAt => throw _privateConstructorUsedError;

  /// Serializes this ClickUpTask to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpTaskCopyWith<ClickUpTask> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpTaskCopyWith<$Res> {
  factory $ClickUpTaskCopyWith(ClickUpTask value, $Res Function(ClickUpTask) then) =
      _$ClickUpTaskCopyWithImpl<$Res, ClickUpTask>;
  @useResult
  $Res call({
    String id,
    String? customId,
    String name,
    String description,
    String status,
    String statusColor,
    String? priority,
    String? priorityColor,
    String? listId,
    String? listName,
    String? folderId,
    String? folderName,
    String? spaceId,
    String? spaceName,
    String? url,
    @FirestoreNullableDateTimeConverter() DateTime? dateCreated,
    @FirestoreNullableDateTimeConverter() DateTime? dateUpdated,
    @FirestoreNullableDateTimeConverter() DateTime? dateClosed,
    @FirestoreNullableDateTimeConverter() DateTime? dueDate,
    @FirestoreNullableDateTimeConverter() DateTime? startDate,
    int? timeEstimate,
    int? timeSpent,
    List<ClickUpAssignee> assignees,
    List<ClickUpTag> tags,
    String? parent,
    @FirestoreNullableDateTimeConverter() DateTime? syncedAt,
  });
}

/// @nodoc
class _$ClickUpTaskCopyWithImpl<$Res, $Val extends ClickUpTask> implements $ClickUpTaskCopyWith<$Res> {
  _$ClickUpTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customId = freezed,
    Object? name = null,
    Object? description = null,
    Object? status = null,
    Object? statusColor = null,
    Object? priority = freezed,
    Object? priorityColor = freezed,
    Object? listId = freezed,
    Object? listName = freezed,
    Object? folderId = freezed,
    Object? folderName = freezed,
    Object? spaceId = freezed,
    Object? spaceName = freezed,
    Object? url = freezed,
    Object? dateCreated = freezed,
    Object? dateUpdated = freezed,
    Object? dateClosed = freezed,
    Object? dueDate = freezed,
    Object? startDate = freezed,
    Object? timeEstimate = freezed,
    Object? timeSpent = freezed,
    Object? assignees = null,
    Object? tags = null,
    Object? parent = freezed,
    Object? syncedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            customId:
                freezed == customId
                    ? _value.customId
                    : customId // ignore: cast_nullable_to_non_nullable
                        as String?,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            statusColor:
                null == statusColor
                    ? _value.statusColor
                    : statusColor // ignore: cast_nullable_to_non_nullable
                        as String,
            priority:
                freezed == priority
                    ? _value.priority
                    : priority // ignore: cast_nullable_to_non_nullable
                        as String?,
            priorityColor:
                freezed == priorityColor
                    ? _value.priorityColor
                    : priorityColor // ignore: cast_nullable_to_non_nullable
                        as String?,
            listId:
                freezed == listId
                    ? _value.listId
                    : listId // ignore: cast_nullable_to_non_nullable
                        as String?,
            listName:
                freezed == listName
                    ? _value.listName
                    : listName // ignore: cast_nullable_to_non_nullable
                        as String?,
            folderId:
                freezed == folderId
                    ? _value.folderId
                    : folderId // ignore: cast_nullable_to_non_nullable
                        as String?,
            folderName:
                freezed == folderName
                    ? _value.folderName
                    : folderName // ignore: cast_nullable_to_non_nullable
                        as String?,
            spaceId:
                freezed == spaceId
                    ? _value.spaceId
                    : spaceId // ignore: cast_nullable_to_non_nullable
                        as String?,
            spaceName:
                freezed == spaceName
                    ? _value.spaceName
                    : spaceName // ignore: cast_nullable_to_non_nullable
                        as String?,
            url:
                freezed == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String?,
            dateCreated:
                freezed == dateCreated
                    ? _value.dateCreated
                    : dateCreated // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            dateUpdated:
                freezed == dateUpdated
                    ? _value.dateUpdated
                    : dateUpdated // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            dateClosed:
                freezed == dateClosed
                    ? _value.dateClosed
                    : dateClosed // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            dueDate:
                freezed == dueDate
                    ? _value.dueDate
                    : dueDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            startDate:
                freezed == startDate
                    ? _value.startDate
                    : startDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            timeEstimate:
                freezed == timeEstimate
                    ? _value.timeEstimate
                    : timeEstimate // ignore: cast_nullable_to_non_nullable
                        as int?,
            timeSpent:
                freezed == timeSpent
                    ? _value.timeSpent
                    : timeSpent // ignore: cast_nullable_to_non_nullable
                        as int?,
            assignees:
                null == assignees
                    ? _value.assignees
                    : assignees // ignore: cast_nullable_to_non_nullable
                        as List<ClickUpAssignee>,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<ClickUpTag>,
            parent:
                freezed == parent
                    ? _value.parent
                    : parent // ignore: cast_nullable_to_non_nullable
                        as String?,
            syncedAt:
                freezed == syncedAt
                    ? _value.syncedAt
                    : syncedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpTaskImplCopyWith<$Res> implements $ClickUpTaskCopyWith<$Res> {
  factory _$$ClickUpTaskImplCopyWith(_$ClickUpTaskImpl value, $Res Function(_$ClickUpTaskImpl) then) =
      __$$ClickUpTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? customId,
    String name,
    String description,
    String status,
    String statusColor,
    String? priority,
    String? priorityColor,
    String? listId,
    String? listName,
    String? folderId,
    String? folderName,
    String? spaceId,
    String? spaceName,
    String? url,
    @FirestoreNullableDateTimeConverter() DateTime? dateCreated,
    @FirestoreNullableDateTimeConverter() DateTime? dateUpdated,
    @FirestoreNullableDateTimeConverter() DateTime? dateClosed,
    @FirestoreNullableDateTimeConverter() DateTime? dueDate,
    @FirestoreNullableDateTimeConverter() DateTime? startDate,
    int? timeEstimate,
    int? timeSpent,
    List<ClickUpAssignee> assignees,
    List<ClickUpTag> tags,
    String? parent,
    @FirestoreNullableDateTimeConverter() DateTime? syncedAt,
  });
}

/// @nodoc
class __$$ClickUpTaskImplCopyWithImpl<$Res> extends _$ClickUpTaskCopyWithImpl<$Res, _$ClickUpTaskImpl>
    implements _$$ClickUpTaskImplCopyWith<$Res> {
  __$$ClickUpTaskImplCopyWithImpl(_$ClickUpTaskImpl _value, $Res Function(_$ClickUpTaskImpl) _then)
    : super(_value, _then);

  /// Create a copy of ClickUpTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customId = freezed,
    Object? name = null,
    Object? description = null,
    Object? status = null,
    Object? statusColor = null,
    Object? priority = freezed,
    Object? priorityColor = freezed,
    Object? listId = freezed,
    Object? listName = freezed,
    Object? folderId = freezed,
    Object? folderName = freezed,
    Object? spaceId = freezed,
    Object? spaceName = freezed,
    Object? url = freezed,
    Object? dateCreated = freezed,
    Object? dateUpdated = freezed,
    Object? dateClosed = freezed,
    Object? dueDate = freezed,
    Object? startDate = freezed,
    Object? timeEstimate = freezed,
    Object? timeSpent = freezed,
    Object? assignees = null,
    Object? tags = null,
    Object? parent = freezed,
    Object? syncedAt = freezed,
  }) {
    return _then(
      _$ClickUpTaskImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        customId:
            freezed == customId
                ? _value.customId
                : customId // ignore: cast_nullable_to_non_nullable
                    as String?,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        statusColor:
            null == statusColor
                ? _value.statusColor
                : statusColor // ignore: cast_nullable_to_non_nullable
                    as String,
        priority:
            freezed == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                    as String?,
        priorityColor:
            freezed == priorityColor
                ? _value.priorityColor
                : priorityColor // ignore: cast_nullable_to_non_nullable
                    as String?,
        listId:
            freezed == listId
                ? _value.listId
                : listId // ignore: cast_nullable_to_non_nullable
                    as String?,
        listName:
            freezed == listName
                ? _value.listName
                : listName // ignore: cast_nullable_to_non_nullable
                    as String?,
        folderId:
            freezed == folderId
                ? _value.folderId
                : folderId // ignore: cast_nullable_to_non_nullable
                    as String?,
        folderName:
            freezed == folderName
                ? _value.folderName
                : folderName // ignore: cast_nullable_to_non_nullable
                    as String?,
        spaceId:
            freezed == spaceId
                ? _value.spaceId
                : spaceId // ignore: cast_nullable_to_non_nullable
                    as String?,
        spaceName:
            freezed == spaceName
                ? _value.spaceName
                : spaceName // ignore: cast_nullable_to_non_nullable
                    as String?,
        url:
            freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String?,
        dateCreated:
            freezed == dateCreated
                ? _value.dateCreated
                : dateCreated // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        dateUpdated:
            freezed == dateUpdated
                ? _value.dateUpdated
                : dateUpdated // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        dateClosed:
            freezed == dateClosed
                ? _value.dateClosed
                : dateClosed // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        dueDate:
            freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        startDate:
            freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        timeEstimate:
            freezed == timeEstimate
                ? _value.timeEstimate
                : timeEstimate // ignore: cast_nullable_to_non_nullable
                    as int?,
        timeSpent:
            freezed == timeSpent
                ? _value.timeSpent
                : timeSpent // ignore: cast_nullable_to_non_nullable
                    as int?,
        assignees:
            null == assignees
                ? _value._assignees
                : assignees // ignore: cast_nullable_to_non_nullable
                    as List<ClickUpAssignee>,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<ClickUpTag>,
        parent:
            freezed == parent
                ? _value.parent
                : parent // ignore: cast_nullable_to_non_nullable
                    as String?,
        syncedAt:
            freezed == syncedAt
                ? _value.syncedAt
                : syncedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpTaskImpl extends _ClickUpTask {
  const _$ClickUpTaskImpl({
    required this.id,
    this.customId,
    required this.name,
    this.description = '',
    this.status = 'unknown',
    this.statusColor = '#808080',
    this.priority,
    this.priorityColor,
    this.listId,
    this.listName,
    this.folderId,
    this.folderName,
    this.spaceId,
    this.spaceName,
    this.url,
    @FirestoreNullableDateTimeConverter() this.dateCreated,
    @FirestoreNullableDateTimeConverter() this.dateUpdated,
    @FirestoreNullableDateTimeConverter() this.dateClosed,
    @FirestoreNullableDateTimeConverter() this.dueDate,
    @FirestoreNullableDateTimeConverter() this.startDate,
    this.timeEstimate,
    this.timeSpent,
    final List<ClickUpAssignee> assignees = const [],
    final List<ClickUpTag> tags = const [],
    this.parent,
    @FirestoreNullableDateTimeConverter() this.syncedAt,
  }) : _assignees = assignees,
       _tags = tags,
       super._();

  factory _$ClickUpTaskImpl.fromJson(Map<String, dynamic> json) => _$$ClickUpTaskImplFromJson(json);

  @override
  final String id;
  @override
  final String? customId;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String statusColor;
  @override
  final String? priority;
  @override
  final String? priorityColor;
  @override
  final String? listId;
  @override
  final String? listName;
  @override
  final String? folderId;
  @override
  final String? folderName;
  @override
  final String? spaceId;
  @override
  final String? spaceName;
  @override
  final String? url;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? dateCreated;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? dateUpdated;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? dateClosed;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? dueDate;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? startDate;
  @override
  final int? timeEstimate;
  @override
  final int? timeSpent;
  final List<ClickUpAssignee> _assignees;
  @override
  @JsonKey()
  List<ClickUpAssignee> get assignees {
    if (_assignees is EqualUnmodifiableListView) return _assignees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignees);
  }

  final List<ClickUpTag> _tags;
  @override
  @JsonKey()
  List<ClickUpTag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? parent;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? syncedAt;

  @override
  String toString() {
    return 'ClickUpTask(id: $id, customId: $customId, name: $name, description: $description, status: $status, statusColor: $statusColor, priority: $priority, priorityColor: $priorityColor, listId: $listId, listName: $listName, folderId: $folderId, folderName: $folderName, spaceId: $spaceId, spaceName: $spaceName, url: $url, dateCreated: $dateCreated, dateUpdated: $dateUpdated, dateClosed: $dateClosed, dueDate: $dueDate, startDate: $startDate, timeEstimate: $timeEstimate, timeSpent: $timeSpent, assignees: $assignees, tags: $tags, parent: $parent, syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customId, customId) || other.customId == customId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) || other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusColor, statusColor) || other.statusColor == statusColor) &&
            (identical(other.priority, priority) || other.priority == priority) &&
            (identical(other.priorityColor, priorityColor) || other.priorityColor == priorityColor) &&
            (identical(other.listId, listId) || other.listId == listId) &&
            (identical(other.listName, listName) || other.listName == listName) &&
            (identical(other.folderId, folderId) || other.folderId == folderId) &&
            (identical(other.folderName, folderName) || other.folderName == folderName) &&
            (identical(other.spaceId, spaceId) || other.spaceId == spaceId) &&
            (identical(other.spaceName, spaceName) || other.spaceName == spaceName) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.dateCreated, dateCreated) || other.dateCreated == dateCreated) &&
            (identical(other.dateUpdated, dateUpdated) || other.dateUpdated == dateUpdated) &&
            (identical(other.dateClosed, dateClosed) || other.dateClosed == dateClosed) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.startDate, startDate) || other.startDate == startDate) &&
            (identical(other.timeEstimate, timeEstimate) || other.timeEstimate == timeEstimate) &&
            (identical(other.timeSpent, timeSpent) || other.timeSpent == timeSpent) &&
            const DeepCollectionEquality().equals(other._assignees, _assignees) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.parent, parent) || other.parent == parent) &&
            (identical(other.syncedAt, syncedAt) || other.syncedAt == syncedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    customId,
    name,
    description,
    status,
    statusColor,
    priority,
    priorityColor,
    listId,
    listName,
    folderId,
    folderName,
    spaceId,
    spaceName,
    url,
    dateCreated,
    dateUpdated,
    dateClosed,
    dueDate,
    startDate,
    timeEstimate,
    timeSpent,
    const DeepCollectionEquality().hash(_assignees),
    const DeepCollectionEquality().hash(_tags),
    parent,
    syncedAt,
  ]);

  /// Create a copy of ClickUpTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpTaskImplCopyWith<_$ClickUpTaskImpl> get copyWith =>
      __$$ClickUpTaskImplCopyWithImpl<_$ClickUpTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpTaskImplToJson(this);
  }
}

abstract class _ClickUpTask extends ClickUpTask {
  const factory _ClickUpTask({
    required final String id,
    final String? customId,
    required final String name,
    final String description,
    final String status,
    final String statusColor,
    final String? priority,
    final String? priorityColor,
    final String? listId,
    final String? listName,
    final String? folderId,
    final String? folderName,
    final String? spaceId,
    final String? spaceName,
    final String? url,
    @FirestoreNullableDateTimeConverter() final DateTime? dateCreated,
    @FirestoreNullableDateTimeConverter() final DateTime? dateUpdated,
    @FirestoreNullableDateTimeConverter() final DateTime? dateClosed,
    @FirestoreNullableDateTimeConverter() final DateTime? dueDate,
    @FirestoreNullableDateTimeConverter() final DateTime? startDate,
    final int? timeEstimate,
    final int? timeSpent,
    final List<ClickUpAssignee> assignees,
    final List<ClickUpTag> tags,
    final String? parent,
    @FirestoreNullableDateTimeConverter() final DateTime? syncedAt,
  }) = _$ClickUpTaskImpl;
  const _ClickUpTask._() : super._();

  factory _ClickUpTask.fromJson(Map<String, dynamic> json) = _$ClickUpTaskImpl.fromJson;

  @override
  String get id;
  @override
  String? get customId;
  @override
  String get name;
  @override
  String get description;
  @override
  String get status;
  @override
  String get statusColor;
  @override
  String? get priority;
  @override
  String? get priorityColor;
  @override
  String? get listId;
  @override
  String? get listName;
  @override
  String? get folderId;
  @override
  String? get folderName;
  @override
  String? get spaceId;
  @override
  String? get spaceName;
  @override
  String? get url;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get dateCreated;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get dateUpdated;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get dateClosed;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get dueDate;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get startDate;
  @override
  int? get timeEstimate;
  @override
  int? get timeSpent;
  @override
  List<ClickUpAssignee> get assignees;
  @override
  List<ClickUpTag> get tags;
  @override
  String? get parent;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get syncedAt;

  /// Create a copy of ClickUpTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpTaskImplCopyWith<_$ClickUpTaskImpl> get copyWith => throw _privateConstructorUsedError;
}

ClickUpAssignee _$ClickUpAssigneeFromJson(Map<String, dynamic> json) {
  return _ClickUpAssignee.fromJson(json);
}

/// @nodoc
mixin _$ClickUpAssignee {
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;

  /// Serializes this ClickUpAssignee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpAssignee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpAssigneeCopyWith<ClickUpAssignee> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpAssigneeCopyWith<$Res> {
  factory $ClickUpAssigneeCopyWith(ClickUpAssignee value, $Res Function(ClickUpAssignee) then) =
      _$ClickUpAssigneeCopyWithImpl<$Res, ClickUpAssignee>;
  @useResult
  $Res call({String id, String? username, String? email, String? profilePicture});
}

/// @nodoc
class _$ClickUpAssigneeCopyWithImpl<$Res, $Val extends ClickUpAssignee> implements $ClickUpAssigneeCopyWith<$Res> {
  _$ClickUpAssigneeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpAssignee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? profilePicture = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            username:
                freezed == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            profilePicture:
                freezed == profilePicture
                    ? _value.profilePicture
                    : profilePicture // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpAssigneeImplCopyWith<$Res> implements $ClickUpAssigneeCopyWith<$Res> {
  factory _$$ClickUpAssigneeImplCopyWith(_$ClickUpAssigneeImpl value, $Res Function(_$ClickUpAssigneeImpl) then) =
      __$$ClickUpAssigneeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? username, String? email, String? profilePicture});
}

/// @nodoc
class __$$ClickUpAssigneeImplCopyWithImpl<$Res> extends _$ClickUpAssigneeCopyWithImpl<$Res, _$ClickUpAssigneeImpl>
    implements _$$ClickUpAssigneeImplCopyWith<$Res> {
  __$$ClickUpAssigneeImplCopyWithImpl(_$ClickUpAssigneeImpl _value, $Res Function(_$ClickUpAssigneeImpl) _then)
    : super(_value, _then);

  /// Create a copy of ClickUpAssignee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? profilePicture = freezed,
  }) {
    return _then(
      _$ClickUpAssigneeImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        username:
            freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        profilePicture:
            freezed == profilePicture
                ? _value.profilePicture
                : profilePicture // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpAssigneeImpl extends _ClickUpAssignee {
  const _$ClickUpAssigneeImpl({required this.id, this.username, this.email, this.profilePicture}) : super._();

  factory _$ClickUpAssigneeImpl.fromJson(Map<String, dynamic> json) => _$$ClickUpAssigneeImplFromJson(json);

  @override
  final String id;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? profilePicture;

  @override
  String toString() {
    return 'ClickUpAssignee(id: $id, username: $username, email: $email, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpAssigneeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) || other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, email, profilePicture);

  /// Create a copy of ClickUpAssignee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpAssigneeImplCopyWith<_$ClickUpAssigneeImpl> get copyWith =>
      __$$ClickUpAssigneeImplCopyWithImpl<_$ClickUpAssigneeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpAssigneeImplToJson(this);
  }
}

abstract class _ClickUpAssignee extends ClickUpAssignee {
  const factory _ClickUpAssignee({
    required final String id,
    final String? username,
    final String? email,
    final String? profilePicture,
  }) = _$ClickUpAssigneeImpl;
  const _ClickUpAssignee._() : super._();

  factory _ClickUpAssignee.fromJson(Map<String, dynamic> json) = _$ClickUpAssigneeImpl.fromJson;

  @override
  String get id;
  @override
  String? get username;
  @override
  String? get email;
  @override
  String? get profilePicture;

  /// Create a copy of ClickUpAssignee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpAssigneeImplCopyWith<_$ClickUpAssigneeImpl> get copyWith => throw _privateConstructorUsedError;
}

ClickUpTag _$ClickUpTagFromJson(Map<String, dynamic> json) {
  return _ClickUpTag.fromJson(json);
}

/// @nodoc
mixin _$ClickUpTag {
  String get name => throw _privateConstructorUsedError;
  String? get tagFg => throw _privateConstructorUsedError;
  String? get tagBg => throw _privateConstructorUsedError;

  /// Serializes this ClickUpTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpTagCopyWith<ClickUpTag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpTagCopyWith<$Res> {
  factory $ClickUpTagCopyWith(ClickUpTag value, $Res Function(ClickUpTag) then) =
      _$ClickUpTagCopyWithImpl<$Res, ClickUpTag>;
  @useResult
  $Res call({String name, String? tagFg, String? tagBg});
}

/// @nodoc
class _$ClickUpTagCopyWithImpl<$Res, $Val extends ClickUpTag> implements $ClickUpTagCopyWith<$Res> {
  _$ClickUpTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? tagFg = freezed, Object? tagBg = freezed}) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            tagFg:
                freezed == tagFg
                    ? _value.tagFg
                    : tagFg // ignore: cast_nullable_to_non_nullable
                        as String?,
            tagBg:
                freezed == tagBg
                    ? _value.tagBg
                    : tagBg // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpTagImplCopyWith<$Res> implements $ClickUpTagCopyWith<$Res> {
  factory _$$ClickUpTagImplCopyWith(_$ClickUpTagImpl value, $Res Function(_$ClickUpTagImpl) then) =
      __$$ClickUpTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? tagFg, String? tagBg});
}

/// @nodoc
class __$$ClickUpTagImplCopyWithImpl<$Res> extends _$ClickUpTagCopyWithImpl<$Res, _$ClickUpTagImpl>
    implements _$$ClickUpTagImplCopyWith<$Res> {
  __$$ClickUpTagImplCopyWithImpl(_$ClickUpTagImpl _value, $Res Function(_$ClickUpTagImpl) _then) : super(_value, _then);

  /// Create a copy of ClickUpTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? tagFg = freezed, Object? tagBg = freezed}) {
    return _then(
      _$ClickUpTagImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        tagFg:
            freezed == tagFg
                ? _value.tagFg
                : tagFg // ignore: cast_nullable_to_non_nullable
                    as String?,
        tagBg:
            freezed == tagBg
                ? _value.tagBg
                : tagBg // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpTagImpl extends _ClickUpTag {
  const _$ClickUpTagImpl({required this.name, this.tagFg, this.tagBg}) : super._();

  factory _$ClickUpTagImpl.fromJson(Map<String, dynamic> json) => _$$ClickUpTagImplFromJson(json);

  @override
  final String name;
  @override
  final String? tagFg;
  @override
  final String? tagBg;

  @override
  String toString() {
    return 'ClickUpTag(name: $name, tagFg: $tagFg, tagBg: $tagBg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpTagImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tagFg, tagFg) || other.tagFg == tagFg) &&
            (identical(other.tagBg, tagBg) || other.tagBg == tagBg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, tagFg, tagBg);

  /// Create a copy of ClickUpTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpTagImplCopyWith<_$ClickUpTagImpl> get copyWith =>
      __$$ClickUpTagImplCopyWithImpl<_$ClickUpTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpTagImplToJson(this);
  }
}

abstract class _ClickUpTag extends ClickUpTag {
  const factory _ClickUpTag({required final String name, final String? tagFg, final String? tagBg}) = _$ClickUpTagImpl;
  const _ClickUpTag._() : super._();

  factory _ClickUpTag.fromJson(Map<String, dynamic> json) = _$ClickUpTagImpl.fromJson;

  @override
  String get name;
  @override
  String? get tagFg;
  @override
  String? get tagBg;

  /// Create a copy of ClickUpTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpTagImplCopyWith<_$ClickUpTagImpl> get copyWith => throw _privateConstructorUsedError;
}

ClickUpWorkspace _$ClickUpWorkspaceFromJson(Map<String, dynamic> json) {
  return _ClickUpWorkspace.fromJson(json);
}

/// @nodoc
mixin _$ClickUpWorkspace {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  /// Serializes this ClickUpWorkspace to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpWorkspaceCopyWith<ClickUpWorkspace> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpWorkspaceCopyWith<$Res> {
  factory $ClickUpWorkspaceCopyWith(ClickUpWorkspace value, $Res Function(ClickUpWorkspace) then) =
      _$ClickUpWorkspaceCopyWithImpl<$Res, ClickUpWorkspace>;
  @useResult
  $Res call({String id, String name, String? color, String? avatar});
}

/// @nodoc
class _$ClickUpWorkspaceCopyWithImpl<$Res, $Val extends ClickUpWorkspace> implements $ClickUpWorkspaceCopyWith<$Res> {
  _$ClickUpWorkspaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? color = freezed, Object? avatar = freezed}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            color:
                freezed == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as String?,
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpWorkspaceImplCopyWith<$Res> implements $ClickUpWorkspaceCopyWith<$Res> {
  factory _$$ClickUpWorkspaceImplCopyWith(_$ClickUpWorkspaceImpl value, $Res Function(_$ClickUpWorkspaceImpl) then) =
      __$$ClickUpWorkspaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? color, String? avatar});
}

/// @nodoc
class __$$ClickUpWorkspaceImplCopyWithImpl<$Res> extends _$ClickUpWorkspaceCopyWithImpl<$Res, _$ClickUpWorkspaceImpl>
    implements _$$ClickUpWorkspaceImplCopyWith<$Res> {
  __$$ClickUpWorkspaceImplCopyWithImpl(_$ClickUpWorkspaceImpl _value, $Res Function(_$ClickUpWorkspaceImpl) _then)
    : super(_value, _then);

  /// Create a copy of ClickUpWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? color = freezed, Object? avatar = freezed}) {
    return _then(
      _$ClickUpWorkspaceImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        color:
            freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as String?,
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpWorkspaceImpl extends _ClickUpWorkspace {
  const _$ClickUpWorkspaceImpl({required this.id, required this.name, this.color, this.avatar}) : super._();

  factory _$ClickUpWorkspaceImpl.fromJson(Map<String, dynamic> json) => _$$ClickUpWorkspaceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? color;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'ClickUpWorkspace(id: $id, name: $name, color: $color, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpWorkspaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color, avatar);

  /// Create a copy of ClickUpWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpWorkspaceImplCopyWith<_$ClickUpWorkspaceImpl> get copyWith =>
      __$$ClickUpWorkspaceImplCopyWithImpl<_$ClickUpWorkspaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpWorkspaceImplToJson(this);
  }
}

abstract class _ClickUpWorkspace extends ClickUpWorkspace {
  const factory _ClickUpWorkspace({
    required final String id,
    required final String name,
    final String? color,
    final String? avatar,
  }) = _$ClickUpWorkspaceImpl;
  const _ClickUpWorkspace._() : super._();

  factory _ClickUpWorkspace.fromJson(Map<String, dynamic> json) = _$ClickUpWorkspaceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get color;
  @override
  String? get avatar;

  /// Create a copy of ClickUpWorkspace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpWorkspaceImplCopyWith<_$ClickUpWorkspaceImpl> get copyWith => throw _privateConstructorUsedError;
}

ClickUpSpace _$ClickUpSpaceFromJson(Map<String, dynamic> json) {
  return _ClickUpSpace.fromJson(json);
}

/// @nodoc
mixin _$ClickUpSpace {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  bool get private => throw _privateConstructorUsedError;

  /// Serializes this ClickUpSpace to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpSpace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpSpaceCopyWith<ClickUpSpace> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpSpaceCopyWith<$Res> {
  factory $ClickUpSpaceCopyWith(ClickUpSpace value, $Res Function(ClickUpSpace) then) =
      _$ClickUpSpaceCopyWithImpl<$Res, ClickUpSpace>;
  @useResult
  $Res call({String id, String name, String? color, bool private});
}

/// @nodoc
class _$ClickUpSpaceCopyWithImpl<$Res, $Val extends ClickUpSpace> implements $ClickUpSpaceCopyWith<$Res> {
  _$ClickUpSpaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpSpace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? color = freezed, Object? private = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            color:
                freezed == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as String?,
            private:
                null == private
                    ? _value.private
                    : private // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpSpaceImplCopyWith<$Res> implements $ClickUpSpaceCopyWith<$Res> {
  factory _$$ClickUpSpaceImplCopyWith(_$ClickUpSpaceImpl value, $Res Function(_$ClickUpSpaceImpl) then) =
      __$$ClickUpSpaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? color, bool private});
}

/// @nodoc
class __$$ClickUpSpaceImplCopyWithImpl<$Res> extends _$ClickUpSpaceCopyWithImpl<$Res, _$ClickUpSpaceImpl>
    implements _$$ClickUpSpaceImplCopyWith<$Res> {
  __$$ClickUpSpaceImplCopyWithImpl(_$ClickUpSpaceImpl _value, $Res Function(_$ClickUpSpaceImpl) _then)
    : super(_value, _then);

  /// Create a copy of ClickUpSpace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? color = freezed, Object? private = null}) {
    return _then(
      _$ClickUpSpaceImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        color:
            freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as String?,
        private:
            null == private
                ? _value.private
                : private // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpSpaceImpl extends _ClickUpSpace {
  const _$ClickUpSpaceImpl({required this.id, required this.name, this.color, this.private = false}) : super._();

  factory _$ClickUpSpaceImpl.fromJson(Map<String, dynamic> json) => _$$ClickUpSpaceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? color;
  @override
  @JsonKey()
  final bool private;

  @override
  String toString() {
    return 'ClickUpSpace(id: $id, name: $name, color: $color, private: $private)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpSpaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.private, private) || other.private == private));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color, private);

  /// Create a copy of ClickUpSpace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpSpaceImplCopyWith<_$ClickUpSpaceImpl> get copyWith =>
      __$$ClickUpSpaceImplCopyWithImpl<_$ClickUpSpaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpSpaceImplToJson(this);
  }
}

abstract class _ClickUpSpace extends ClickUpSpace {
  const factory _ClickUpSpace({
    required final String id,
    required final String name,
    final String? color,
    final bool private,
  }) = _$ClickUpSpaceImpl;
  const _ClickUpSpace._() : super._();

  factory _ClickUpSpace.fromJson(Map<String, dynamic> json) = _$ClickUpSpaceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get color;
  @override
  bool get private;

  /// Create a copy of ClickUpSpace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpSpaceImplCopyWith<_$ClickUpSpaceImpl> get copyWith => throw _privateConstructorUsedError;
}

ClickUpFolder _$ClickUpFolderFromJson(Map<String, dynamic> json) {
  return _ClickUpFolder.fromJson(json);
}

/// @nodoc
mixin _$ClickUpFolder {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get hidden => throw _privateConstructorUsedError;
  List<ClickUpList> get lists => throw _privateConstructorUsedError;

  /// Serializes this ClickUpFolder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpFolder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpFolderCopyWith<ClickUpFolder> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpFolderCopyWith<$Res> {
  factory $ClickUpFolderCopyWith(ClickUpFolder value, $Res Function(ClickUpFolder) then) =
      _$ClickUpFolderCopyWithImpl<$Res, ClickUpFolder>;
  @useResult
  $Res call({String id, String name, bool hidden, List<ClickUpList> lists});
}

/// @nodoc
class _$ClickUpFolderCopyWithImpl<$Res, $Val extends ClickUpFolder> implements $ClickUpFolderCopyWith<$Res> {
  _$ClickUpFolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpFolder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? hidden = null, Object? lists = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            hidden:
                null == hidden
                    ? _value.hidden
                    : hidden // ignore: cast_nullable_to_non_nullable
                        as bool,
            lists:
                null == lists
                    ? _value.lists
                    : lists // ignore: cast_nullable_to_non_nullable
                        as List<ClickUpList>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpFolderImplCopyWith<$Res> implements $ClickUpFolderCopyWith<$Res> {
  factory _$$ClickUpFolderImplCopyWith(_$ClickUpFolderImpl value, $Res Function(_$ClickUpFolderImpl) then) =
      __$$ClickUpFolderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, bool hidden, List<ClickUpList> lists});
}

/// @nodoc
class __$$ClickUpFolderImplCopyWithImpl<$Res> extends _$ClickUpFolderCopyWithImpl<$Res, _$ClickUpFolderImpl>
    implements _$$ClickUpFolderImplCopyWith<$Res> {
  __$$ClickUpFolderImplCopyWithImpl(_$ClickUpFolderImpl _value, $Res Function(_$ClickUpFolderImpl) _then)
    : super(_value, _then);

  /// Create a copy of ClickUpFolder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? hidden = null, Object? lists = null}) {
    return _then(
      _$ClickUpFolderImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        hidden:
            null == hidden
                ? _value.hidden
                : hidden // ignore: cast_nullable_to_non_nullable
                    as bool,
        lists:
            null == lists
                ? _value._lists
                : lists // ignore: cast_nullable_to_non_nullable
                    as List<ClickUpList>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpFolderImpl extends _ClickUpFolder {
  const _$ClickUpFolderImpl({
    required this.id,
    required this.name,
    this.hidden = false,
    final List<ClickUpList> lists = const [],
  }) : _lists = lists,
       super._();

  factory _$ClickUpFolderImpl.fromJson(Map<String, dynamic> json) => _$$ClickUpFolderImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final bool hidden;
  final List<ClickUpList> _lists;
  @override
  @JsonKey()
  List<ClickUpList> get lists {
    if (_lists is EqualUnmodifiableListView) return _lists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lists);
  }

  @override
  String toString() {
    return 'ClickUpFolder(id: $id, name: $name, hidden: $hidden, lists: $lists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpFolderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            const DeepCollectionEquality().equals(other._lists, _lists));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, hidden, const DeepCollectionEquality().hash(_lists));

  /// Create a copy of ClickUpFolder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpFolderImplCopyWith<_$ClickUpFolderImpl> get copyWith =>
      __$$ClickUpFolderImplCopyWithImpl<_$ClickUpFolderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpFolderImplToJson(this);
  }
}

abstract class _ClickUpFolder extends ClickUpFolder {
  const factory _ClickUpFolder({
    required final String id,
    required final String name,
    final bool hidden,
    final List<ClickUpList> lists,
  }) = _$ClickUpFolderImpl;
  const _ClickUpFolder._() : super._();

  factory _ClickUpFolder.fromJson(Map<String, dynamic> json) = _$ClickUpFolderImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get hidden;
  @override
  List<ClickUpList> get lists;

  /// Create a copy of ClickUpFolder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpFolderImplCopyWith<_$ClickUpFolderImpl> get copyWith => throw _privateConstructorUsedError;
}

ClickUpList _$ClickUpListFromJson(Map<String, dynamic> json) {
  return _ClickUpList.fromJson(json);
}

/// @nodoc
mixin _$ClickUpList {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  bool get isSelected => throw _privateConstructorUsedError;

  /// Serializes this ClickUpList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpListCopyWith<ClickUpList> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpListCopyWith<$Res> {
  factory $ClickUpListCopyWith(ClickUpList value, $Res Function(ClickUpList) then) =
      _$ClickUpListCopyWithImpl<$Res, ClickUpList>;
  @useResult
  $Res call({String id, String name, String? content, bool isSelected});
}

/// @nodoc
class _$ClickUpListCopyWithImpl<$Res, $Val extends ClickUpList> implements $ClickUpListCopyWith<$Res> {
  _$ClickUpListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? content = freezed, Object? isSelected = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                freezed == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String?,
            isSelected:
                null == isSelected
                    ? _value.isSelected
                    : isSelected // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpListImplCopyWith<$Res> implements $ClickUpListCopyWith<$Res> {
  factory _$$ClickUpListImplCopyWith(_$ClickUpListImpl value, $Res Function(_$ClickUpListImpl) then) =
      __$$ClickUpListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? content, bool isSelected});
}

/// @nodoc
class __$$ClickUpListImplCopyWithImpl<$Res> extends _$ClickUpListCopyWithImpl<$Res, _$ClickUpListImpl>
    implements _$$ClickUpListImplCopyWith<$Res> {
  __$$ClickUpListImplCopyWithImpl(_$ClickUpListImpl _value, $Res Function(_$ClickUpListImpl) _then)
    : super(_value, _then);

  /// Create a copy of ClickUpList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? content = freezed, Object? isSelected = null}) {
    return _then(
      _$ClickUpListImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String?,
        isSelected:
            null == isSelected
                ? _value.isSelected
                : isSelected // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpListImpl extends _ClickUpList {
  const _$ClickUpListImpl({required this.id, required this.name, this.content, this.isSelected = false}) : super._();

  factory _$ClickUpListImpl.fromJson(Map<String, dynamic> json) => _$$ClickUpListImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? content;
  @override
  @JsonKey()
  final bool isSelected;

  @override
  String toString() {
    return 'ClickUpList(id: $id, name: $name, content: $content, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isSelected, isSelected) || other.isSelected == isSelected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, content, isSelected);

  /// Create a copy of ClickUpList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpListImplCopyWith<_$ClickUpListImpl> get copyWith =>
      __$$ClickUpListImplCopyWithImpl<_$ClickUpListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpListImplToJson(this);
  }
}

abstract class _ClickUpList extends ClickUpList {
  const factory _ClickUpList({
    required final String id,
    required final String name,
    final String? content,
    final bool isSelected,
  }) = _$ClickUpListImpl;
  const _ClickUpList._() : super._();

  factory _ClickUpList.fromJson(Map<String, dynamic> json) = _$ClickUpListImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get content;
  @override
  bool get isSelected;

  /// Create a copy of ClickUpList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpListImplCopyWith<_$ClickUpListImpl> get copyWith => throw _privateConstructorUsedError;
}

ClickUpSettings _$ClickUpSettingsFromJson(Map<String, dynamic> json) {
  return _ClickUpSettings.fromJson(json);
}

/// @nodoc
mixin _$ClickUpSettings {
  bool get isConfigured => throw _privateConstructorUsedError;
  bool get hasApiToken => throw _privateConstructorUsedError;
  List<String> get selectedListIds => throw _privateConstructorUsedError;
  String? get workspaceId => throw _privateConstructorUsedError;
  String? get webhookId => throw _privateConstructorUsedError;
  String? get webhookUrl => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get lastSyncAt => throw _privateConstructorUsedError;
  int get lastSyncTaskCount => throw _privateConstructorUsedError;

  /// Serializes this ClickUpSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpSettingsCopyWith<ClickUpSettings> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpSettingsCopyWith<$Res> {
  factory $ClickUpSettingsCopyWith(ClickUpSettings value, $Res Function(ClickUpSettings) then) =
      _$ClickUpSettingsCopyWithImpl<$Res, ClickUpSettings>;
  @useResult
  $Res call({
    bool isConfigured,
    bool hasApiToken,
    List<String> selectedListIds,
    String? workspaceId,
    String? webhookId,
    String? webhookUrl,
    @FirestoreNullableDateTimeConverter() DateTime? lastSyncAt,
    int lastSyncTaskCount,
  });
}

/// @nodoc
class _$ClickUpSettingsCopyWithImpl<$Res, $Val extends ClickUpSettings> implements $ClickUpSettingsCopyWith<$Res> {
  _$ClickUpSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConfigured = null,
    Object? hasApiToken = null,
    Object? selectedListIds = null,
    Object? workspaceId = freezed,
    Object? webhookId = freezed,
    Object? webhookUrl = freezed,
    Object? lastSyncAt = freezed,
    Object? lastSyncTaskCount = null,
  }) {
    return _then(
      _value.copyWith(
            isConfigured:
                null == isConfigured
                    ? _value.isConfigured
                    : isConfigured // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasApiToken:
                null == hasApiToken
                    ? _value.hasApiToken
                    : hasApiToken // ignore: cast_nullable_to_non_nullable
                        as bool,
            selectedListIds:
                null == selectedListIds
                    ? _value.selectedListIds
                    : selectedListIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            workspaceId:
                freezed == workspaceId
                    ? _value.workspaceId
                    : workspaceId // ignore: cast_nullable_to_non_nullable
                        as String?,
            webhookId:
                freezed == webhookId
                    ? _value.webhookId
                    : webhookId // ignore: cast_nullable_to_non_nullable
                        as String?,
            webhookUrl:
                freezed == webhookUrl
                    ? _value.webhookUrl
                    : webhookUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastSyncAt:
                freezed == lastSyncAt
                    ? _value.lastSyncAt
                    : lastSyncAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastSyncTaskCount:
                null == lastSyncTaskCount
                    ? _value.lastSyncTaskCount
                    : lastSyncTaskCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpSettingsImplCopyWith<$Res> implements $ClickUpSettingsCopyWith<$Res> {
  factory _$$ClickUpSettingsImplCopyWith(_$ClickUpSettingsImpl value, $Res Function(_$ClickUpSettingsImpl) then) =
      __$$ClickUpSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isConfigured,
    bool hasApiToken,
    List<String> selectedListIds,
    String? workspaceId,
    String? webhookId,
    String? webhookUrl,
    @FirestoreNullableDateTimeConverter() DateTime? lastSyncAt,
    int lastSyncTaskCount,
  });
}

/// @nodoc
class __$$ClickUpSettingsImplCopyWithImpl<$Res> extends _$ClickUpSettingsCopyWithImpl<$Res, _$ClickUpSettingsImpl>
    implements _$$ClickUpSettingsImplCopyWith<$Res> {
  __$$ClickUpSettingsImplCopyWithImpl(_$ClickUpSettingsImpl _value, $Res Function(_$ClickUpSettingsImpl) _then)
    : super(_value, _then);

  /// Create a copy of ClickUpSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConfigured = null,
    Object? hasApiToken = null,
    Object? selectedListIds = null,
    Object? workspaceId = freezed,
    Object? webhookId = freezed,
    Object? webhookUrl = freezed,
    Object? lastSyncAt = freezed,
    Object? lastSyncTaskCount = null,
  }) {
    return _then(
      _$ClickUpSettingsImpl(
        isConfigured:
            null == isConfigured
                ? _value.isConfigured
                : isConfigured // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasApiToken:
            null == hasApiToken
                ? _value.hasApiToken
                : hasApiToken // ignore: cast_nullable_to_non_nullable
                    as bool,
        selectedListIds:
            null == selectedListIds
                ? _value._selectedListIds
                : selectedListIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        workspaceId:
            freezed == workspaceId
                ? _value.workspaceId
                : workspaceId // ignore: cast_nullable_to_non_nullable
                    as String?,
        webhookId:
            freezed == webhookId
                ? _value.webhookId
                : webhookId // ignore: cast_nullable_to_non_nullable
                    as String?,
        webhookUrl:
            freezed == webhookUrl
                ? _value.webhookUrl
                : webhookUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastSyncAt:
            freezed == lastSyncAt
                ? _value.lastSyncAt
                : lastSyncAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastSyncTaskCount:
            null == lastSyncTaskCount
                ? _value.lastSyncTaskCount
                : lastSyncTaskCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpSettingsImpl extends _ClickUpSettings {
  const _$ClickUpSettingsImpl({
    this.isConfigured = false,
    this.hasApiToken = false,
    final List<String> selectedListIds = const [],
    this.workspaceId,
    this.webhookId,
    this.webhookUrl,
    @FirestoreNullableDateTimeConverter() this.lastSyncAt,
    this.lastSyncTaskCount = 0,
  }) : _selectedListIds = selectedListIds,
       super._();

  factory _$ClickUpSettingsImpl.fromJson(Map<String, dynamic> json) => _$$ClickUpSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool isConfigured;
  @override
  @JsonKey()
  final bool hasApiToken;
  final List<String> _selectedListIds;
  @override
  @JsonKey()
  List<String> get selectedListIds {
    if (_selectedListIds is EqualUnmodifiableListView) return _selectedListIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedListIds);
  }

  @override
  final String? workspaceId;
  @override
  final String? webhookId;
  @override
  final String? webhookUrl;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? lastSyncAt;
  @override
  @JsonKey()
  final int lastSyncTaskCount;

  @override
  String toString() {
    return 'ClickUpSettings(isConfigured: $isConfigured, hasApiToken: $hasApiToken, selectedListIds: $selectedListIds, workspaceId: $workspaceId, webhookId: $webhookId, webhookUrl: $webhookUrl, lastSyncAt: $lastSyncAt, lastSyncTaskCount: $lastSyncTaskCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpSettingsImpl &&
            (identical(other.isConfigured, isConfigured) || other.isConfigured == isConfigured) &&
            (identical(other.hasApiToken, hasApiToken) || other.hasApiToken == hasApiToken) &&
            const DeepCollectionEquality().equals(other._selectedListIds, _selectedListIds) &&
            (identical(other.workspaceId, workspaceId) || other.workspaceId == workspaceId) &&
            (identical(other.webhookId, webhookId) || other.webhookId == webhookId) &&
            (identical(other.webhookUrl, webhookUrl) || other.webhookUrl == webhookUrl) &&
            (identical(other.lastSyncAt, lastSyncAt) || other.lastSyncAt == lastSyncAt) &&
            (identical(other.lastSyncTaskCount, lastSyncTaskCount) || other.lastSyncTaskCount == lastSyncTaskCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isConfigured,
    hasApiToken,
    const DeepCollectionEquality().hash(_selectedListIds),
    workspaceId,
    webhookId,
    webhookUrl,
    lastSyncAt,
    lastSyncTaskCount,
  );

  /// Create a copy of ClickUpSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpSettingsImplCopyWith<_$ClickUpSettingsImpl> get copyWith =>
      __$$ClickUpSettingsImplCopyWithImpl<_$ClickUpSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpSettingsImplToJson(this);
  }
}

abstract class _ClickUpSettings extends ClickUpSettings {
  const factory _ClickUpSettings({
    final bool isConfigured,
    final bool hasApiToken,
    final List<String> selectedListIds,
    final String? workspaceId,
    final String? webhookId,
    final String? webhookUrl,
    @FirestoreNullableDateTimeConverter() final DateTime? lastSyncAt,
    final int lastSyncTaskCount,
  }) = _$ClickUpSettingsImpl;
  const _ClickUpSettings._() : super._();

  factory _ClickUpSettings.fromJson(Map<String, dynamic> json) = _$ClickUpSettingsImpl.fromJson;

  @override
  bool get isConfigured;
  @override
  bool get hasApiToken;
  @override
  List<String> get selectedListIds;
  @override
  String? get workspaceId;
  @override
  String? get webhookId;
  @override
  String? get webhookUrl;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get lastSyncAt;
  @override
  int get lastSyncTaskCount;

  /// Create a copy of ClickUpSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpSettingsImplCopyWith<_$ClickUpSettingsImpl> get copyWith => throw _privateConstructorUsedError;
}
