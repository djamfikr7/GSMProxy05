// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stream_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StreamFrame {
  Uint8List get bytes => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StreamFrameCopyWith<StreamFrame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamFrameCopyWith<$Res> {
  factory $StreamFrameCopyWith(
          StreamFrame value, $Res Function(StreamFrame) then) =
      _$StreamFrameCopyWithImpl<$Res, StreamFrame>;
  @useResult
  $Res call({Uint8List bytes, DateTime timestamp, int width, int height});
}

/// @nodoc
class _$StreamFrameCopyWithImpl<$Res, $Val extends StreamFrame>
    implements $StreamFrameCopyWith<$Res> {
  _$StreamFrameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytes = null,
    Object? timestamp = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_value.copyWith(
      bytes: null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamFrameImplCopyWith<$Res>
    implements $StreamFrameCopyWith<$Res> {
  factory _$$StreamFrameImplCopyWith(
          _$StreamFrameImpl value, $Res Function(_$StreamFrameImpl) then) =
      __$$StreamFrameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uint8List bytes, DateTime timestamp, int width, int height});
}

/// @nodoc
class __$$StreamFrameImplCopyWithImpl<$Res>
    extends _$StreamFrameCopyWithImpl<$Res, _$StreamFrameImpl>
    implements _$$StreamFrameImplCopyWith<$Res> {
  __$$StreamFrameImplCopyWithImpl(
      _$StreamFrameImpl _value, $Res Function(_$StreamFrameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytes = null,
    Object? timestamp = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_$StreamFrameImpl(
      bytes: null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$StreamFrameImpl implements _StreamFrame {
  const _$StreamFrameImpl(
      {required this.bytes,
      required this.timestamp,
      this.width = 0,
      this.height = 0});

  @override
  final Uint8List bytes;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final int width;
  @override
  @JsonKey()
  final int height;

  @override
  String toString() {
    return 'StreamFrame(bytes: $bytes, timestamp: $timestamp, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamFrameImpl &&
            const DeepCollectionEquality().equals(other.bytes, bytes) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(bytes), timestamp, width, height);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamFrameImplCopyWith<_$StreamFrameImpl> get copyWith =>
      __$$StreamFrameImplCopyWithImpl<_$StreamFrameImpl>(this, _$identity);
}

abstract class _StreamFrame implements StreamFrame {
  const factory _StreamFrame(
      {required final Uint8List bytes,
      required final DateTime timestamp,
      final int width,
      final int height}) = _$StreamFrameImpl;

  @override
  Uint8List get bytes;
  @override
  DateTime get timestamp;
  @override
  int get width;
  @override
  int get height;
  @override
  @JsonKey(ignore: true)
  _$$StreamFrameImplCopyWith<_$StreamFrameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
