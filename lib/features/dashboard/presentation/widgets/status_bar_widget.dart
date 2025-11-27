import 'package:flutter/material.dart';
import '../../../../design/tokens.dart';

class StatusBarWidget extends StatelessWidget {
  final int latencyMs;
  final String deviceName;

  const StatusBarWidget({
    super.key,
    required this.latencyMs,
    required this.deviceName,
  });

  Color get _qualityColor {
    if (latencyMs < 50) return Colors.green;
    if (latencyMs < 100) return Colors.yellow;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.space4,
        vertical: AppTokens.space3,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          // Connection indicator
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _qualityColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _qualityColor.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTokens.space2),
          Text(
            deviceName,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            '${latencyMs}ms',
            style: theme.textTheme.bodySmall?.copyWith(
              color: _qualityColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
