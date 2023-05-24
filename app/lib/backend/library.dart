import 'package:firebase_database/firebase_database.dart';
import 'package:matchify/backend/playlist.dart';
import 'package:matchify/backend/song.dart';

Future<List<Playlist>> fetchLibrary(List<Playlist> library, String username) async {
    final database = FirebaseDatabase.instance;
    final playlistRef =
        database.ref().child('users').child(username).child('playlists');

    final snapshot = await playlistRef.get();
    if (snapshot.value != null) {
      final map = snapshot.value as Map;
      for (final entry in map.entries) {
        String playlistName = entry.key;
        Map songs = entry.value;
        List<Song> listSongs = [];
        for (final song in songs.entries) {
          Map songFields = song.value;
          Song song1 = Song(
            trackName: song.key,
            artistName: songFields['artistName'],
            genre: songFields['genre'],
            previewUrl: songFields['preview'],
            imageUrl: songFields['image'],
          );

          listSongs.add(song1);
        }
        Playlist playlist = Playlist(
            name: playlistName,
            imgUrl: listSongs[0].imageUrl,
            songs: listSongs);
        library.add(playlist);
      }
    }
    return library;
  }