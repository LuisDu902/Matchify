import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/main.dart';
import 'package:matchify/song/song.dart';
import 'package:matchify/song/swipe.dart';
import 'package:flutter/material.dart';


void main() {
  group('_SwipeState', () {
    test('fetchSong returns list of songs for 2 genres', () async {
      runApp(MyApp());
      final swipePage = SwipePage();
      final genre1 = 'Rock';
      final genre2 = 'Pop';
      List<String> filters=[];
      filters.add(genre1);
      filters.add(genre2);
      await fetchSongs(filters);
      expect(songs.length,2);
    });

    test('fetchSong returns only music from specific genre',() async{
      runApp(MyApp());
      final swipePage = SwipePage();
      final swipeState = swipePage.createState();
      final genre1 = 'Classical';
      final genre2 = 'Jazz';
      List<String> filters=[];
      filters.add(genre1);
      filters.add(genre2);
      songs.clear();
      await fetchSongs(filters);
      for(int i=0;i< songs.length;i++){
        expect(filters.contains(songs[i].genre),true );
      }
    });

   /*testWidgets('Test Dismissible Widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SwipePage()));
      final SwipeState swipeState= tester.state<SwipeState>(find.byType(SwipePage));
   
      var dismissibleFinder =  find.byWidget(Dismissible(key: UniqueKey(), child: Align()));
      expect(dismissibleFinder, findsOneWidget);

      var songIndex = 0;
      var currentSong = swipeState.songs[songIndex];

      await tester.drag(dismissibleFinder, Offset(1000.0, 0.0));
      await tester.pumpAndSettle();

    // Check if the song is added to the disliked list
      expect(getDislikedSongs().contains(currentSong),true);

      songIndex++;
      currentSong = swipeState.songs[songIndex];

      await tester.drag(dismissibleFinder, Offset(-1000.0, 0.0));
      await tester.pumpAndSettle();

      // Check if the song is added to the liked list
      expect(getLikedSongs().contains(currentSong), true);
  });*/
  });
}

