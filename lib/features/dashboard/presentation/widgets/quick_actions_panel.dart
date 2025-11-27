import 'package:flutter/material.dart';
import '../../../../components/components.dart';
import '../../../../design/tokens.dart';

class QuickActionsPanel extends StatelessWidget {
  final VoidCallback? onCallTap;
  final VoidCallback? onScreenTap;

  const QuickActionsPanel({super.key, this.onCallTap, this.onScreenTap});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppTokens.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppTokens.space3),
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.call_rounded,
                  label: 'Call',
                  onTap: onCallTap ?? () {},
                ),
              ),
              const SizedBox(width: AppTokens.space3),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.message_rounded,
                  label: 'Message',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppTokens.space3),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.screenshot_monitor_rounded,
                  label: 'Screen',
                  onTap: onScreenTap ?? () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppTokens.space3),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(height: AppTokens.space1),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
