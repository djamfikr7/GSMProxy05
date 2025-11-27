import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design/tokens.dart';
import 'active_call_screen.dart';

class IncomingCallScreen extends StatefulWidget {
  final String callerName;
  final String phoneNumber;
  final String? photoUrl;

  const IncomingCallScreen({
    super.key,
    required this.callerName,
    required this.phoneNumber,
    this.photoUrl,
  });

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background with blur
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF2C3E50), const Color(0xFF000000)]
                    : [const Color(0xFFE0EAFC), const Color(0xFFCFDEF3)],
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 80),

                // Caller Info
                Column(
                  children: [
                    Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primaryContainer,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.callerName[0],
                              style: theme.textTheme.displayLarge?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.05, 1.05),
                          duration: 1500.ms,
                          curve: Curves.easeInOut,
                        ),
                    const SizedBox(height: 32),
                    Text(
                      widget.callerName,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn().slideY(begin: 0.3, end: 0),
                    const SizedBox(height: 8),
                    Text(
                      'Incoming Call...',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 8),
                    Text(
                      widget.phoneNumber,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ).animate().fadeIn(delay: 400.ms),
                  ],
                ),

                const Spacer(),

                // Actions
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 60,
                    left: 40,
                    right: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Decline Button
                      _ActionColumn(
                        icon: Icons.call_end_rounded,
                        label: 'Decline',
                        color: theme.colorScheme.error,
                        onTap: () => Navigator.of(context).pop(),
                      ).animate().slideX(begin: -0.5, end: 0, duration: 400.ms),

                      // Message Button (Small)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: const Icon(
                              Icons.message_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Message',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 600.ms),

                      // Answer Button
                      _ActionColumn(
                        icon: Icons.call_rounded,
                        label: 'Answer',
                        color: const Color(0xFF4CAF50),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ActiveCallScreen(
                                phoneNumber: widget.phoneNumber,
                                contactName: widget.callerName,
                              ),
                            ),
                          );
                        },
                      ).animate().slideX(begin: 0.5, end: 0, duration: 400.ms),
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

class _ActionColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionColumn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.1, 1.1),
                duration: 1000.ms,
              ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
