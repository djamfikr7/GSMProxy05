// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageThreadImpl _$$MessageThreadImplFromJson(Map<String, dynamic> json) =>
    _$MessageThreadImpl(
      id: json['id'] as String,
      contactName: json['contactName'] as String,
      contactPhone: json['contactPhone'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: DateTime.parse(json['lastMessageTime'] as String),
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      isArchived: json['isArchived'] as bool? ?? false,
    );

Map<String, dynamic> _$$MessageThreadImplToJson(_$MessageThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contactName': instance.contactName,
      'contactPhone': instance.contactPhone,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime.toIso8601String(),
      'unreadCount': instance.unreadCount,
      'isArchived': instance.isArchived,
    };
