// Test for ProxyGSM Application

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gsm05/main.dart';

void main() {
  testWidgets('ProxyGSM app loads with splash screen', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: ProxyGsmApp()));

    // Verify that splash screen is displayed
    expect(find.text('ProxyGSM'), findsOneWidget);
    expect(find.text('Remote GSM Gateway Control'), findsOneWidget);
    expect(find.text('Initializing...'), findsOneWidget);

    // Verify Material 3 components are present
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
