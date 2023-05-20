import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/backend/variables.dart';
import 'package:matchify/pages/filters.dart';

import '../mock.dart';
void main() {
  setupFirebaseAuthMocks();
  setUp(() async {
    await Firebase.initializeApp();
    chosenFilters.clear();
    playlistSize=0;
  });
     testWidgets('Filters widget has three buttons, but one is invisible', (WidgetTester tester) async {
      
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Filters(),
        ),
      ));
      expect(find.byType(ElevatedButton), findsNWidgets(3));
      expect(find.text('Continue'), findsNothing);
      expect(find.text('Genre'), findsOneWidget);
      expect(find.text('Decade'), findsOneWidget);
    });
    testWidgets('selecting a genre adds it to the filters list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Filters(),
      ));
      expect(chosenFilters, isEmpty);
      await tester.tap(find.text('Genre'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rock'));
      await tester.pumpAndSettle();
      expect(chosenFilters, equals(['Rock']));
    });
    testWidgets('Clicking on a Decade item updates the filter list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Filters(),
      ));
      // Find and tap the Decade button
      await tester.tap(find.text('Decade'));
      await tester.pumpAndSettle();

      // Find and tap a Decade item
      await tester.tap(find.text('1970\'s'));
      await tester.pumpAndSettle();

      // Verify that the filter list was updated with the selected item
      expect(chosenFilters, equals(['1970\'s']));
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
    playlistSize=5;
    await tester.tap(find.text('Genre'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rock'));
    await tester.pumpAndSettle();
    // Check that the "Continue" button is now visible.
    expect(find.text('Continue'), findsOneWidget);
    });
    /*
    testWidgets('After Selecting at least one filter,go to swipe.dart page', (WidgetTester tester) async{
      await tester.pumpWidget(
        MaterialApp(
          home: Filters(),
        ),
      );

      // Check that the "Continue" button is not initially visible.
      expect(find.text('Continue'), findsNothing);

      // Tap the "Filter" button to open the filter selection page.
      playlistSize=5;
      await tester.tap(find.text('Genre'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rock'));
      await tester.pumpAndSettle();
      // Check that the "Continue" button is now visible.
      expect(find.text('Continue'), findsOneWidget);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.byType(SwipePage), findsOneWidget);
    });*/

  testWidgets('selectSize validator returns error for invalid values', (WidgetTester tester) async {
    DarkMode.isDarkModeEnabled=false;
    await tester.pumpWidget(MaterialApp(home:Filters()));
    await tester.enterText(find.byType(TextFormField), '');
    await tester.pumpAndSettle();
    expect(find.text('size'), findsOneWidget);
    expect(playlistSize, 0);
    // Test non-numeric value
    await tester.enterText(find.byType(TextFormField), 'abc');
    await tester.pumpAndSettle();
    expect(find.text('size'), findsOneWidget);
    expect(playlistSize, 0);
    // Test out of range value
    await tester.enterText(find.byType(TextFormField), '100');
    await tester.pumpAndSettle();
    expect(find.text('size'), findsOneWidget);
    expect(playlistSize, 0);
    // Test valid value
    await tester.enterText(find.byType(TextFormField), '30');
    await tester.pumpAndSettle();
    expect(playlistSize, 30);
  });

}