// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jira_issue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

JiraIssue _$JiraIssueFromJson(Map<String, dynamic> json) {
  return _JiraIssue.fromJson(json);
}

/// @nodoc
mixin _$JiraIssue {
  String get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  JiraStatus get status => throw _privateConstructorUsedError;
  JiraProject get project => throw _privateConstructorUsedError;
  String? get priority => throw _privateConstructorUsedError;
  String? get assignee => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this JiraIssue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JiraIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JiraIssueCopyWith<JiraIssue> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JiraIssueCopyWith<$Res> {
  factory $JiraIssueCopyWith(JiraIssue value, $Res Function(JiraIssue) then) = _$JiraIssueCopyWithImpl<$Res, JiraIssue>;
  @useResult
  $Res call({
    String id,
    String key,
    String summary,
    JiraStatus status,
    JiraProject project,
    String? priority,
    String? assignee,
    String? url,
    @FirestoreNullableDateTimeConverter() DateTime? updatedAt,
  });

  $JiraStatusCopyWith<$Res> get status;
  $JiraProjectCopyWith<$Res> get project;
}

/// @nodoc
class _$JiraIssueCopyWithImpl<$Res, $Val extends JiraIssue> implements $JiraIssueCopyWith<$Res> {
  _$JiraIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JiraIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? summary = null,
    Object? status = null,
    Object? project = null,
    Object? priority = freezed,
    Object? assignee = freezed,
    Object? url = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            key:
                null == key
                    ? _value.key
                    : key // ignore: cast_nullable_to_non_nullable
                        as String,
            summary:
                null == summary
                    ? _value.summary
                    : summary // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as JiraStatus,
            project:
                null == project
                    ? _value.project
                    : project // ignore: cast_nullable_to_non_nullable
                        as JiraProject,
            priority:
                freezed == priority
                    ? _value.priority
                    : priority // ignore: cast_nullable_to_non_nullable
                        as String?,
            assignee:
                freezed == assignee
                    ? _value.assignee
                    : assignee // ignore: cast_nullable_to_non_nullable
                        as String?,
            url:
                freezed == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of JiraIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JiraStatusCopyWith<$Res> get status {
    return $JiraStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of JiraIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JiraProjectCopyWith<$Res> get project {
    return $JiraProjectCopyWith<$Res>(_value.project, (value) {
      return _then(_value.copyWith(project: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JiraIssueImplCopyWith<$Res> implements $JiraIssueCopyWith<$Res> {
  factory _$$JiraIssueImplCopyWith(_$JiraIssueImpl value, $Res Function(_$JiraIssueImpl) then) =
      __$$JiraIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String key,
    String summary,
    JiraStatus status,
    JiraProject project,
    String? priority,
    String? assignee,
    String? url,
    @FirestoreNullableDateTimeConverter() DateTime? updatedAt,
  });

  @override
  $JiraStatusCopyWith<$Res> get status;
  @override
  $JiraProjectCopyWith<$Res> get project;
}

/// @nodoc
class __$$JiraIssueImplCopyWithImpl<$Res> extends _$JiraIssueCopyWithImpl<$Res, _$JiraIssueImpl>
    implements _$$JiraIssueImplCopyWith<$Res> {
  __$$JiraIssueImplCopyWithImpl(_$JiraIssueImpl _value, $Res Function(_$JiraIssueImpl) _then) : super(_value, _then);

  /// Create a copy of JiraIssue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? summary = null,
    Object? status = null,
    Object? project = null,
    Object? priority = freezed,
    Object? assignee = freezed,
    Object? url = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$JiraIssueImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        key:
            null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                    as String,
        summary:
            null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as JiraStatus,
        project:
            null == project
                ? _value.project
                : project // ignore: cast_nullable_to_non_nullable
                    as JiraProject,
        priority:
            freezed == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                    as String?,
        assignee:
            freezed == assignee
                ? _value.assignee
                : assignee // ignore: cast_nullable_to_non_nullable
                    as String?,
        url:
            freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JiraIssueImpl extends _JiraIssue {
  const _$JiraIssueImpl({
    required this.id,
    required this.key,
    required this.summary,
    required this.status,
    required this.project,
    this.priority,
    this.assignee,
    this.url,
    @FirestoreNullableDateTimeConverter() this.updatedAt,
  }) : super._();

  factory _$JiraIssueImpl.fromJson(Map<String, dynamic> json) => _$$JiraIssueImplFromJson(json);

  @override
  final String id;
  @override
  final String key;
  @override
  final String summary;
  @override
  final JiraStatus status;
  @override
  final JiraProject project;
  @override
  final String? priority;
  @override
  final String? assignee;
  @override
  final String? url;
  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'JiraIssue(id: $id, key: $key, summary: $summary, status: $status, project: $project, priority: $priority, assignee: $assignee, url: $url, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JiraIssueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.priority, priority) || other.priority == priority) &&
            (identical(other.assignee, assignee) || other.assignee == assignee) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, key, summary, status, project, priority, assignee, url, updatedAt);

  /// Create a copy of JiraIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JiraIssueImplCopyWith<_$JiraIssueImpl> get copyWith =>
      __$$JiraIssueImplCopyWithImpl<_$JiraIssueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JiraIssueImplToJson(this);
  }
}

abstract class _JiraIssue extends JiraIssue {
  const factory _JiraIssue({
    required final String id,
    required final String key,
    required final String summary,
    required final JiraStatus status,
    required final JiraProject project,
    final String? priority,
    final String? assignee,
    final String? url,
    @FirestoreNullableDateTimeConverter() final DateTime? updatedAt,
  }) = _$JiraIssueImpl;
  const _JiraIssue._() : super._();

  factory _JiraIssue.fromJson(Map<String, dynamic> json) = _$JiraIssueImpl.fromJson;

  @override
  String get id;
  @override
  String get key;
  @override
  String get summary;
  @override
  JiraStatus get status;
  @override
  JiraProject get project;
  @override
  String? get priority;
  @override
  String? get assignee;
  @override
  String? get url;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get updatedAt;

  /// Create a copy of JiraIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JiraIssueImplCopyWith<_$JiraIssueImpl> get copyWith => throw _privateConstructorUsedError;
}

JiraProject _$JiraProjectFromJson(Map<String, dynamic> json) {
  return _JiraProject.fromJson(json);
}

/// @nodoc
mixin _$JiraProject {
  String get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this JiraProject to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JiraProject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JiraProjectCopyWith<JiraProject> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JiraProjectCopyWith<$Res> {
  factory $JiraProjectCopyWith(JiraProject value, $Res Function(JiraProject) then) =
      _$JiraProjectCopyWithImpl<$Res, JiraProject>;
  @useResult
  $Res call({String id, String key, String name});
}

/// @nodoc
class _$JiraProjectCopyWithImpl<$Res, $Val extends JiraProject> implements $JiraProjectCopyWith<$Res> {
  _$JiraProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JiraProject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? key = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            key:
                null == key
                    ? _value.key
                    : key // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JiraProjectImplCopyWith<$Res> implements $JiraProjectCopyWith<$Res> {
  factory _$$JiraProjectImplCopyWith(_$JiraProjectImpl value, $Res Function(_$JiraProjectImpl) then) =
      __$$JiraProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String key, String name});
}

/// @nodoc
class __$$JiraProjectImplCopyWithImpl<$Res> extends _$JiraProjectCopyWithImpl<$Res, _$JiraProjectImpl>
    implements _$$JiraProjectImplCopyWith<$Res> {
  __$$JiraProjectImplCopyWithImpl(_$JiraProjectImpl _value, $Res Function(_$JiraProjectImpl) _then)
    : super(_value, _then);

  /// Create a copy of JiraProject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? key = null, Object? name = null}) {
    return _then(
      _$JiraProjectImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        key:
            null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JiraProjectImpl extends _JiraProject {
  const _$JiraProjectImpl({required this.id, required this.key, required this.name}) : super._();

  factory _$JiraProjectImpl.fromJson(Map<String, dynamic> json) => _$$JiraProjectImplFromJson(json);

  @override
  final String id;
  @override
  final String key;
  @override
  final String name;

  @override
  String toString() {
    return 'JiraProject(id: $id, key: $key, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JiraProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, key, name);

  /// Create a copy of JiraProject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JiraProjectImplCopyWith<_$JiraProjectImpl> get copyWith =>
      __$$JiraProjectImplCopyWithImpl<_$JiraProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JiraProjectImplToJson(this);
  }
}

abstract class _JiraProject extends JiraProject {
  const factory _JiraProject({required final String id, required final String key, required final String name}) =
      _$JiraProjectImpl;
  const _JiraProject._() : super._();

  factory _JiraProject.fromJson(Map<String, dynamic> json) = _$JiraProjectImpl.fromJson;

  @override
  String get id;
  @override
  String get key;
  @override
  String get name;

  /// Create a copy of JiraProject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JiraProjectImplCopyWith<_$JiraProjectImpl> get copyWith => throw _privateConstructorUsedError;
}

JiraStatus _$JiraStatusFromJson(Map<String, dynamic> json) {
  return _JiraStatus.fromJson(json);
}

/// @nodoc
mixin _$JiraStatus {
  String get name => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  /// Serializes this JiraStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JiraStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JiraStatusCopyWith<JiraStatus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JiraStatusCopyWith<$Res> {
  factory $JiraStatusCopyWith(JiraStatus value, $Res Function(JiraStatus) then) =
      _$JiraStatusCopyWithImpl<$Res, JiraStatus>;
  @useResult
  $Res call({String name, String color});
}

/// @nodoc
class _$JiraStatusCopyWithImpl<$Res, $Val extends JiraStatus> implements $JiraStatusCopyWith<$Res> {
  _$JiraStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JiraStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? color = null}) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            color:
                null == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JiraStatusImplCopyWith<$Res> implements $JiraStatusCopyWith<$Res> {
  factory _$$JiraStatusImplCopyWith(_$JiraStatusImpl value, $Res Function(_$JiraStatusImpl) then) =
      __$$JiraStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String color});
}

/// @nodoc
class __$$JiraStatusImplCopyWithImpl<$Res> extends _$JiraStatusCopyWithImpl<$Res, _$JiraStatusImpl>
    implements _$$JiraStatusImplCopyWith<$Res> {
  __$$JiraStatusImplCopyWithImpl(_$JiraStatusImpl _value, $Res Function(_$JiraStatusImpl) _then) : super(_value, _then);

  /// Create a copy of JiraStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? color = null}) {
    return _then(
      _$JiraStatusImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        color:
            null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JiraStatusImpl extends _JiraStatus {
  const _$JiraStatusImpl({required this.name, required this.color}) : super._();

  factory _$JiraStatusImpl.fromJson(Map<String, dynamic> json) => _$$JiraStatusImplFromJson(json);

  @override
  final String name;
  @override
  final String color;

  @override
  String toString() {
    return 'JiraStatus(name: $name, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JiraStatusImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, color);

  /// Create a copy of JiraStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JiraStatusImplCopyWith<_$JiraStatusImpl> get copyWith =>
      __$$JiraStatusImplCopyWithImpl<_$JiraStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JiraStatusImplToJson(this);
  }
}

abstract class _JiraStatus extends JiraStatus {
  const factory _JiraStatus({required final String name, required final String color}) = _$JiraStatusImpl;
  const _JiraStatus._() : super._();

  factory _JiraStatus.fromJson(Map<String, dynamic> json) = _$JiraStatusImpl.fromJson;

  @override
  String get name;
  @override
  String get color;

  /// Create a copy of JiraStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JiraStatusImplCopyWith<_$JiraStatusImpl> get copyWith => throw _privateConstructorUsedError;
}

JiraSettings _$JiraSettingsFromJson(Map<String, dynamic> json) {
  return _JiraSettings.fromJson(json);
}

/// @nodoc
mixin _$JiraSettings {
  String? get domain => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  bool get hasApiToken => throw _privateConstructorUsedError;
  List<String> get selectedProjectIds => throw _privateConstructorUsedError;
  @FirestoreNullableDateTimeConverter()
  DateTime? get lastSyncAt => throw _privateConstructorUsedError;
  int get lastSyncIssueCount => throw _privateConstructorUsedError;

  /// Serializes this JiraSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JiraSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JiraSettingsCopyWith<JiraSettings> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JiraSettingsCopyWith<$Res> {
  factory $JiraSettingsCopyWith(JiraSettings value, $Res Function(JiraSettings) then) =
      _$JiraSettingsCopyWithImpl<$Res, JiraSettings>;
  @useResult
  $Res call({
    String? domain,
    String? email,
    bool hasApiToken,
    List<String> selectedProjectIds,
    @FirestoreNullableDateTimeConverter() DateTime? lastSyncAt,
    int lastSyncIssueCount,
  });
}

/// @nodoc
class _$JiraSettingsCopyWithImpl<$Res, $Val extends JiraSettings> implements $JiraSettingsCopyWith<$Res> {
  _$JiraSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JiraSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = freezed,
    Object? email = freezed,
    Object? hasApiToken = null,
    Object? selectedProjectIds = null,
    Object? lastSyncAt = freezed,
    Object? lastSyncIssueCount = null,
  }) {
    return _then(
      _value.copyWith(
            domain:
                freezed == domain
                    ? _value.domain
                    : domain // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            hasApiToken:
                null == hasApiToken
                    ? _value.hasApiToken
                    : hasApiToken // ignore: cast_nullable_to_non_nullable
                        as bool,
            selectedProjectIds:
                null == selectedProjectIds
                    ? _value.selectedProjectIds
                    : selectedProjectIds // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            lastSyncAt:
                freezed == lastSyncAt
                    ? _value.lastSyncAt
                    : lastSyncAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastSyncIssueCount:
                null == lastSyncIssueCount
                    ? _value.lastSyncIssueCount
                    : lastSyncIssueCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JiraSettingsImplCopyWith<$Res> implements $JiraSettingsCopyWith<$Res> {
  factory _$$JiraSettingsImplCopyWith(_$JiraSettingsImpl value, $Res Function(_$JiraSettingsImpl) then) =
      __$$JiraSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? domain,
    String? email,
    bool hasApiToken,
    List<String> selectedProjectIds,
    @FirestoreNullableDateTimeConverter() DateTime? lastSyncAt,
    int lastSyncIssueCount,
  });
}

/// @nodoc
class __$$JiraSettingsImplCopyWithImpl<$Res> extends _$JiraSettingsCopyWithImpl<$Res, _$JiraSettingsImpl>
    implements _$$JiraSettingsImplCopyWith<$Res> {
  __$$JiraSettingsImplCopyWithImpl(_$JiraSettingsImpl _value, $Res Function(_$JiraSettingsImpl) _then)
    : super(_value, _then);

  /// Create a copy of JiraSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = freezed,
    Object? email = freezed,
    Object? hasApiToken = null,
    Object? selectedProjectIds = null,
    Object? lastSyncAt = freezed,
    Object? lastSyncIssueCount = null,
  }) {
    return _then(
      _$JiraSettingsImpl(
        domain:
            freezed == domain
                ? _value.domain
                : domain // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        hasApiToken:
            null == hasApiToken
                ? _value.hasApiToken
                : hasApiToken // ignore: cast_nullable_to_non_nullable
                    as bool,
        selectedProjectIds:
            null == selectedProjectIds
                ? _value._selectedProjectIds
                : selectedProjectIds // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        lastSyncAt:
            freezed == lastSyncAt
                ? _value.lastSyncAt
                : lastSyncAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastSyncIssueCount:
            null == lastSyncIssueCount
                ? _value.lastSyncIssueCount
                : lastSyncIssueCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JiraSettingsImpl extends _JiraSettings {
  const _$JiraSettingsImpl({
    this.domain,
    this.email,
    this.hasApiToken = false,
    final List<String> selectedProjectIds = const [],
    @FirestoreNullableDateTimeConverter() this.lastSyncAt,
    this.lastSyncIssueCount = 0,
  }) : _selectedProjectIds = selectedProjectIds,
       super._();

  factory _$JiraSettingsImpl.fromJson(Map<String, dynamic> json) => _$$JiraSettingsImplFromJson(json);

  @override
  final String? domain;
  @override
  final String? email;
  @override
  @JsonKey()
  final bool hasApiToken;
  final List<String> _selectedProjectIds;
  @override
  @JsonKey()
  List<String> get selectedProjectIds {
    if (_selectedProjectIds is EqualUnmodifiableListView) return _selectedProjectIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedProjectIds);
  }

  @override
  @FirestoreNullableDateTimeConverter()
  final DateTime? lastSyncAt;
  @override
  @JsonKey()
  final int lastSyncIssueCount;

  @override
  String toString() {
    return 'JiraSettings(domain: $domain, email: $email, hasApiToken: $hasApiToken, selectedProjectIds: $selectedProjectIds, lastSyncAt: $lastSyncAt, lastSyncIssueCount: $lastSyncIssueCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JiraSettingsImpl &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.hasApiToken, hasApiToken) || other.hasApiToken == hasApiToken) &&
            const DeepCollectionEquality().equals(other._selectedProjectIds, _selectedProjectIds) &&
            (identical(other.lastSyncAt, lastSyncAt) || other.lastSyncAt == lastSyncAt) &&
            (identical(other.lastSyncIssueCount, lastSyncIssueCount) ||
                other.lastSyncIssueCount == lastSyncIssueCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    domain,
    email,
    hasApiToken,
    const DeepCollectionEquality().hash(_selectedProjectIds),
    lastSyncAt,
    lastSyncIssueCount,
  );

  /// Create a copy of JiraSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JiraSettingsImplCopyWith<_$JiraSettingsImpl> get copyWith =>
      __$$JiraSettingsImplCopyWithImpl<_$JiraSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JiraSettingsImplToJson(this);
  }
}

abstract class _JiraSettings extends JiraSettings {
  const factory _JiraSettings({
    final String? domain,
    final String? email,
    final bool hasApiToken,
    final List<String> selectedProjectIds,
    @FirestoreNullableDateTimeConverter() final DateTime? lastSyncAt,
    final int lastSyncIssueCount,
  }) = _$JiraSettingsImpl;
  const _JiraSettings._() : super._();

  factory _JiraSettings.fromJson(Map<String, dynamic> json) = _$JiraSettingsImpl.fromJson;

  @override
  String? get domain;
  @override
  String? get email;
  @override
  bool get hasApiToken;
  @override
  List<String> get selectedProjectIds;
  @override
  @FirestoreNullableDateTimeConverter()
  DateTime? get lastSyncAt;
  @override
  int get lastSyncIssueCount;

  /// Create a copy of JiraSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JiraSettingsImplCopyWith<_$JiraSettingsImpl> get copyWith => throw _privateConstructorUsedError;
}
