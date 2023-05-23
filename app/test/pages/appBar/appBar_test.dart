

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:matchify/pages/homeScreen.dart';
void main() {
  testWidgets('Test appBar widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Verify that the title is displayed on the AppBar
    expect(find.text('   Matchify   '), findsOneWidget);

    // Tap the title and verify that it navigates to the home screen
    await tester.tap(find.text('   Matchify   '));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);

    // Open the drawer by tapping the menu icon
    await tester.tap(find.byKey(Key('side bar')));
    await tester.pumpAndSettle();
    // Verify that the profile icon is displayed in the drawer
    expect(find.byIcon(Icons.person), findsOneWidget);
  });
}
