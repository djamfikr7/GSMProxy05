import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../components/components.dart';
import '../../../../design/tokens.dart';

class PermissionsScreen extends StatefulWidget {
  final VoidCallback onPermissionsGranted;

  const PermissionsScreen({super.key, required this.onPermissionsGranted});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _isCameraGranted = false;
  bool _isNotificationGranted = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final camera = await Permission.camera.status;
    final notification = await Permission.notification.status;

    setState(() {
      _isCameraGranted = camera.isGranted;
      _isNotificationGranted = notification.isGranted;
      _isChecking = false;
    });

    if (_isCameraGranted && _isNotificationGranted) {
      widget.onPermissionsGranted();
    }
  }

  Future<void> _requestPermissions() async {
    // On web, permission_handler doesn't work properly, so just proceed
    if (kIsWeb) {
      widget.onPermissionsGranted();
      return;
    }

    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.notification,
    ].request();

    setState(() {
      _isCameraGranted = statuses[Permission.camera]?.isGranted ?? false;
      _isNotificationGranted =
          statuses[Permission.notification]?.isGranted ?? false;
    });

    if (_isCameraGranted && _isNotificationGranted) {
      widget.onPermissionsGranted();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTokens.space8),
              Text(
                'Permissions Required',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppTokens.space4),
              Text(
                'To provide the full ProxyGSM experience, we need access to a few device features.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppTokens.space8),

              _PermissionItem(
                icon: Icons.camera_alt_rounded,
                title: 'Camera Access',
                description: 'Required to scan the QR code for pairing.',
                isGranted: _isCameraGranted,
              ),
              const SizedBox(height: AppTokens.space4),
              _PermissionItem(
                icon: Icons.notifications_active_rounded,
                title: 'Notifications',
                description:
                    'To keep you updated on connection status and calls.',
                isGranted: _isNotificationGranted,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'Grant Permissions',
                  onPressed: _requestPermissions,
                  icon: Icons.check_circle_outline_rounded,
                ),
              ),
              const SizedBox(height: AppTokens.space4),
            ],
          ),
        ),
      ),
    );
  }
}

class _PermissionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isGranted;

  const _PermissionItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.isGranted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GlassCard(
      padding: const EdgeInsets.all(AppTokens.space4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTokens.space3),
            decoration: BoxDecoration(
              color: isGranted
                  ? Colors.green.withOpacity(0.1)
                  : colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isGranted ? Icons.check_rounded : icon,
              color: isGranted ? Colors.green : colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTokens.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTokens.space1),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
