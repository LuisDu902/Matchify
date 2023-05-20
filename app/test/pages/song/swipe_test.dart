import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/backend/variables.dart';
import 'package:matchify/pages/filters.dart';
import 'package:matchify/main.dart';
import 'package:matchify/pages/song/finalPlaylistScreen.dart';
import 'package:matchify/backend/song.dart';
import 'package:matchify/pages/song/swipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matchify/backend/playlist.dart';
void main() {
  test('fetchSong returns list of songs for 2 genres', () async {
    runApp(MyApp());
    final swipePage = SwipePage();
    final genre1 = 'Rock';
    final genre2 = 'Pop';
    chosenFilters.clear();
    chosenFilters.add(genre1);
    chosenFilters.add(genre2);
      displaySongs.clear();
    await fetchSongs();
    expect(displaySongs.length, 2);
  });

  test('fetchSong returns only music from specific genre', () async {
    runApp(MyApp());
    final swipePage = SwipePage();
    final genre1 = 'Jazz';
    final genre2 = 'Rap';
    chosenFilters.clear();
    chosenFilters.add(genre1);
    chosenFilters.add(genre2);
    displaySongs.clear();
    await fetchSongs();
    for (int i = 0; i < displaySongs.length; i++) {
      expect(chosenFilters.contains(displaySongs[i].genre), true);
    }
  });
}
