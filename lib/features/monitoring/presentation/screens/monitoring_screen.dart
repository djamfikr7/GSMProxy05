import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design/tokens.dart';
import '../../../../components/components.dart';

class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('System Monitoring')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.space4),
        child: Column(
          children: [
            // Top Row: Battery & RAM
            Row(
              children: [
                Expanded(
                  child: _StatusCard(
                    title: 'Battery',
                    icon: Icons.battery_charging_full_rounded,
                    color: Colors.green,
                    child: _CircularIndicator(
                      percentage: 0.85,
                      label: '85%',
                      subLabel: 'Charging',
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: AppTokens.space4),
                Expanded(
                  child: _StatusCard(
                    title: 'RAM Usage',
                    icon: Icons.memory_rounded,
                    color: Colors.orange,
                    child: _CircularIndicator(
                      percentage: 0.62,
                      label: '4.8 GB',
                      subLabel: 'of 8 GB',
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ).animate().slideY(begin: 0.1, end: 0, duration: 300.ms),

            const SizedBox(height: AppTokens.space4),

            // Storage Section
            _StatusCard(
              title: 'Storage',
              icon: Icons.storage_rounded,
              color: Colors.blue,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Used: 45 GB', style: theme.textTheme.bodyMedium),
                      Text('Total: 128 GB', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: AppTokens.space2),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppTokens.radiusFull),
                    child: LinearProgressIndicator(
                      value: 0.35,
                      minHeight: 12,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      valueColor: const AlwaysStoppedAnimation(Colors.blue),
                    ),
                  ),
                  const SizedBox(height: AppTokens.space3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StorageLegend(color: Colors.blue, label: 'Apps'),
                      _StorageLegend(color: Colors.purple, label: 'Media'),
                      _StorageLegend(color: Colors.orange, label: 'System'),
                      _StorageLegend(color: Colors.grey, label: 'Free'),
                    ],
                  ),
                ],
              ),
            ).animate().slideY(
              begin: 0.1,
              end: 0,
              duration: 300.ms,
              delay: 100.ms,
            ),

            const SizedBox(height: AppTokens.space4),

            // Signal Strength Graph
            _StatusCard(
              title: 'Signal Strength',
              icon: Icons.signal_cellular_alt_rounded,
              color: theme.colorScheme.primary,
              child: SizedBox(
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(12, (index) {
                    // Mock signal data
                    final height = 40 + (index * 5) % 60 + (index % 3) * 10;
                    return Container(
                      width: 12,
                      height: height.toDouble(),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ).animate().scaleY(
                      begin: 0,
                      end: 1,
                      duration: 400.ms,
                      delay: (index * 50).ms,
                      curve: Curves.easeOutBack,
                    );
                  }),
                ),
              ),
            ).animate().slideY(
              begin: 0.1,
              end: 0,
              duration: 300.ms,
              delay: 200.ms,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget child;

  const _StatusCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(AppTokens.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: AppTokens.space2),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space4),
          child,
        ],
      ),
    );
  }
}

class _CircularIndicator extends StatelessWidget {
  final double percentage;
  final String label;
  final String subLabel;
  final Color color;

  const _CircularIndicator({
    required this.percentage,
    required this.label,
    required this.subLabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              value: percentage,
              strokeWidth: 10,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(color),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                subLabel,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StorageLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _StorageLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
