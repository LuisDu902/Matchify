import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/homeScreen.dart';
import 'package:matchify/filters.dart';
import 'mock.dart';

void main() {
  setupFirebaseAuthMocks();
  testWidgets('HomeScreen should display buttons', (WidgetTester tester) async {
    await Firebase.initializeApp();
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(),
    ));

    final addPlaylistFinder = find.byKey(Key('create a new playlist'));
    expect(addPlaylistFinder, findsOneWidget);
    final yellowButtonFinder = find.byWidgetPredicate((widget) =>
        widget is Container &&
        widget.decoration is BoxDecoration &&
        (widget.decoration as BoxDecoration).color == const Color.fromRGBO(246, 217, 18, 1));
    expect(yellowButtonFinder, findsOneWidget);

    final purpleButtonFinder = find.byWidgetPredicate((widget) =>
        widget is Container &&
        widget.decoration is BoxDecoration &&
        (widget.decoration as BoxDecoration).color == const Color.fromRGBO(73, 43, 124, 1));
    expect(purpleButtonFinder, findsOneWidget);
  });



  testWidgets('Navigation to Filters screen', (WidgetTester tester) async {
    // Build the HomeScreen widget
    await Firebase.initializeApp();
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Tap the "Create a new playlist" button
    await tester.tap(find.byKey(Key('create a new playlist')));
    await tester.pumpAndSettle();

    // Check if the Filters screen was navigated to
    expect(find.byType(Filters), findsOneWidget);
  });
}