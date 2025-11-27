import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

enum MessageStatus { sending, sent, delivered, read, failed }

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String threadId,
    required String content,
    required DateTime timestamp,
    required bool isOutgoing,
    @Default(MessageStatus.sent) MessageStatus status,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
