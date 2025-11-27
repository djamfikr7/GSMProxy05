import 'package:flutter/material.dart';
import '../../../../design/tokens.dart';
import '../../../../components/components.dart';
import 'dialer_screen.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock Data
    final calls = [
      _CallLogItem(
        name: 'Sarah Miller',
        number: '(555) 123-4567',
        time: '10:30 AM',
        type: CallType.incoming,
        duration: '5m 23s',
      ),
      _CallLogItem(
        name: 'John Doe',
        number: '(555) 987-6543',
        time: 'Yesterday',
        type: CallType.missed,
      ),
      _CallLogItem(
        name: 'Mom',
        number: '(555) 555-5555',
        time: 'Yesterday',
        type: CallType.outgoing,
        duration: '12m 45s',
      ),
      _CallLogItem(
        name: 'Unknown',
        number: '(555) 000-0000',
        time: 'Monday',
        type: CallType.missed,
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Recents'),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppTokens.space4),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final call = calls[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTokens.space3),
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        // Icon based on call type
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: call.type == CallType.missed
                                ? theme.colorScheme.errorContainer
                                : theme.colorScheme.surfaceContainerHighest,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            call.type == CallType.missed
                                ? Icons.call_missed_rounded
                                : call.type == CallType.incoming
                                ? Icons.call_received_rounded
                                : Icons.call_made_rounded,
                            color: call.type == CallType.missed
                                ? theme.colorScheme.error
                                : theme.colorScheme.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                call.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: call.type == CallType.missed
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    call.type == CallType.missed
                                        ? 'Missed'
                                        : call.duration ?? 'Cancelled',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '•',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    call.time,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Call Button
                        IconButton(
                          icon: const Icon(Icons.call_outlined),
                          onPressed: () {
                            // Navigate to dialer with number pre-filled
                            // For now just push dialer
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const DialerScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: calls.length),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const DialerScreen()));
        },
        icon: const Icon(Icons.dialpad_rounded),
        label: const Text('Keypad'),
      ),
    );
  }
}

enum CallType { incoming, outgoing, missed }

class _CallLogItem {
  final String name;
  final String number;
  final String time;
  final CallType type;
  final String? duration;

  _CallLogItem({
    required this.name,
    required this.number,
    required this.time,
    required this.type,
    this.duration,
  });
}
