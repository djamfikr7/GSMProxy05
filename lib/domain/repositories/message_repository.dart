import '../../data/models/message_model.dart';

abstract class MessageRepository {
  Future<List<MessageModel>> getMessages(
    String threadId, {
    int limit = 50,
    int offset = 0,
  });
  Future<List<MessageModel>> getThreads({int limit = 20, int offset = 0});
  Future<void> sendMessage(String address, String body);
  Future<void> markAsRead(String messageId);
  Stream<MessageModel> get incomingMessages;
}
