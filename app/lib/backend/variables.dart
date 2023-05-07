import 'dart:math';

import 'package:matchify/backend/playlist.dart';
import 'package:matchify/backend/song.dart';

class DarkMode {
  static bool isDarkModeEnabled = false;
}

Random random = Random();

List<Song> liked = [];
List<Song> disliked = [];
List<String> friends = [];
List<String> requests = [];
List<String> chosenFilters = [];
List<Song> displaySongs = [];
var token = "";
int playlistSize = 0;

Map<String, String> queries = {
  'Pop': 'genre:pop',
  'Funk': 'genre:funk',
  'Rock': 'genre:rock',
  'Heavy metal': 'genre:metal',
  'Country': 'genre:country',
  'Reggaeton': 'genre:reggaeton',
  'Jazz': 'genre:jazz',
  'Rap': 'genre:rap',
  'Soul': 'genre:soul',
  'Punk': 'genre:punk',
  'Folk': 'genre:folk',
  'Dream pop': 'genre:dream pop',
  'EDM': 'genre:electronic',
  '1970\'s': 'year:1970-1979',
  '1980\'s': 'year:1980-1989',
  '1990\'s': 'year:1990-1999',
  '2000\'s': 'year:2000-2009',
  '2010\'s': 'year:2010-2019',
};

List<String> iniGenres = [
  'Pop',
  'Reggaeton',
  'Funk',
  'Rock',
  'Heavy metal',
  'Country',
  'Jazz',
  'Rap',
  'EDM',
  'Soul',
  'Punk',
  'Folk',
  'Dream pop'
];
List<String> iniDecades = [
  '1970\'s',
  '1980\'s',
  '1990\'s',
  '2000\'s',
  '2010\'s'
];

late Playlist firstPlaylist;
late Playlist secondPlaylist;
bool isFirstPlaylist = true;
late Playlist mixedPlaylist;

int mixedPlaylistSize = 0;
