import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/enums.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String deviceId,
    required String address, // Phone number or sender ID
    String? contactName,
    required String body,
    required MessageDirection direction,
    required MessageStatus status,
    required DateTime timestamp,
    @Default(false) bool isRead,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
