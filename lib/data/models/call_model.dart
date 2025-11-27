import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/enums.dart';

part 'call_model.freezed.dart';
part 'call_model.g.dart';

@freezed
class CallModel with _$CallModel {
  const factory CallModel({
    required String id,
    required String deviceId,
    required String number,
    String? contactName,
    required CallDirection direction,
    required CallStatus status,
    required DateTime timestamp,
    @Default(0) int durationSeconds,
    String? recordingPath,
  }) = _CallModel;

  factory CallModel.fromJson(Map<String, dynamic> json) =>
      _$CallModelFromJson(json);
}
