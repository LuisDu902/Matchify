import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/loadingScreen.dart';
import 'package:matchify/authentication/widget_tree.dart';

import 'mock.dart';

void main() {
  setupFirebaseAuthMocks();
  testWidgets('LoadingScreen should navigate to WidgetTree after 3 seconds', (WidgetTester tester) async {
    await Firebase.initializeApp();
  // Build the widget tree
  await tester.pumpWidget(const MaterialApp(
    home: LoadingScreen(),
  ));

  // Wait for 3 seconds for the navigation to occur
  await tester.pumpAndSettle(const Duration(seconds: 3));

  // Verify that WidgetTree is now displayed
  expect(find.byType(WidgetTree), findsOneWidget);
});
}
