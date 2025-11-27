import 'package:flutter/material.dart';
import '../../../../components/components.dart';
import '../../../../design/tokens.dart';

class PairingStatusScreen extends StatelessWidget {
  final bool isSuccess;
  final String message;
  final VoidCallback onContinue;
  final VoidCallback? onRetry;

  const PairingStatusScreen({
    super.key,
    required this.isSuccess,
    required this.message,
    required this.onContinue,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(AppTokens.space8),
                decoration: BoxDecoration(
                  color: isSuccess
                      ? Colors.green.withOpacity(0.1)
                      : colorScheme.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
                  size: 80,
                  color: isSuccess ? Colors.green : colorScheme.error,
                ),
              ),
              const SizedBox(height: AppTokens.space8),
              Text(
                isSuccess ? 'Pairing Successful!' : 'Pairing Failed',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTokens.space4),
              Text(
                message,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              GradientButton(
                label: isSuccess ? 'Continue to Dashboard' : 'Try Again',
                onPressed: isSuccess
                    ? onContinue
                    : (onRetry ?? () => Navigator.of(context).pop()),
                icon: isSuccess
                    ? Icons.arrow_forward_rounded
                    : Icons.refresh_rounded,
              ),
              const SizedBox(height: AppTokens.space4),
            ],
          ),
        ),
      ),
    );
  }
}
