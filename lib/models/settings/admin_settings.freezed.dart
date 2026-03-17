// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminSettings _$AdminSettingsFromJson(Map<String, dynamic> json) {
  return _AdminSettings.fromJson(json);
}

/// @nodoc
mixin _$AdminSettings {
  /// Default hourly rate in PLN for budget calculations
  double get defaultHourlyRate => throw _privateConstructorUsedError;

  /// Serializes this AdminSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminSettingsCopyWith<AdminSettings> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminSettingsCopyWith<$Res> {
  factory $AdminSettingsCopyWith(AdminSettings value, $Res Function(AdminSettings) then) =
      _$AdminSettingsCopyWithImpl<$Res, AdminSettings>;
  @useResult
  $Res call({double defaultHourlyRate});
}

/// @nodoc
class _$AdminSettingsCopyWithImpl<$Res, $Val extends AdminSettings> implements $AdminSettingsCopyWith<$Res> {
  _$AdminSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? defaultHourlyRate = null}) {
    return _then(
      _value.copyWith(
            defaultHourlyRate:
                null == defaultHourlyRate
                    ? _value.defaultHourlyRate
                    : defaultHourlyRate // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminSettingsImplCopyWith<$Res> implements $AdminSettingsCopyWith<$Res> {
  factory _$$AdminSettingsImplCopyWith(_$AdminSettingsImpl value, $Res Function(_$AdminSettingsImpl) then) =
      __$$AdminSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double defaultHourlyRate});
}

/// @nodoc
class __$$AdminSettingsImplCopyWithImpl<$Res> extends _$AdminSettingsCopyWithImpl<$Res, _$AdminSettingsImpl>
    implements _$$AdminSettingsImplCopyWith<$Res> {
  __$$AdminSettingsImplCopyWithImpl(_$AdminSettingsImpl _value, $Res Function(_$AdminSettingsImpl) _then)
    : super(_value, _then);

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? defaultHourlyRate = null}) {
    return _then(
      _$AdminSettingsImpl(
        defaultHourlyRate:
            null == defaultHourlyRate
                ? _value.defaultHourlyRate
                : defaultHourlyRate // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminSettingsImpl extends _AdminSettings {
  const _$AdminSettingsImpl({this.defaultHourlyRate = 50.0}) : super._();

  factory _$AdminSettingsImpl.fromJson(Map<String, dynamic> json) => _$$AdminSettingsImplFromJson(json);

  /// Default hourly rate in PLN for budget calculations
  @override
  @JsonKey()
  final double defaultHourlyRate;

  @override
  String toString() {
    return 'AdminSettings(defaultHourlyRate: $defaultHourlyRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSettingsImpl &&
            (identical(other.defaultHourlyRate, defaultHourlyRate) || other.defaultHourlyRate == defaultHourlyRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, defaultHourlyRate);

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminSettingsImplCopyWith<_$AdminSettingsImpl> get copyWith =>
      __$$AdminSettingsImplCopyWithImpl<_$AdminSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminSettingsImplToJson(this);
  }
}

abstract class _AdminSettings extends AdminSettings {
  const factory _AdminSettings({final double defaultHourlyRate}) = _$AdminSettingsImpl;
  const _AdminSettings._() : super._();

  factory _AdminSettings.fromJson(Map<String, dynamic> json) = _$AdminSettingsImpl.fromJson;

  /// Default hourly rate in PLN for budget calculations
  @override
  double get defaultHourlyRate;

  /// Create a copy of AdminSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminSettingsImplCopyWith<_$AdminSettingsImpl> get copyWith => throw _privateConstructorUsedError;
}
