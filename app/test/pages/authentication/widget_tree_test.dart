import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/pages/authentication/widget_tree.dart';
import 'package:matchify/pages/homeScreen.dart';
import 'package:matchify/pages/authentication/login.dart';

import '../../mock.dart';

void main() {
  setupFirebaseAuthMocks();
  testWidgets('WidgetTree should show Login screen by default', (WidgetTester tester) async {
    await Firebase.initializeApp();
    await tester.pumpWidget(MaterialApp(home: WidgetTree()));
    expect(find.byType(Login), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });
  testWidgets('WidgetTree should show Login screen when not authenticated', (WidgetTester tester) async {
     await Firebase.initializeApp();
    // Set up a mock authentication stream that emits an unauthenticated user
    final authStream = Stream<bool>.value(false);
    // Pump the widget tree with the mock authentication stream
    await tester.pumpWidget(MaterialApp(home: StreamBuilder(stream: authStream, builder: (context, snapshot) => WidgetTree())));
    // Wait for the widget tree to rebuild
    await tester.pumpAndSettle();
    // Expect to find Login widget and not find HomeScreen widget
    expect(find.byType(Login), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });
}
