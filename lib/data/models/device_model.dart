import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/enums.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    required String id,
    required String name,
    required String model,
    required String manufacturer,
    required String androidVersion,
    required int sdkVersion,
    @Default(DeviceStatus.offline) DeviceStatus status,
    @Default(0) int batteryLevel,
    @Default(false) bool isCharging,
    @Default(0) int signalStrength,
    String? operatorName,
    String? phoneNumber,
    DateTime? lastSeen,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
}
