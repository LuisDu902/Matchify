import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/filters.dart';
import 'package:matchify/song/swipe.dart';
import 'mock.dart';
void main() {
  setupFirebaseAuthMocks();
  setUp(() async {
    await Firebase.initializeApp();
    getFilters().clear();
  });
     testWidgets('Filters widget has four buttons,but one is invisible', (WidgetTester tester) async {
      
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Filters(),
        ),
      ));
      expect(find.byType(ElevatedButton), findsNWidgets(4));
      expect(find.text('Continue'), findsNothing);
      expect(find.text('Genre'), findsOneWidget);
      expect(find.text('Decade'), findsOneWidget);
      expect(find.text('Mood'), findsOneWidget);
    });
    testWidgets('selecting a genre adds it to the filters list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Filters(),
      ));
      expect(getFilters(), isEmpty);
      await tester.tap(find.text('Genre'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rock'));
      await tester.pumpAndSettle();
      expect(getFilters(), equals(['Rock']));
    });
    testWidgets('Clicking on a Decade item updates the filter list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Filters(),
      ));
      // Find and tap the Decade button
      await tester.tap(find.text('Decade'));
      await tester.pumpAndSettle();

      // Find and tap a Decade item
      await tester.tap(find.text('70\'s'));
      await tester.pumpAndSettle();

      // Verify that the filter list was updated with the selected item
      expect(getFilters(), equals(['70\'s']));
    });
    testWidgets('selecting a mood adds it to the filters list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Filters(),
      ));
      expect(getFilters(), isEmpty);
      await tester.tap(find.text('Mood'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sad'));
      await tester.pumpAndSettle();
      expect(getFilters(), equals(['Sad']));
    });
    
    testWidgets('Test visibility of continue button', (WidgetTester tester) async {
    // Build the widget tree.
    await tester.pumpWidget(
      MaterialApp(
        home: Filters(),
      ),
    );

    // Check that the "Continue" button is not initially visible.
    expect(find.text('Continue'), findsNothing);

    // Tap the "Filter" button to open the filter selection page.
    await tester.tap(find.text('Genre'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rock'));
    await tester.pumpAndSettle();
    // Check that the "Continue" button is now visible.
    expect(find.text('Continue'), findsOneWidget);
    });
    
    testWidgets('After Selecting at least one filter,go to swipe.dart page', (WidgetTester tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home: Filters(),
        ),
      );

      // Check that the "Continue" button is not initially visible.
      expect(find.text('Continue'), findsNothing);

      // Tap the "Filter" button to open the filter selection page.
      await tester.tap(find.text('Genre'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rock'));
      await tester.pumpAndSettle();
      // Check that the "Continue" button is now visible.
      expect(find.text('Continue'), findsOneWidget);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.byType(SwipePage), findsOneWidget);
    });
}