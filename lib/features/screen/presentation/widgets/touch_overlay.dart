import 'package:flutter/material.dart';

class TouchOverlay extends StatefulWidget {
  final Function(Offset) onTap;
  final Function(Offset) onLongPress;
  final Function(DragUpdateDetails) onPanUpdate;

  const TouchOverlay({
    super.key,
    required this.onTap,
    required this.onLongPress,
    required this.onPanUpdate,
  });

  @override
  State<TouchOverlay> createState() => _TouchOverlayState();
}

class _TouchOverlayState extends State<TouchOverlay>
    with SingleTickerProviderStateMixin {
  final List<_TouchRipple> _ripples = [];

  void _addRipple(Offset position) {
    setState(() {
      _ripples.add(
        _TouchRipple(
          position: position,
          controller:
              AnimationController(
                  vsync: this,
                  duration: const Duration(milliseconds: 300),
                )
                ..forward().then((_) {
                  _removeRipple(position);
                }),
        ),
      );
    });
  }

  void _removeRipple(Offset position) {
    if (mounted) {
      setState(() {
        _ripples.removeWhere(
          (r) => r.position == position && r.controller.isCompleted,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Gesture Detector
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapUp: (details) {
            _addRipple(details.localPosition);
            widget.onTap(details.localPosition);
          },
          onLongPressStart: (details) {
            _addRipple(details.localPosition);
            widget.onLongPress(details.localPosition);
          },
          onPanUpdate: (details) {
            // For pan, we might not want ripples on every frame
            widget.onPanUpdate(details);
          },
          child: Container(color: Colors.transparent),
        ),

        // Visual Feedback
        ..._ripples.map((ripple) => _RippleWidget(ripple: ripple)),
      ],
    );
  }
}

class _TouchRipple {
  final Offset position;
  final AnimationController controller;

  _TouchRipple({required this.position, required this.controller});
}

class _RippleWidget extends StatelessWidget {
  final _TouchRipple ripple;

  const _RippleWidget({required this.ripple});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ripple.controller,
      builder: (context, child) {
        return Positioned(
          left: ripple.position.dx - 20,
          top: ripple.position.dy - 20,
          child: Opacity(
            opacity: 1.0 - ripple.controller.value,
            child: Container(
              width: 40 * (0.5 + ripple.controller.value),
              height: 40 * (0.5 + ripple.controller.value),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        );
      },
    );
  }
}
