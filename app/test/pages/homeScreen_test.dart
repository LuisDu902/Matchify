import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/pages/homeScreen.dart';
import 'package:matchify/pages/filters.dart';
import 'package:matchify/pages/sidebar/about.dart';
import '../mock.dart';

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

  testWidgets('Open drawer test', (WidgetTester tester) async {
    // Build the widget tree.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the drawer is closed initially.
    expect(find.byType(Drawer), findsNothing);

    // Tap the drawer icon to open the drawer.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the drawer is open.
    expect(find.byType(Drawer), findsOneWidget);
    //Verify that it went to InfoScreen
    expect(find.byType(Info), findsOneWidget);
  });
  testWidgets('Open About Screen', (WidgetTester tester) async {
    // Build the widget tree.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the drawer is closed initially.
    expect(find.byType(Drawer), findsNothing);

    // Tap the drawer icon to open the drawer.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the drawer is open.
    expect(find.byType(Drawer), findsOneWidget);
    //Verify that it went to InfoScreen
    expect(find.byType(Info), findsOneWidget);
    await tester.tap(find.text("About"));
    await tester.pumpAndSettle();
    expect(find.byType(AboutScreen), findsOneWidget);
  });
}