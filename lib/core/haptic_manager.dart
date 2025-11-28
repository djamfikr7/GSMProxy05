import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Centralized haptic feedback manager
/// Provides consistent tactile feedback across the app
class HapticManager {
  /// Light impact for button presses and minor interactions
  /// Duration: ~10ms
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium impact for important actions
  /// Duration: ~20ms
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact for critical actions or errors
  /// Duration: ~30ms
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  /// Selection click for picker/slider movements
  /// Duration: ~5ms
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }

  /// Vibrate pattern for success operations
  static Future<void> success() async {
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    await HapticFeedback.lightImpact();
  }

  /// Vibrate pattern for error operations
  static Future<void> error() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }

  /// Vibrate pattern for incoming call
  static Future<void> incomingCall() async {
    for (int i = 0; i < 3; i++) {
      await HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  /// Vibrate for call connection
  static Future<void> callConnected() async {
    await HapticFeedback.mediumImpact();
  }

  /// Vibrate for call ended
  static Future<void> callEnded() async {
    await HapticFeedback.lightImpact();
  }

  /// Vibrate for message sent
  static Future<void> messageSent() async {
    await HapticFeedback.lightImpact();
  }

  /// Vibrate for message received
  static Future<void> messageReceived() async {
    await HapticFeedback.mediumImpact();
  }
}
