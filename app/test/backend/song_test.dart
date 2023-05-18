import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:matchify/main.dart';
import 'package:matchify/backend/song.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(MyApp());
  test('Song should play and pause correctly', () async {
    // create a sample song
    final song = Song(
      trackName: 'Example Song',
      artistName: 'Example Artist',
      genre: 'Example Genre',
      previewUrl: 'https://example.com/example.mp3',
      imageUrl: 'https://example.com/example.jpg',
    );
    // test that the song starts playing when play() is called
    song.play();
    expect(song.isPlaying, isTrue);

    // test that the song pauses when pause() is called
    song.pause();
    expect(song.isPlaying, isFalse);
  });
}
