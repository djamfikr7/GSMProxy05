import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsm05/features/auth/presentation/screens/permissions_screen.dart';
import 'package:gsm05/features/auth/presentation/screens/pairing_status_screen.dart';
import 'package:gsm05/components/components.dart';

void main() {
  group('Auth Screens Widget Tests', () {
    testWidgets('PermissionsScreen renders correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: PermissionsScreen(onPermissionsGranted: () {})),
      );

      // Verify title and description
      expect(find.text('Permissions Required'), findsOneWidget);
      expect(find.text('Camera Access'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);

      // Verify button
      expect(
        find.widgetWithText(GradientButton, 'Grant Permissions'),
        findsOneWidget,
      );
    });

    testWidgets('PairingStatusScreen renders success state correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PairingStatusScreen(
            isSuccess: true,
            message: 'Connected',
            onContinue: () {},
          ),
        ),
      );

      expect(find.text('Pairing Successful!'), findsOneWidget);
      expect(find.text('Connected'), findsOneWidget);
      expect(
        find.widgetWithText(GradientButton, 'Continue to Dashboard'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });

    testWidgets('PairingStatusScreen renders failure state correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PairingStatusScreen(
            isSuccess: false,
            message: 'Connection failed',
            onContinue: () {},
          ),
        ),
      );

      expect(find.text('Pairing Failed'), findsOneWidget);
      expect(find.text('Connection failed'), findsOneWidget);
      expect(find.widgetWithText(GradientButton, 'Try Again'), findsOneWidget);
      expect(find.byIcon(Icons.error_rounded), findsOneWidget);
    });
  });
}
