import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/number_display.dart';
import '../widgets/dialer_keypad.dart';
import 'active_call_screen.dart';
import '../../data/dialer_providers.dart';
import '../../../../design/tokens.dart';
import '../../../../core/page_transitions.dart';
import '../../../../core/haptic_manager.dart';

/// Premium dialer screen with smooth animations
class DialerScreen extends ConsumerWidget {
  const DialerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final number = ref.watch(dialerNumberProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppTokens.space4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  Text(
                    'Dialer',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),

            const SizedBox(height: AppTokens.space6),

            // Number Display
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.space6),
              child: NumberDisplay(
                number: number,
                onBackspace: () {
                  ref.read(dialerNumberProvider.notifier).removeLastDigit();
                },
                onClear: () {
                  ref.read(dialerNumberProvider.notifier).clear();
                },
              ),
            ),

            const Spacer(),

            // Keypad
            DialerKeypad(
              onDigitPressed: (digit) {
                ref.read(dialerNumberProvider.notifier).addDigit(digit);
              },
              onZeroLongPress: () {
                ref.read(dialerNumberProvider.notifier).addDigit('+');
              },
            ),

            const SizedBox(height: AppTokens.space6),

            // Call Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.space6),
              child: _CallButton(
                enabled: number.isNotEmpty,
                onTap: () {
                  HapticManager.callConnected();
                  Navigator.of(context).push(
                    ScalePageRoute(page: ActiveCallScreen(phoneNumber: number)),
                  );
                },
              ),
            ),

            const SizedBox(height: AppTokens.space8),
          ],
        ),
      ),
    );
  }
}

/// Premium call button with smooth animations
class _CallButton extends StatefulWidget {
  final bool enabled;
  final VoidCallback onTap;

  const _CallButton({required this.enabled, required this.onTap});

  @override
  State<_CallButton> createState() => _CallButtonState();
}

class _CallButtonState extends State<_CallButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: AppTokens.emphasized),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTokens.radiusLg),
                gradient: widget.enabled
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF10B981),
                          const Color(0xFF059669),
                        ],
                      )
                    : LinearGradient(
                        colors: [
                          theme.colorScheme.surfaceContainerHighest,
                          theme.colorScheme.surfaceContainerHigh,
                        ],
                      ),
                boxShadow: widget.enabled && _isPressed
                    ? [
                        BoxShadow(
                          color: const Color(0xFF10B981).withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: -2,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : widget.enabled
                    ? [
                        BoxShadow(
                          color: const Color(0xFF10B981).withOpacity(0.3),
                          blurRadius: 16,
                          spreadRadius: -4,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_rounded,
                    color: widget.enabled
                        ? Colors.white
                        : theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Call',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: widget.enabled
                          ? Colors.white
                          : theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
