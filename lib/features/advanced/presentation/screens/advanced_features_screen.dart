import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design/tokens.dart';
import '../../../../components/components.dart';
import '../../../sim/presentation/screens/sim_management_screen.dart';
import '../../../monitoring/presentation/screens/monitoring_screen.dart';
import '../../../ussd/presentation/screens/ussd_screen.dart';
import '../../../call_recording/presentation/screens/call_recording_screen.dart';

class AdvancedFeaturesScreen extends StatelessWidget {
  const AdvancedFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final features = [
      _FeatureItem(
        title: 'SIM Management',
        description: 'Configure dual-SIM settings and preferences',
        icon: Icons.sim_card_rounded,
        color: Colors.orange,
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SimManagementScreen(),
            ),
          );
        },
      ),
      _FeatureItem(
        title: 'System Monitoring',
        description: 'Real-time battery, storage, and network stats',
        icon: Icons.monitor_heart_rounded,
        color: Colors.blue,
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MonitoringScreen()),
          );
        },
      ),
      _FeatureItem(
        title: 'USSD Codes',
        description: 'Execute carrier codes and check balances',
        icon: Icons.dialpad_rounded,
        color: Colors.green,
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UssdScreen()),
          );
        },
      ),
      _FeatureItem(
        title: 'Call Recording',
        description: 'Manage call recordings and legal settings',
        icon: Icons.mic_rounded,
        color: Colors.red,
        isWarning: true,
        onTap: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CallRecordingScreen(),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Advanced Features'),
            centerTitle: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppTokens.space4),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisSpacing: AppTokens.space4,
                crossAxisSpacing: AppTokens.space4,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final feature = features[index];
                return _FeatureCard(feature: feature)
                    .animate()
                    .fadeIn(duration: 300.ms, delay: (100 * index).ms)
                    .slideY(begin: 0.2, end: 0);
              }, childCount: features.length),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isWarning;
  final Function(BuildContext) onTap;

  _FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isWarning = false,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      onTap: () => feature.onTap(context),
      padding: const EdgeInsets.all(AppTokens.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTokens.space3),
                decoration: BoxDecoration(
                  color: feature.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTokens.radiusMd),
                ),
                child: Icon(feature.icon, color: feature.color, size: 32),
              ),
              if (feature.isWarning)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTokens.space2,
                    vertical: AppTokens.space1,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 14,
                        color: theme.colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'SENSITIVE',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            feature.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTokens.space2),
          Text(
            feature.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
