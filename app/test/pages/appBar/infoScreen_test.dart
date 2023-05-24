import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/pages/sidebar/about.dart';

import '../../mock.dart';


void main() {
  setupFirebaseAuthMocks();
  group('Info widget tests', () {
    late Widget testWidget;

    setUp(() async {
      await Firebase.initializeApp();
        testWidget = MaterialApp(
        home: Info(),
      );
    });

    testWidgets('Drawer should have four cards', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      expect(find.byType(LibraryCard), findsOneWidget);
      expect(find.byType(FriendsCard), findsOneWidget);
      expect(find.byType(AddFriendCard), findsOneWidget);
      expect(find.byType(AboutCard), findsOneWidget);
    });

    testWidgets('Tapping on about card should navigate to AboutScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      final Finder aboutCard = find.byType(AboutCard);
      await tester.tap(aboutCard);

      await tester.pumpAndSettle();

      expect(find.byType(AboutScreen), findsOneWidget);
    });
});}
