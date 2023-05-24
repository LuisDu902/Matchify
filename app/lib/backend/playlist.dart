import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:matchify/backend/auth.dart';
import 'package:matchify/backend/song.dart';

import 'variables.dart';


class Playlist {
  final String name;
  final String imgUrl;
  final List<Song> songs;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Playlist && name == other.name && imgUrl == other.imgUrl;

  @override
  int get hashCode => name.hashCode ^ imgUrl.hashCode;

  Playlist({required this.name, required this.imgUrl, required this.songs});
}

Future<List<Song>> fillPlaylist() async {
  Set<Song> set_songs = {};
  set_songs.addAll(liked);

  while (set_songs.length != playlistSize && chosenFilters.isNotEmpty) {
    Song song = await searchSong(
        chosenFilters.elementAt(Random().nextInt(chosenFilters.length)));
    if (!disliked.contains(song)) {
      set_songs.add(song);
    }
  }
  liked = set_songs.toList();
  return set_songs.toList();
}

Playlist mixPlaylist(Playlist playlist1, Playlist playlist2) {
  Set<Song> mixedSongs = {};
  mixedSongs.addAll(playlist1.songs);
  mixedSongs.addAll(playlist2.songs);
  List<Song> finalList = mixedSongs.toList();
  finalList.shuffle();
  return Playlist(name: "Mixed playlist", imgUrl: playlist1.imgUrl, songs: finalList);
}

void savePlaylist(String playlistName, List<Song> songs) async {
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

void removePlaylist(String playlistName) async {
  final database = FirebaseDatabase.instance;

  final playlistsRef = database
      .ref()
      .child('users')
      .child(Auth().getUsername())
      .child('playlists')
      .child(playlistName);

   try {
    await playlistsRef.remove();
    ('Playlist removed successfully.');
  } catch (error) {
    ('Failed to remove playlist: $error');
  }
}
