import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_thread.freezed.dart';
part 'message_thread.g.dart';

@freezed
class MessageThread with _$MessageThread {
  const factory MessageThread({
    required String id,
    required String contactName,
    required String contactPhone,
    required String lastMessage,
    required DateTime lastMessageTime,
    @Default(0) int unreadCount,
    @Default(false) bool isArchived,
  }) = _MessageThread;

  factory MessageThread.fromJson(Map<String, dynamic> json) =>
      _$MessageThreadFromJson(json);
}
