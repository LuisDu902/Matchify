import 'dart:html';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/filters.dart';
import 'package:matchify/main.dart';
import 'package:matchify/song/finalPlaylistScreen.dart';
import 'package:matchify/song/song.dart';
import 'package:matchify/song/swipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




void main() {
   WidgetsFlutterBinding.ensureInitialized(); 
   runApp(MyApp());
    test('fetchSong returns list of songs for 2 genres', () async {
      
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
      
      final swipePage = SwipePage();
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

    test('Playlist size matches selected number',() async {
        final swipePage = SwipePage();
        playlistSize=30;
        fillPlaylist();
        expect(liked.length, 30);
    }); 
}

