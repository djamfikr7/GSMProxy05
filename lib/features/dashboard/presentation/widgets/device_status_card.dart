import 'package:flutter/material.dart';
import '../../../../components/components.dart';
import '../../../../design/tokens.dart';
import '../../../../data/models/device_model.dart';
import '../../../../core/enums.dart';

class DeviceStatusCard extends StatelessWidget {
  final DeviceModel device;
  final VoidCallback? onTap;

  const DeviceStatusCard({super.key, required this.device, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(AppTokens.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.phone_android_rounded,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: AppTokens.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        device.model,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status indicator
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTokens.space2,
                    vertical: AppTokens.space1,
                  ),
                  decoration: BoxDecoration(
                    color: device.status == DeviceStatus.online
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                  ),
                  child: Text(
                    device.status == DeviceStatus.online ? 'Online' : 'Offline',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: device.status == DeviceStatus.online
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.space4),

            // Stats
            Row(
              children: [
                _StatItem(
                  icon: Icons.battery_std_rounded,
                  label: '${device.batteryLevel}%',
                  color: device.batteryLevel > 20 ? Colors.green : Colors.red,
                ),
                const SizedBox(width: AppTokens.space4),
                _StatItem(
                  icon: Icons.signal_cellular_alt_rounded,
                  label: '${device.signalStrength}/5',
                  color: Colors.blue,
                ),
                const SizedBox(width: AppTokens.space4),
                Expanded(
                  child: Text(
                    device.operatorName ?? 'Unknown Operator',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }
}
