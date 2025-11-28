import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design/tokens.dart';
import '../../../../components/components.dart';

class SimManagementScreen extends StatefulWidget {
  const SimManagementScreen({super.key});

  @override
  State<SimManagementScreen> createState() => _SimManagementScreenState();
}

class _SimManagementScreenState extends State<SimManagementScreen> {
  // Mock State
  bool _sim1Enabled = true;
  bool _sim2Enabled = true;
  int _defaultDataSim = 0; // 0 for SIM 1, 1 for SIM 2
  int _defaultCallSim = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('SIM Management')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SIM Cards',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppTokens.space4),

            // SIM 1 Card
            _SimCardWidget(
              slotNumber: 1,
              carrierName: 'Verizon',
              phoneNumber: '+1 (555) 123-4567',
              networkType: '5G UW',
              isEnabled: _sim1Enabled,
              color: Colors.redAccent,
              onToggle: (value) => setState(() => _sim1Enabled = value),
            ).animate().slideX(begin: -0.1, end: 0, duration: 300.ms),

            const SizedBox(height: AppTokens.space4),

            // SIM 2 Card
            _SimCardWidget(
              slotNumber: 2,
              carrierName: 'T-Mobile',
              phoneNumber: '+1 (555) 987-6543',
              networkType: '5G',
              isEnabled: _sim2Enabled,
              color: Colors.purpleAccent,
              onToggle: (value) => setState(() => _sim2Enabled = value),
            ).animate().slideX(
              begin: 0.1,
              end: 0,
              duration: 300.ms,
              delay: 100.ms,
            ),

            const SizedBox(height: AppTokens.space6),

            Text(
              'Preferences',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppTokens.space4),

            GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _PreferenceTile(
                    title: 'Mobile Data',
                    subtitle: _defaultDataSim == 0
                        ? 'SIM 1 (Verizon)'
                        : 'SIM 2 (T-Mobile)',
                    icon: Icons.data_usage_rounded,
                    value: _defaultDataSim,
                    onChanged: (value) =>
                        setState(() => _defaultDataSim = value!),
                  ),
                  Divider(
                    height: 1,
                    color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                  _PreferenceTile(
                    title: 'Calls & SMS',
                    subtitle: _defaultCallSim == 0
                        ? 'SIM 1 (Verizon)'
                        : 'SIM 2 (T-Mobile)',
                    icon: Icons.call_rounded,
                    value: _defaultCallSim,
                    onChanged: (value) =>
                        setState(() => _defaultCallSim = value!),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }
}

class _SimCardWidget extends StatelessWidget {
  final int slotNumber;
  final String carrierName;
  final String phoneNumber;
  final String networkType;
  final bool isEnabled;
  final Color color;
  final ValueChanged<bool> onToggle;

  const _SimCardWidget({
    required this.slotNumber,
    required this.carrierName,
    required this.phoneNumber,
    required this.networkType,
    required this.isEnabled,
    required this.color,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.6,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Stack(
          children: [
            // Circuit pattern decoration (optional, using simple shapes)
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.sim_card_rounded,
                size: 150,
                color: color.withOpacity(0.05),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppTokens.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTokens.space2,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(
                            AppTokens.radiusSm,
                          ),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Text(
                          'SIM $slotNumber',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Switch(
                        value: isEnabled,
                        onChanged: onToggle,
                        activeColor: color,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTokens.space2),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_alt_rounded, color: color),
                      const SizedBox(width: AppTokens.space2),
                      Text(
                        carrierName,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: AppTokens.space2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTokens.space2,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(
                            AppTokens.radiusSm,
                          ),
                        ),
                        child: Text(
                          networkType,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTokens.space1),
                  Text(
                    phoneNumber,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final int value;
  final ValueChanged<int?> onChanged;

  const _PreferenceTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppTokens.space2),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        ),
        child: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          onChanged: onChanged,
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          items: const [
            DropdownMenuItem(value: 0, child: Text('SIM 1')),
            DropdownMenuItem(value: 1, child: Text('SIM 2')),
          ],
        ),
      ),
    );
  }
}
