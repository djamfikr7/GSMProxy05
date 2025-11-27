// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceModelImpl _$$DeviceModelImplFromJson(Map<String, dynamic> json) =>
    _$DeviceModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      model: json['model'] as String,
      manufacturer: json['manufacturer'] as String,
      androidVersion: json['androidVersion'] as String,
      sdkVersion: (json['sdkVersion'] as num).toInt(),
      status: $enumDecodeNullable(_$DeviceStatusEnumMap, json['status']) ??
          DeviceStatus.offline,
      batteryLevel: (json['batteryLevel'] as num?)?.toInt() ?? 0,
      isCharging: json['isCharging'] as bool? ?? false,
      signalStrength: (json['signalStrength'] as num?)?.toInt() ?? 0,
      operatorName: json['operatorName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
    );

Map<String, dynamic> _$$DeviceModelImplToJson(_$DeviceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'manufacturer': instance.manufacturer,
      'androidVersion': instance.androidVersion,
      'sdkVersion': instance.sdkVersion,
      'status': _$DeviceStatusEnumMap[instance.status]!,
      'batteryLevel': instance.batteryLevel,
      'isCharging': instance.isCharging,
      'signalStrength': instance.signalStrength,
      'operatorName': instance.operatorName,
      'phoneNumber': instance.phoneNumber,
      'lastSeen': instance.lastSeen?.toIso8601String(),
    };

const _$DeviceStatusEnumMap = {
  DeviceStatus.online: 'online',
  DeviceStatus.offline: 'offline',
  DeviceStatus.busy: 'busy',
  DeviceStatus.error: 'error',
};
