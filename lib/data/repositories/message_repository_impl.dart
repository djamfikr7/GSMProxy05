import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/remote/api_service.dart';
import '../models/message_model.dart';

part 'message_repository_impl.g.dart';

class MessageRepositoryImpl implements MessageRepository {
  final ApiService _apiService;

  MessageRepositoryImpl(this._apiService);

  @override
  Future<List<MessageModel>> getMessages(
    String threadId, {
    int limit = 50,
    int offset = 0,
  }) {
    return _apiService.getMessages(threadId, limit, offset);
  }

  @override
  Future<List<MessageModel>> getThreads({int limit = 20, int offset = 0}) {
    return _apiService.getThreads(limit, offset);
  }

  @override
  Future<void> sendMessage(String address, String body) {
    return _apiService.sendMessage({'address': address, 'body': body});
  }

  @override
  Future<void> markAsRead(String messageId) {
    // TODO: Implement mark as read
    return Future.value();
  }

  @override
  Stream<MessageModel> get incomingMessages {
    // TODO: Implement WebSocket stream for incoming messages
    return const Stream.empty();
  }
}

@Riverpod(keepAlive: true)
MessageRepository messageRepository(MessageRepositoryRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return MessageRepositoryImpl(apiService);
}
