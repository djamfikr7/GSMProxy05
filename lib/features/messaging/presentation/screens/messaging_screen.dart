import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../design/tokens.dart';
import '../../../../components/components.dart';
import '../../data/messaging_providers.dart';
import '../widgets/thread_list_item.dart';
import 'chat_screen.dart';

class MessagingScreen extends ConsumerStatefulWidget {
  const MessagingScreen({super.key});

  @override
  ConsumerState<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends ConsumerState<MessagingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final threads = ref.watch(messageThreadsProvider);
    final filteredThreads = _searchQuery.isEmpty
        ? threads
        : threads.where((thread) {
            final name = thread.contactName.toLowerCase();
            final phone = thread.contactPhone.toLowerCase();
            final message = thread.lastMessage.toLowerCase();
            final query = _searchQuery.toLowerCase();
            return name.contains(query) ||
                phone.contains(query) ||
                message.contains(query);
          }).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: _isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Search messages...',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  )
                : const Text('Messages'),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(
                  _isSearching ? Icons.close_rounded : Icons.search_rounded,
                ),
                onPressed: () {
                  setState(() {
                    if (_isSearching) {
                      _isSearching = false;
                      _searchQuery = '';
                      _searchController.clear();
                    } else {
                      _isSearching = true;
                    }
                  });
                },
              ),
              if (!_isSearching)
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () {},
                ),
            ],
          ),
          filteredThreads.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTokens.space6),
                      child: Text(
                        _searchQuery.isEmpty
                            ? 'No messages yet'
                            : 'No messages found',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(AppTokens.space4),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final thread = filteredThreads[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppTokens.space2,
                        ),
                        child: ThreadListItem(
                          thread: thread,
                          onTap: () {
                            ref.read(selectedThreadProvider.notifier).state =
                                thread;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(thread: thread),
                              ),
                            );
                          },
                        ),
                      );
                    }, childCount: filteredThreads.length),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to contacts to start new conversation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Select a contact to start messaging'),
            ),
          );
        },
        icon: const Icon(Icons.edit_rounded),
        label: const Text('New Message'),
      ),
    );
  }
}
