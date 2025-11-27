import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../components/components.dart';
import '../../../../design/tokens.dart';

class BiometricAuthScreen extends StatefulWidget {
  final VoidCallback onAuthenticated;
  final VoidCallback onSkip;

  const BiometricAuthScreen({
    super.key,
    required this.onAuthenticated,
    required this.onSkip,
  });

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });

    if (canCheckBiometrics) {
      _authenticate();
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint (or face) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.toString()}';
      });
      return;
    }
    if (!mounted) return;

    if (authenticated) {
      widget.onAuthenticated();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(
                Icons.fingerprint_rounded,
                size: 100,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: AppTokens.space8),
              Text(
                'Biometric Authentication',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTokens.space4),
              Text(
                'Secure your ProxyGSM access with biometrics.',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTokens.space2),
              Text(
                'Status: $_authorized',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (_canCheckBiometrics)
                GradientButton(
                  label: 'Authenticate',
                  onPressed: _authenticate,
                  isLoading: _isAuthenticating,
                  icon: Icons.fingerprint,
                ),
              if (!_canCheckBiometrics)
                Text(
                  'Biometrics not available on this device.',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              const SizedBox(height: AppTokens.space4),
              TextButton(
                onPressed: widget.onSkip,
                child: const Text('Skip for now'),
              ),
              const SizedBox(height: AppTokens.space4),
            ],
          ),
        ),
      ),
    );
  }
}
