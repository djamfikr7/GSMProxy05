import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../../../components/components.dart';
import '../../../../design/tokens.dart';

class QRScannerScreen extends StatefulWidget {
  final Function(String) onScan;

  const QRScannerScreen({super.key, required this.onScan});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Web fallback - show mock QR input
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pairing'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppTokens.space6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 100,
                  color: theme.colorScheme.primary.withOpacity(0.5),
                ),
                const SizedBox(height: AppTokens.space8),
                Text(
                  'QR Scanner',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTokens.space4),
                Text(
                  'QR scanning is not available on web.\nFor demo, click below to simulate pairing.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTokens.space8),
                GradientButton(
                  label: 'Simulate QR Scan',
                  onPressed: () {
                    // Simulate successful scan
                    widget.onScan('DEMO-SERVER-12345');
                  },
                  icon: Icons.qr_code_rounded,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Mobile: Use actual QR scanner (not implemented for now to avoid dependency issues)
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: const Center(
        child: Text('QR Scanner only works on mobile devices'),
      ),
    );
  }
}
