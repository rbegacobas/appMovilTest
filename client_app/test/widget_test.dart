// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:client_app/main.dart';

void main() {
  testWidgets('App shows auth email field', (WidgetTester tester) async {
    // Build the app and allow Firebase init to settle.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the auth page is shown with Email field and Entrar button.
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });
}
