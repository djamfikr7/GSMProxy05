import 'package:flutter/material.dart';
import '../../../../design/tokens.dart';
import '../../../../core/haptic_manager.dart';

/// Premium dialer keypad button with tactile feedback
class DialerButton extends StatefulWidget {
  final String digit;
  final String? letters;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const DialerButton({
    super.key,
    required this.digit,
    this.letters,
    required this.onTap,
    this.onLongPress,
  });

  @override
  State<DialerButton> createState() => _DialerButtonState();
}

class _DialerButtonState extends State<DialerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _controller, curve: AppTokens.standard));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: () {
        HapticManager.light();
        widget.onTap();
      },
      onLongPress: () {
        if (widget.onLongPress != null) {
          HapticManager.medium();
          widget.onLongPress!();
        }
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isPressed
                      ? [
                          theme.colorScheme.primary.withOpacity(0.2),
                          theme.colorScheme.primary.withOpacity(0.1),
                        ]
                      : [
                          isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.white.withOpacity(0.9),
                          isDark
                              ? Colors.white.withOpacity(0.04)
                              : Colors.white.withOpacity(0.7),
                        ],
                ),
                border: Border.all(
                  color: _isPressed
                      ? theme.colorScheme.primary.withOpacity(0.4)
                      : isDark
                      ? Colors.white.withOpacity(0.12)
                      : Colors.black.withOpacity(0.08),
                  width: 1.5,
                ),
                boxShadow: _isPressed
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: -2,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.digit,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _isPressed
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      height: 1.0,
                    ),
                  ),
                  if (widget.letters != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.letters!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
