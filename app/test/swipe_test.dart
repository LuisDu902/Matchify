import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/main.dart';
import 'package:matchify/song/swipe.dart';


void main() {
  group('_SwipeState', () {
    test('fetchSong returns list of songs for 2 genres', () async {
      runApp(MyApp());
      final swipePage = SwipePage();
      final swipeState = swipePage.createState();
      final genre1 = 'Rock';
      final genre2 = 'Pop';
      List<String> filters=[];
      filters.add(genre1);
      filters.add(genre2);
      await swipeState.fetchSongs(filters);
      expect(swipeState.songs.length,2);
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
      await swipeState.fetchSongs(filters);
      for(int i=0;i< swipeState.songs.length;i++){
        expect(filters.contains(swipeState.songs[i].genre),true );
      }
    });
  });
}

