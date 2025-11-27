import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../design/tokens.dart';

/// Real-time audio waveform visualizer
class AudioVisualizer extends StatefulWidget {
  final bool isActive;
  final Color? color;

  const AudioVisualizer({super.key, required this.isActive, this.color});

  @override
  State<AudioVisualizer> createState() => _AudioVisualizerState();
}

class _AudioVisualizerState extends State<AudioVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<double> _bars = List.filled(7, 0.1);
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..addListener(_updateBars);

    if (widget.isActive) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AudioVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.repeat();
      } else {
        _controller.stop();
        setState(() {
          _bars.fillRange(0, _bars.length, 0.1);
        });
      }
    }
  }

  void _updateBars() {
    setState(() {
      for (int i = 0; i < _bars.length; i++) {
        // Generate random height with smooth transition
        final target = 0.1 + _random.nextDouble() * 0.9;
        _bars[i] =
            Color.lerp(
              Color(_bars[i].toInt()),
              Color(target.toInt()),
              0.2,
            )?.value.toDouble() ??
            target;
        _bars[i] = target;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barColor = widget.color ?? theme.colorScheme.primary;

    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_bars.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 6,
            height: 10 + (_bars[index] * 40),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: barColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: barColor.withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
