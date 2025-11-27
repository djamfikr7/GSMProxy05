import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/status_bar_widget.dart';
import '../widgets/device_status_card.dart';
import '../widgets/quick_actions_panel.dart';
import '../widgets/sim_selector.dart';
import '../../data/dashboard_providers.dart';
import '../../../../design/tokens.dart';
import '../../../screen/presentation/screens/screen_viewer_screen.dart';
import '../../../dialer/presentation/screens/dialer_screen.dart';
import '../../../dialer/presentation/screens/call_management_screen.dart';
import '../../../dialer/presentation/screens/incoming_call_screen.dart';
import '../../../messaging/presentation/screens/messaging_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavigationIndexProvider);
    final devices = ref.watch(connectedDevicesProvider);
    final latency = ref.watch(connectionLatencyProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine layout based on screen width
        final isDesktop = constraints.maxWidth > 840;
        final isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 840;
        final isMobile = constraints.maxWidth <= 600;

        return Scaffold(
          body: Row(
            children: [
              // Navigation Rail for tablet/desktop
              if (!isMobile)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    ref
                        .read(selectedNavigationIndexProvider.notifier)
                        .setIndex(index);
                  },
                  extended: isDesktop,
                  labelType: isTablet
                      ? NavigationRailLabelType.selected
                      : NavigationRailLabelType.none,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_rounded),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.devices_rounded),
                      label: Text('Devices'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.screenshot_monitor_rounded),
                      label: Text('Screen'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.call_rounded),
                      label: Text('Calls'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.message_rounded),
                      label: Text('Messages'),
                    ),
                  ],
                ),

              // Main content
              Expanded(
                child: Column(
                  children: [
                    // Status bar
                    StatusBarWidget(
                      latencyMs: latency,
                      deviceName: devices.isNotEmpty
                          ? devices.first.name
                          : 'No Device',
                    ),

                    // Content
                    Expanded(child: _buildContent(selectedIndex, devices)),
                  ],
                ),
              ),
            ],
          ),

          // Bottom navigation for mobile
          bottomNavigationBar: isMobile
              ? NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    ref
                        .read(selectedNavigationIndexProvider.notifier)
                        .setIndex(index);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.dashboard_rounded),
                      label: 'Dashboard',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.devices_rounded),
                      label: 'Devices',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.screenshot_monitor_rounded),
                      label: 'Screen',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.call_rounded),
                      label: 'Calls',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.message_rounded),
                      label: 'Messages',
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }

  void _navigateToScreen(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const ScreenViewerScreen()));
  }

  void _navigateToDialer(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const DialerScreen()));
  }

  Widget _buildContent(int index, List devices) {
    switch (index) {
      case 0:
        return _buildDashboardTab(devices);
      case 1:
        return _buildDevicesTab(devices);
      case 2:
        // Screen tab - show launcher for Screen Viewer
        return Builder(
          builder: (context) {
            // Auto-launch on tab selection
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigateToScreen(context);
              // Reset to dashboard tab after navigation
              Future.delayed(const Duration(milliseconds: 100), () {
                if (context.mounted) {
                  final ref = ProviderScope.containerOf(context);
                  ref
                      .read(selectedNavigationIndexProvider.notifier)
                      .setIndex(0);
                }
              });
            });

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.screenshot_monitor_rounded, size: 64),
                  const SizedBox(height: 16),
                  const Text('Launching Screen Viewer...'),
                ],
              ),
            );
          },
        );
      case 3:
        return const CallManagementScreen();
      case 4:
        return const MessagingScreen();
      default:
        return Center(child: Text('Tab $index - Coming in Phase ${index + 5}'));
    }
  }

  Widget _buildDashboardTab(List devices) {
    return Builder(
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuickActionsPanel(
                onCallTap: () => _navigateToDialer(context),
                onScreenTap: () => _navigateToScreen(context),
                onTestCallTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const IncomingCallScreen(
                        callerName: 'Jane Doe',
                        phoneNumber: '(555) 123-4567',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppTokens.space6),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Active Device',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SimSlotSelector(onSlotSelected: (index) {}),
                ],
              ),
              const SizedBox(height: AppTokens.space4),

              if (devices.isNotEmpty) ...[
                DeviceStatusCard(device: devices.first, onTap: () {}),
              ] else
                const Center(child: Text('No devices connected')),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDevicesTab(List devices) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTokens.space6),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppTokens.space4),
          child: DeviceStatusCard(device: devices[index], onTap: () {}),
        );
      },
    );
  }
}
