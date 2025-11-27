import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design/tokens.dart';
import '../../../../components/components.dart';

/// Animated number display with glassmorphism
class NumberDisplay extends StatelessWidget {
  final String number;
  final VoidCallback onBackspace;
  final VoidCallback? onClear;

  const NumberDisplay({
    super.key,
    required this.number,
    required this.onBackspace,
    this.onClear,
  });

  String _formatNumber(String raw) {
    if (raw.isEmpty) return '';

    final digits = raw.replaceAll(RegExp(r'\D'), '');

    if (digits.length <= 3) {
      return digits;
    } else if (digits.length <= 6) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3)}';
    } else if (digits.length <= 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6, 10)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedNumber = _formatNumber(number);

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: formattedNumber.isEmpty
                ? Text(
                    'Enter phone number',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(
                        0.5,
                      ),
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : Text(
                        formattedNumber,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          fontFeatures: [const FontFeature.tabularFigures()],
                        ),
                      )
                      .animate(key: ValueKey(formattedNumber))
                      .fadeIn(duration: 150.ms, curve: AppTokens.standard)
                      .slideX(begin: 0.1, end: 0, duration: 150.ms),
          ),
          if (number.isNotEmpty) ...[
            const SizedBox(width: 16),
            Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onBackspace,
                    onLongPress: onClear,
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.backspace_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 200.ms)
                .scale(begin: const Offset(0.8, 0.8), duration: 200.ms),
          ],
        ],
      ),
    );
  }
}
