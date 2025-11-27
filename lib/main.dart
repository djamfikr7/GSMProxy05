import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'design/app_theme.dart';
import 'design/tokens.dart';
import 'features/auth/presentation/screens/permissions_screen.dart';
import 'features/auth/presentation/screens/qr_scanner_screen.dart';
import 'features/auth/presentation/screens/biometric_screen.dart';
import 'features/auth/presentation/screens/pairing_status_screen.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';

void main() {
  runApp(const ProviderScope(child: ProxyGsmApp()));
}

class ProxyGsmApp extends StatelessWidget {
  const ProxyGsmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProxyGSM',
      debugShowCheckedModeBanner: false,

      // Material 3 Themes
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,

      // Routes
      routes: {
        '/': (context) => const SplashScreen(),
        '/permissions': (context) => PermissionsScreen(
          onPermissionsGranted: () =>
              Navigator.of(context).pushReplacementNamed('/qr_scanner'),
        ),
        '/qr_scanner': (context) => QRScannerScreen(
          onScan: (code) {
            // Mock pairing logic
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PairingStatusScreen(
                  isSuccess: true,
                  message: 'Successfully paired with server: $code',
                  onContinue: () =>
                      Navigator.of(context).pushReplacementNamed('/biometric'),
                ),
              ),
            );
          },
        ),
        '/biometric': (context) => BiometricAuthScreen(
          onAuthenticated: () =>
              Navigator.of(context).pushReplacementNamed('/dashboard'),
          onSkip: () =>
              Navigator.of(context).pushReplacementNamed('/dashboard'),
        ),
        '/dashboard': (context) => const DashboardScreen(),
      },
      initialRoute: '/',
    );
  }
}

/// Ultimate Premium Splash Screen
/// Features: Aurora Mesh Gradients, Ultra-thin Glass, Editorial Typography
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _auroraController;

  // Staggered Animations
  late Animation<double> _fadeContent;
  late Animation<double> _slideContent;
  late Animation<double> _scaleIcon;
  late Animation<double> _blurBackground;

  @override
  void initState() {
    super.initState();

    // Main Orchestrator
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Continuous Aurora Animation
    _auroraController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    // 1. Background Blur Reveal
    _blurBackground = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // 2. Icon Scale & Pop
    _scaleIcon = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: AppTokens.emphasized),
      ),
    );

    // 3. Content Slide Up
    _slideContent = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.9, curve: AppTokens.emphasizedDecelerate),
      ),
    );

    // 4. Content Fade In
    _fadeContent = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _mainController.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/permissions');
        }
      });
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _auroraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF09090B)
          : const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // --- Layer 1: Aurora Mesh Background ---
          AnimatedBuilder(
            animation: _auroraController,
            builder: (context, child) {
              return CustomPaint(
                painter: _AuroraPainter(
                  progress: _auroraController.value,
                  isDark: isDark,
                ),
                size: Size.infinite,
              );
            },
          ),

          // --- Layer 2: Glass Overlay & Content ---
          Center(
            child: AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 30 * _blurBackground.value,
                    sigmaY: 30 * _blurBackground.value,
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    margin: const EdgeInsets.all(AppTokens.space6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 1. Ultra-Premium Glass Icon
                        Transform.scale(
                          scale: _scaleIcon.value,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isDark
                                    ? [
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(0.05),
                                      ]
                                    : [
                                        Colors.white.withOpacity(0.8),
                                        Colors.white.withOpacity(0.4),
                                      ],
                              ),
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.white.withOpacity(0.5),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withOpacity(
                                    0.2,
                                  ),
                                  blurRadius: 50,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 20),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons
                                        .layers_outlined, // More abstract/modern icon
                                    size: 64,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppTokens.space12),

                        // 2. Content Group
                        Transform.translate(
                          offset: Offset(0, _slideContent.value),
                          child: Opacity(
                            opacity: _fadeContent.value,
                            child: Column(
                              children: [
                                // Title with tight tracking (Editorial look)
                                Text(
                                  'ProxyGSM',
                                  style: theme.textTheme.displayMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -1.5, // Tight tracking
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        height: 1.0,
                                      ),
                                ),

                                const SizedBox(height: AppTokens.space3),

                                // Subtitle with wide tracking
                                Text(
                                  'ENTERPRISE GATEWAY CONTROL',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    letterSpacing: 3.0, // Wide tracking
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white.withOpacity(0.5)
                                        : Colors.black.withOpacity(0.5),
                                  ),
                                ),

                                const SizedBox(height: AppTokens.space12),

                                // Minimalist Progress Line
                                Container(
                                  width: 60,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.2),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Container(
                                          width:
                                              constraints.maxWidth *
                                              _mainController.value,
                                          height: 2,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              1,
                                            ),
                                            color: theme.colorScheme.primary,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Painter for the "Aurora" Mesh Gradient effect
class _AuroraPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _AuroraPainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Base background
    paint.color = isDark ? const Color(0xFF09090B) : const Color(0xFFFFFFFF);
    canvas.drawRect(Offset.zero & size, paint);

    // Orb 1: Primary Color (Top Left moving)
    _drawOrb(
      canvas,
      size,
      Offset(size.width * 0.2, size.height * 0.3),
      isDark ? const Color(0xFF6D28D9) : const Color(0xFFDDD6FE),
      200 + (50 * progress),
    );

    // Orb 2: Secondary Color (Bottom Right moving)
    _drawOrb(
      canvas,
      size,
      Offset(size.width * 0.8, size.height * 0.7),
      isDark ? const Color(0xFFDB2777) : const Color(0xFFFBCFE8),
      250 - (50 * progress),
    );

    // Orb 3: Accent (Center moving)
    _drawOrb(
      canvas,
      size,
      Offset(size.width * 0.5 + (100 * progress), size.height * 0.5),
      isDark ? const Color(0xFF2563EB) : const Color(0xFFBFDBFE),
      180,
    );
  }

  void _drawOrb(
    Canvas canvas,
    Size size,
    Offset center,
    Color color,
    double radius,
  ) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color.withOpacity(0.4), color.withOpacity(0.0)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_AuroraPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isDark != isDark;
}
