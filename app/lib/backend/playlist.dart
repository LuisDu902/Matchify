import 'dart:convert' as convert;
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/backend/auth.dart';
import 'package:matchify/backend/song.dart';

import 'variables.dart';
import '../pages/filters.dart';

class Playlist {
  final String name;
  final String imgUrl;
  final List<Song> songs;

  Playlist({required this.name, required this.imgUrl, required this.songs});

  Playlist mixPlaylist(Playlist playlist2) {
    Set<Song> mixedSongs = {};
    mixedSongs.addAll(songs);
    mixedSongs.addAll(playlist2.songs);
    List<Song> finalList = mixedSongs.toList();
    finalList.shuffle();
    return Playlist(name: "Mixed playlist", imgUrl: imgUrl, songs: finalList);
  }

  static void savePlaylist(String playlistName, List<Song> songs) async {
    final database = FirebaseDatabase.instance;

    final playlistsRef = database
        .ref()
        .child('users')
        .child(Auth().getUsername())
        .child('playlists')
        .child(playlistName);

    for (Song song in songs) {
      String trackName = song.trackName.replaceAll(RegExp(r'[.#$\[\]]'), '');

      playlistsRef.update({
        trackName: {
          'artistName': song.artistName,
          'genre': song.genre,
          'image': song.imageUrl,
          'preview': song.previewUrl
        }
      });
    }
  }

  static Future<List<Song>> fillPlaylist() async {
  while (liked.length != playlistSize) {
    Song song = await searchSong(
        chosenFilters.elementAt(Random().nextInt(chosenFilters.length)));
    if (!disliked.contains(song)) {
      liked.add(song);
    }
  }
  return liked;
  }


}
