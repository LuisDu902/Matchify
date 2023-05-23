import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matchify/backend/variables.dart';
import 'package:matchify/main.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:matchify/backend/auth.dart';
import 'package:matchify/backend/song.dart';
import 'package:matchify/backend/playlist.dart';

// Mock FirebaseDatabase instance
class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

void main() {
  group('Playlist', () {
    late Playlist playlist;

    setUp(() {
      runApp(MyApp());
      playlist = Playlist(
        name: 'My Playlist',
        imgUrl: 'https://example.com/image.jpg',
        songs: [],
      );
    });

    test('Equality of two playlists', () {
      final playlist1 = Playlist(
        name: 'Playlist 1',
        imgUrl: 'https://example.com/playlist1.jpg',
        songs: [],
      );

      final playlist2 = Playlist(
        name: 'Playlist 1',
        imgUrl: 'https://example.com/playlist1.jpg',
        songs: [],
      );

      expect(playlist1 == playlist2, true);
      expect(playlist1.hashCode == playlist2.hashCode, true);
    });

    test('Filling playlist with songs', () async {
      // Mocking the searchSong function
      Song mockSong = Song(
            trackName: 'Shape of You',
            artistName: 'Ed Sheeran',
            genre: 'Pop',
            imageUrl: 'https://i.scdn.co/image/ab67616d0000b273e0c612f2d6289c6f2e44ebd6',
            previewUrl: 'https://p.scdn.co/mp3-preview/9b7a7ce8f2d8f0a7a1f1db4e1a9ef6c2a51db6ff',
      );


      // Mocking the chosenFilters and playlistSize variables
      chosenFilters = ['Pop'];
      playlistSize = 5;

      // Mocking the liked and disliked song sets
      liked = [mockSong];
      disliked = [];

      List<Song> songs = await fillPlaylist();

      expect(songs.length, playlistSize);
      expect(songs.contains(mockSong), true);
    });

    test('Mixing two playlists', () {
      final playlist1 = Playlist(
        name: 'Playlist 1',
        imgUrl: 'https://example.com/playlist1.jpg',
        songs: [
          Song(
            trackName: 'Song 1',
            artistName: 'Artist 1',
            genre: 'Pop',
            imageUrl: 'https://example.com/song1.jpg',
            previewUrl: 'https://example.com/song1.mp3',
          ),
        ],
      );

      final playlist2 = Playlist(
        name: 'Playlist 2',
        imgUrl: 'https://example.com/playlist2.jpg',
        songs: [
          Song(
            trackName: 'Song 2',
            artistName: 'Artist 2',
            genre: 'Rock',
            imageUrl: 'https://example.com/song2.jpg',
            previewUrl: 'https://example.com/song2.mp3',
          ),
        ],
      );

      Playlist mixedPlaylist = mixPlaylist(playlist1, playlist2);

      expect(mixedPlaylist.name, 'Mixed playlist');
      expect(mixedPlaylist.imgUrl, playlist1.imgUrl);
      expect(mixedPlaylist.songs.length, 2);
    });

  });
  }