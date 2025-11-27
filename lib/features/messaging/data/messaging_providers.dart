import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/message.dart';
import '../domain/message_thread.dart';

part 'messaging_providers.g.dart';

// Mock data for message threads
@riverpod
List<MessageThread> messageThreads(MessageThreadsRef ref) {
  return [
    MessageThread(
      id: '1',
      contactName: 'Alice Johnson',
      contactPhone: '(555) 123-4567',
      lastMessage: 'See you tomorrow!',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
    ),
    MessageThread(
      id: '2',
      contactName: 'Bob Smith',
      contactPhone: '(555) 987-6543',
      lastMessage: 'Thanks for your help 👍',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 0,
    ),
    MessageThread(
      id: '3',
      contactName: 'Charlie Brown',
      contactPhone: '(555) 246-8135',
      lastMessage: 'Did you get my email?',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 1,
    ),
    MessageThread(
      id: '4',
      contactName: 'David Wilson',
      contactPhone: '(555) 135-7924',
      lastMessage: 'Great! Let me know when you\'re free',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
    ),
    MessageThread(
      id: '5',
      contactName: 'Eve Anderson',
      contactPhone: '(555) 864-2097',
      lastMessage: 'I\'ll send the files tonight',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
    ),
  ];
}

// Mock data for messages in a thread
@riverpod
List<Message> messages(MessagesRef ref, String threadId) {
  // Generate mock messages based on thread ID
  final baseMessages = [
    Message(
      id: '1',
      threadId: threadId,
      content: 'Hey! How are you doing?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isOutgoing: false,
      status: MessageStatus.read,
    ),
    Message(
      id: '2',
      threadId: threadId,
      content: 'I\'m doing great, thanks! How about you?',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
      isOutgoing: true,
      status: MessageStatus.read,
    ),
    Message(
      id: '3',
      threadId: threadId,
      content: 'Pretty good! Are we still on for tomorrow?',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
      isOutgoing: false,
      status: MessageStatus.read,
    ),
    Message(
      id: '4',
      threadId: threadId,
      content: 'Yes! See you at 3pm',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      isOutgoing: true,
      status: MessageStatus.read,
    ),
    Message(
      id: '5',
      threadId: threadId,
      content: 'Perfect! Looking forward to it 😊',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      isOutgoing: false,
      status: MessageStatus.read,
    ),
    Message(
      id: '6',
      threadId: threadId,
      content: 'Me too! See you tomorrow!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isOutgoing: true,
      status: MessageStatus.delivered,
    ),
  ];

  return baseMessages;
}

// Selected thread provider
final selectedThreadProvider = StateProvider<MessageThread?>((ref) => null);
