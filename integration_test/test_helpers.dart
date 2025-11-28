import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Helper utilities for integration tests
class TestHelpers {
  /// Bypass authentication flow and navigate directly to dashboard
  /// This should be used ONLY in test environments
  static Future<void> bypassAuthAndNavigateToDashboard(
    WidgetTester tester,
  ) async {
    // Wait for initial navigation
    await tester.pumpAndSettle();

    // Navigate directly to dashboard route
    // Note: You may need to adjust this based on your actual routing setup
    // For now, this assumes we can navigate via named routes

    // Alternative: If using MaterialApp, we can use Navigator directly
    // This is a placeholder - you'll need to implement based on your auth strategy
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }

  /// Find a widget by its key
  static Finder findByKey(String key) {
    return find.byKey(Key(key));
  }

  /// Wait for an animation to complete
  static Future<void> waitForAnimation(
    WidgetTester tester, {
    Duration duration = const Duration(milliseconds: 500),
  }) async {
    await tester.pumpAndSettle(duration);
  }

  /// Scroll to find a widget
  static Future<void> scrollToFind(
    WidgetTester tester,
    Finder finder, {
    Finder? scrollable,
  }) async {
    final scroll = scrollable ?? find.byType(Scrollable).first;
    await tester.scrollUntilVisible(finder, 100, scrollable: scroll);
  }
}
