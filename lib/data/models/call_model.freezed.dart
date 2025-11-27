// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CallModel _$CallModelFromJson(Map<String, dynamic> json) {
  return _CallModel.fromJson(json);
}

/// @nodoc
mixin _$CallModel {
  String get id => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String? get contactName => throw _privateConstructorUsedError;
  CallDirection get direction => throw _privateConstructorUsedError;
  CallStatus get status => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  String? get recordingPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallModelCopyWith<CallModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallModelCopyWith<$Res> {
  factory $CallModelCopyWith(CallModel value, $Res Function(CallModel) then) =
      _$CallModelCopyWithImpl<$Res, CallModel>;
  @useResult
  $Res call(
      {String id,
      String deviceId,
      String number,
      String? contactName,
      CallDirection direction,
      CallStatus status,
      DateTime timestamp,
      int durationSeconds,
      String? recordingPath});
}

/// @nodoc
class _$CallModelCopyWithImpl<$Res, $Val extends CallModel>
    implements $CallModelCopyWith<$Res> {
  _$CallModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? number = null,
    Object? contactName = freezed,
    Object? direction = null,
    Object? status = null,
    Object? timestamp = null,
    Object? durationSeconds = null,
    Object? recordingPath = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      contactName: freezed == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as CallDirection,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CallStatus,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      recordingPath: freezed == recordingPath
          ? _value.recordingPath
          : recordingPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallModelImplCopyWith<$Res>
    implements $CallModelCopyWith<$Res> {
  factory _$$CallModelImplCopyWith(
          _$CallModelImpl value, $Res Function(_$CallModelImpl) then) =
      __$$CallModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String deviceId,
      String number,
      String? contactName,
      CallDirection direction,
      CallStatus status,
      DateTime timestamp,
      int durationSeconds,
      String? recordingPath});
}

/// @nodoc
class __$$CallModelImplCopyWithImpl<$Res>
    extends _$CallModelCopyWithImpl<$Res, _$CallModelImpl>
    implements _$$CallModelImplCopyWith<$Res> {
  __$$CallModelImplCopyWithImpl(
      _$CallModelImpl _value, $Res Function(_$CallModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? number = null,
    Object? contactName = freezed,
    Object? direction = null,
    Object? status = null,
    Object? timestamp = null,
    Object? durationSeconds = null,
    Object? recordingPath = freezed,
  }) {
    return _then(_$CallModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      contactName: freezed == contactName
          ? _value.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as CallDirection,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CallStatus,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      recordingPath: freezed == recordingPath
          ? _value.recordingPath
          : recordingPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallModelImpl implements _CallModel {
  const _$CallModelImpl(
      {required this.id,
      required this.deviceId,
      required this.number,
      this.contactName,
      required this.direction,
      required this.status,
      required this.timestamp,
      this.durationSeconds = 0,
      this.recordingPath});

  factory _$CallModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallModelImplFromJson(json);

  @override
  final String id;
  @override
  final String deviceId;
  @override
  final String number;
  @override
  final String? contactName;
  @override
  final CallDirection direction;
  @override
  final CallStatus status;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final int durationSeconds;
  @override
  final String? recordingPath;

  @override
  String toString() {
    return 'CallModel(id: $id, deviceId: $deviceId, number: $number, contactName: $contactName, direction: $direction, status: $status, timestamp: $timestamp, durationSeconds: $durationSeconds, recordingPath: $recordingPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.recordingPath, recordingPath) ||
                other.recordingPath == recordingPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      deviceId,
      number,
      contactName,
      direction,
      status,
      timestamp,
      durationSeconds,
      recordingPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallModelImplCopyWith<_$CallModelImpl> get copyWith =>
      __$$CallModelImplCopyWithImpl<_$CallModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallModelImplToJson(
      this,
    );
  }
}

abstract class _CallModel implements CallModel {
  const factory _CallModel(
      {required final String id,
      required final String deviceId,
      required final String number,
      final String? contactName,
      required final CallDirection direction,
      required final CallStatus status,
      required final DateTime timestamp,
      final int durationSeconds,
      final String? recordingPath}) = _$CallModelImpl;

  factory _CallModel.fromJson(Map<String, dynamic> json) =
      _$CallModelImpl.fromJson;

  @override
  String get id;
  @override
  String get deviceId;
  @override
  String get number;
  @override
  String? get contactName;
  @override
  CallDirection get direction;
  @override
  CallStatus get status;
  @override
  DateTime get timestamp;
  @override
  int get durationSeconds;
  @override
  String? get recordingPath;
  @override
  @JsonKey(ignore: true)
  _$$CallModelImplCopyWith<_$CallModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
