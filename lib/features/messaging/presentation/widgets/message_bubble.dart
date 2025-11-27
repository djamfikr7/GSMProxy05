import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../design/tokens.dart';
import '../../domain/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  Widget _buildStatusIcon(BuildContext context, MessageStatus status) {
    final theme = Theme.of(context);
    IconData icon;
    Color color;

    switch (status) {
      case MessageStatus.sending:
        return SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
          ),
        );
      case MessageStatus.sent:
        icon = Icons.check_rounded;
        color = theme.colorScheme.onPrimaryContainer.withOpacity(0.6);
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all_rounded;
        color = theme.colorScheme.onPrimaryContainer.withOpacity(0.6);
        break;
      case MessageStatus.read:
        icon = Icons.done_all_rounded;
        color = Colors.blue;
        break;
      case MessageStatus.failed:
        icon = Icons.error_outline_rounded;
        color = Colors.red;
        break;
    }

    return Icon(icon, size: 14, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOutgoing = message.isOutgoing;
    final time = DateFormat('HH:mm').format(message.timestamp);

    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child:
            Container(
                  margin: EdgeInsets.only(
                    left: isOutgoing ? 48 : 0,
                    right: isOutgoing ? 0 : 48,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTokens.space4,
                    vertical: AppTokens.space3,
                  ),
                  decoration: BoxDecoration(
                    color: isOutgoing
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(AppTokens.radiusLg),
                      topRight: const Radius.circular(AppTokens.radiusLg),
                      bottomLeft: Radius.circular(
                        isOutgoing ? AppTokens.radiusLg : AppTokens.radiusSm,
                      ),
                      bottomRight: Radius.circular(
                        isOutgoing ? AppTokens.radiusSm : AppTokens.radiusLg,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: isOutgoing
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: AppTokens.space1),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            time,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isOutgoing
                                  ? theme.colorScheme.onPrimary.withOpacity(0.7)
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (isOutgoing) ...[
                            const SizedBox(width: AppTokens.space1),
                            _buildStatusIcon(context, message.status),
                          ],
                        ],
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 200.ms)
                .slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 200.ms,
                  curve: Curves.easeOut,
                ),
      ),
    );
  }
}
