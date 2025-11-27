import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design/tokens.dart';
import '../widgets/audio_visualizer.dart';

class ActiveCallScreen extends StatefulWidget {
  final String phoneNumber;
  final String? contactName;
  final String? contactPhoto;

  const ActiveCallScreen({
    super.key,
    required this.phoneNumber,
    this.contactName,
    this.contactPhoto,
  });

  @override
  State<ActiveCallScreen> createState() => _ActiveCallScreenState();
}

class _ActiveCallScreenState extends State<ActiveCallScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _isMuted = false;
  bool _isSpeaker = false;
  bool _isKeypad = false;
  CallState _callState = CallState.connecting;

  @override
  void initState() {
    super.initState();
    // Simulate connection delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _callState = CallState.active);
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _seconds++);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [const Color(0xFF1A1C1E), const Color(0xFF0F1113)]
                    : [const Color(0xFFF0F4F8), const Color(0xFFE1E6EC)],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Contact Info
                Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primaryContainer,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          widget.contactName?[0] ?? widget.phoneNumber[0],
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ).animate().scale(
                      duration: 600.ms,
                      curve: Curves.easeOutBack,
                    ),

                    const SizedBox(height: 24),

                    Text(
                          widget.contactName ?? widget.phoneNumber,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 8),

                    if (widget.contactName != null)
                      Text(
                        widget.phoneNumber,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ).animate().fadeIn(delay: 300.ms),

                    const SizedBox(height: 16),

                    // Status / Timer
                    if (_callState == CallState.connecting)
                      Text(
                            'Calling...',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .fadeIn(duration: 800.ms)
                          .fadeOut(delay: 800.ms)
                    else
                      Text(
                        _formatDuration(_seconds),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontFeatures: [const FontFeature.tabularFigures()],
                        ),
                      ),
                  ],
                ),

                const Spacer(),

                // Audio Visualizer
                if (_callState == CallState.active)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: AudioVisualizer(
                      isActive: !_isMuted,
                      color: theme.colorScheme.primary,
                    ),
                  ).animate().fadeIn(),

                // Controls
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withOpacity(0.8),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _CallControl(
                            icon: _isMuted
                                ? Icons.mic_off_rounded
                                : Icons.mic_rounded,
                            label: 'Mute',
                            isActive: _isMuted,
                            onTap: () => setState(() => _isMuted = !_isMuted),
                          ),
                          _CallControl(
                            icon: Icons.dialpad_rounded,
                            label: 'Keypad',
                            isActive: _isKeypad,
                            onTap: () => setState(() => _isKeypad = !_isKeypad),
                          ),
                          _CallControl(
                            icon: _isSpeaker
                                ? Icons.volume_up_rounded
                                : Icons.volume_down_rounded,
                            label: 'Speaker',
                            isActive: _isSpeaker,
                            onTap: () =>
                                setState(() => _isSpeaker = !_isSpeaker),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _CallControl(
                            icon: Icons.add_call,
                            label: 'Add Call',
                            onTap: () {},
                          ),
                          _CallControl(
                            icon: Icons.videocam_rounded,
                            label: 'Video',
                            onTap: () {},
                          ),
                          _CallControl(
                            icon: Icons.pause_rounded,
                            label: 'Hold',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // End Call Button
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.error,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.error.withOpacity(0.4),
                                blurRadius: 16,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.call_end_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ).animate().scale(
                        duration: 200.ms,
                        curve: Curves.easeOut,
                      ),
                    ],
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

enum CallState { connecting, active, ended }

class _CallControl extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _CallControl({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            ),
            child: Icon(
              icon,
              color: isActive
                  ? theme.colorScheme.onPrimaryContainer
                  : theme.colorScheme.onSurfaceVariant,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
