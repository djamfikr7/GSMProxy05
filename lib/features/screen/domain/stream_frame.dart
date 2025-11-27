import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_frame.freezed.dart';

@freezed
class StreamFrame with _$StreamFrame {
  const factory StreamFrame({
    required Uint8List bytes,
    required DateTime timestamp,
    @Default(0) int width,
    @Default(0) int height,
  }) = _StreamFrame;
}
