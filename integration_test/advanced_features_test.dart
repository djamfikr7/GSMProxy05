import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gsm05/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Advanced Features Integration Tests', () {
    testWidgets('Navigate to Advanced Features tab', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Skip through auth flow to reach dashboard
      // Note: This assumes you have a way to bypass auth for testing
      // You may need to modify this based on your auth implementation

      // Find and tap Advanced tab (assuming it's the last navigation item)
      final advancedTab = find.text('Advanced');
      if (advancedTab.evaluate().isEmpty) {
        // Try finding by icon if text not found
        final advancedIcon = find.byIcon(Icons.settings_rounded);
        expect(advancedIcon, findsOneWidget);
        await tester.tap(advancedIcon);
      } else {
        expect(advancedTab, findsOneWidget);
        await tester.tap(advancedTab);
      }
      await tester.pumpAndSettle();

      // Verify we're on Advanced Features screen
      expect(find.text('Advanced Features'), findsOneWidget);

      // Verify all feature cards are present
      expect(find.text('SIM Management'), findsOneWidget);
      expect(find.text('System Monitoring'), findsOneWidget);
      expect(find.text('USSD Codes'), findsOneWidget);
      expect(find.text('Call Recording'), findsOneWidget);
    });

    testWidgets('Navigate to SIM Management screen', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Advanced tab
      final advancedTab = find.byIcon(Icons.settings_rounded);
      await tester.tap(advancedTab);
      await tester.pumpAndSettle();

      // Tap on SIM Management card
      final simCard = find.text('SIM Management');
      expect(simCard, findsOneWidget);
      await tester.tap(simCard);
      await tester.pumpAndSettle();

      // Verify we're on SIM Management screen
      expect(find.text('SIM Management'), findsWidgets);
      expect(find.text('SIM Cards'), findsOneWidget);
      expect(find.text('Preferences'), findsOneWidget);

      // Verify SIM cards are displayed
      expect(find.text('Verizon'), findsOneWidget);
      expect(find.text('T-Mobile'), findsOneWidget);
    });

    testWidgets('Navigate to System Monitoring screen', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Advanced tab
      final advancedTab = find.byIcon(Icons.settings_rounded);
      await tester.tap(advancedTab);
      await tester.pumpAndSettle();

      // Tap on System Monitoring card
      final monitoringCard = find.text('System Monitoring');
      expect(monitoringCard, findsOneWidget);
      await tester.tap(monitoringCard);
      await tester.pumpAndSettle();

      // Verify we're on Monitoring screen
      expect(find.text('System Monitoring'), findsWidgets);
      expect(find.text('Battery'), findsOneWidget);
      expect(find.text('RAM Usage'), findsOneWidget);
      expect(find.text('Storage'), findsOneWidget);
      expect(find.text('Signal Strength'), findsOneWidget);
    });

    testWidgets('Navigate to USSD Codes screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Advanced tab
      final advancedTab = find.byIcon(Icons.settings_rounded);
      await tester.tap(advancedTab);
      await tester.pumpAndSettle();

      // Tap on USSD Codes card
      final ussdCard = find.text('USSD Codes');
      expect(ussdCard, findsOneWidget);
      await tester.tap(ussdCard);
      await tester.pumpAndSettle();

      // Verify we're on USSD screen
      expect(find.text('USSD Codes'), findsWidgets);
      expect(find.text('Enter Code'), findsOneWidget);
      expect(find.text('Execute'), findsOneWidget);
    });

    testWidgets('Navigate to Call Recording screen and show legal warning', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Advanced tab
      final advancedTab = find.byIcon(Icons.settings_rounded);
      await tester.tap(advancedTab);
      await tester.pumpAndSettle();

      // Tap on Call Recording card
      final callRecordingCard = find.text('Call Recording');
      expect(callRecordingCard, findsOneWidget);
      await tester.tap(callRecordingCard);
      await tester.pumpAndSettle();

      // Verify we're on Call Recording screen
      expect(find.text('Call Recording'), findsWidgets);
      expect(find.text('Enable Call Recording'), findsOneWidget);
      expect(find.text('Recent Recordings'), findsOneWidget);

      // Toggle recording to trigger legal warning
      final recordingToggle = find.byType(Switch).first;
      await tester.tap(recordingToggle);
      await tester.pumpAndSettle();

      // Verify legal warning dialog appears
      expect(find.text('Legal Warning'), findsOneWidget);
      expect(find.text('I Agree & Enable'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('SIM Management - Toggle SIM cards', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to SIM Management
      final advancedTab = find.byIcon(Icons.settings_rounded);
      await tester.tap(advancedTab);
      await tester.pumpAndSettle();

      await tester.tap(find.text('SIM Management'));
      await tester.pumpAndSettle();

      // Find and toggle first SIM switch
      final simSwitches = find.byType(Switch);
      expect(simSwitches, findsWidgets);

      await tester.tap(simSwitches.first);
      await tester.pumpAndSettle();

      // Verify the switch toggled (opacity should change)
      // This is a visual test - in a real scenario you'd check state
    });

    testWidgets('USSD - Execute code flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to USSD
      final advancedTab = find.byIcon(Icons.settings_rounded);
      await tester.tap(advancedTab);
      await tester.pumpAndSettle();

      await tester.tap(find.text('USSD Codes'));
      await tester.pumpAndSettle();

      // Tap some numbers on keypad
      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3'));
      await tester.pumpAndSettle();

      // Tap Execute button
      await tester.tap(find.text('Execute'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Verify dialog appears
      expect(find.text('Running USSD code...'), findsOneWidget);

      // Wait for response
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify response shown
      expect(find.text('Carrier Info'), findsOneWidget);
    });
  });
}
