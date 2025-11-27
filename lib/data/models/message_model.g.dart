// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String,
      deviceId: json['deviceId'] as String,
      address: json['address'] as String,
      contactName: json['contactName'] as String?,
      body: json['body'] as String,
      direction: $enumDecode(_$MessageDirectionEnumMap, json['direction']),
      status: $enumDecode(_$MessageStatusEnumMap, json['status']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'address': instance.address,
      'contactName': instance.contactName,
      'body': instance.body,
      'direction': _$MessageDirectionEnumMap[instance.direction]!,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'isRead': instance.isRead,
    };

const _$MessageDirectionEnumMap = {
  MessageDirection.inbound: 'inbound',
  MessageDirection.outbound: 'outbound',
};

const _$MessageStatusEnumMap = {
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.read: 'read',
  MessageStatus.failed: 'failed',
};
