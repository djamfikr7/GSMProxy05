// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CallModelImpl _$$CallModelImplFromJson(Map<String, dynamic> json) =>
    _$CallModelImpl(
      id: json['id'] as String,
      deviceId: json['deviceId'] as String,
      number: json['number'] as String,
      contactName: json['contactName'] as String?,
      direction: $enumDecode(_$CallDirectionEnumMap, json['direction']),
      status: $enumDecode(_$CallStatusEnumMap, json['status']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
      recordingPath: json['recordingPath'] as String?,
    );

Map<String, dynamic> _$$CallModelImplToJson(_$CallModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'number': instance.number,
      'contactName': instance.contactName,
      'direction': _$CallDirectionEnumMap[instance.direction]!,
      'status': _$CallStatusEnumMap[instance.status]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'recordingPath': instance.recordingPath,
    };

const _$CallDirectionEnumMap = {
  CallDirection.inbound: 'inbound',
  CallDirection.outbound: 'outbound',
};

const _$CallStatusEnumMap = {
  CallStatus.incoming: 'incoming',
  CallStatus.outgoing: 'outgoing',
  CallStatus.missed: 'missed',
  CallStatus.rejected: 'rejected',
  CallStatus.accepted: 'accepted',
  CallStatus.ended: 'ended',
};
