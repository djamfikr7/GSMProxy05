import 'package:flutter/material.dart';

/// Custom page route with slide transition
class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final AxisDirection direction;

  SlidePageRoute({required this.page, this.direction = AxisDirection.left})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          Offset begin;
          switch (direction) {
            case AxisDirection.up:
              begin = const Offset(0.0, 1.0);
              break;
            case AxisDirection.down:
              begin = const Offset(0.0, -1.0);
              break;
            case AxisDirection.left:
              begin = const Offset(1.0, 0.0);
              break;
            case AxisDirection.right:
              begin = const Offset(-1.0, 0.0);
              break;
          }

          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      );
}

/// Custom page route with fade transition
class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 250),
      );
}

/// Custom page route with scale transition
class ScalePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  ScalePageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Curves.easeInOutCubic;
          var tween = Tween(
            begin: 0.8,
            end: 1.0,
          ).chain(CurveTween(curve: curve));

          return ScaleTransition(
            scale: animation.drive(tween),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      );
}

/// Custom page route with rotation + fade transition
class RotationPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  RotationPageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Curves.easeInOutCubic;

          return RotationTransition(
            turns: Tween(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(parent: animation, curve: curve)),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      );
}

/// Material-style shared axis transition (Simplified)
class SharedAxisPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SharedAxisTransitionType transitionType;

  SharedAxisPageRoute({
    required this.page,
    this.transitionType = SharedAxisTransitionType.horizontal,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return _SharedAxisTransition(
             animation: animation,
             secondaryAnimation: secondaryAnimation,
             transitionType: transitionType,
             child: child,
           );
         },
         transitionDuration: const Duration(milliseconds: 300),
       );
}

enum SharedAxisTransitionType { horizontal, vertical, scaled }

class _SharedAxisTransition extends StatelessWidget {
  const _SharedAxisTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.transitionType,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final SharedAxisTransitionType transitionType;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Incoming transition (when this page appears)
    final enterAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    );

    // Outgoing transition (when a new page covers this one)
    final exitAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeInOutCubic,
    );

    return AnimatedBuilder(
      animation: Listenable.merge([enterAnimation, exitAnimation]),
      builder: (context, child) {
        // Calculate opacity and position based on both animations
        double opacity = enterAnimation.value;
        Offset position = Offset.zero;
        double scale = 1.0;

        // If we are being covered by another page, fade out
        if (secondaryAnimation.value > 0) {
          opacity = 1.0 - exitAnimation.value;
        }

        switch (transitionType) {
          case SharedAxisTransitionType.horizontal:
            if (secondaryAnimation.value > 0) {
              // Exiting: Slide to left
              position = Offset(-30.0 * exitAnimation.value, 0.0);
            } else {
              // Entering: Slide from right
              position = Offset(30.0 * (1.0 - enterAnimation.value), 0.0);
            }
            break;
          case SharedAxisTransitionType.vertical:
            if (secondaryAnimation.value > 0) {
              // Exiting: Slide up
              position = Offset(0.0, -30.0 * exitAnimation.value);
            } else {
              // Entering: Slide from down
              position = Offset(0.0, 30.0 * (1.0 - enterAnimation.value));
            }
            break;
          case SharedAxisTransitionType.scaled:
            if (secondaryAnimation.value > 0) {
              // Exiting: Scale up slightly
              scale = 1.0 + (0.1 * exitAnimation.value);
            } else {
              // Entering: Scale from 0.8
              scale = 0.8 + (0.2 * enterAnimation.value);
            }
            break;
        }

        return Transform.translate(
          offset: position,
          child: Transform.scale(
            scale: scale,
            child: Opacity(opacity: opacity.clamp(0.0, 1.0), child: child),
          ),
        );
      },
      child: child,
    );
  }
}
