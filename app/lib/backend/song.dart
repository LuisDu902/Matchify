import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

import 'variables.dart';

class Song {
  AudioPlayer audioPlayer = AudioPlayer();
  final String trackName;
  final String artistName;
  final String genre;
  final String previewUrl;
  final String imageUrl;

  bool isPlaying = false;

  Song({
    required this.trackName,
    required this.artistName,
    required this.genre,
    required this.previewUrl,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song &&
          trackName == other.trackName &&
          artistName == other.artistName;

  @override
  int get hashCode => trackName.hashCode ^ artistName.hashCode;

  void play() {
    isPlaying = true;
    audioPlayer.play(UrlSource(previewUrl));
  }

  void pause() {
    isPlaying = false;
    audioPlayer.pause();
  }

  static Random random = Random();

}

Future<void> getAccessToken() async {
    var clientId = '6df51150706949b3aa9a0b31297151cf';
    var clientSecret = '5a7317dbd6014b99938e040303b05907';

    var credentials = '$clientId:$clientSecret';
    var bytes = utf8.encode(credentials);
    var base64 = base64Encode(bytes);

    var headers = {'Authorization': 'Basic $base64'};
    var body = {'grant_type': 'client_credentials'};

    var response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var accessToken = jsonResponse['access_token'];

      token = accessToken;
    } else {
      throw Exception('Failed to generate access token.');
    }
  }

  Future<Song> searchSong(String filter) async {
    var queryParameters = {
      'q': queries[filter],
      'type': 'track',
      'limit': '50',
      'offset': '${random.nextInt(100)}'
    };
    var uri = Uri.https('api.spotify.com', '/v1/search', queryParameters);
    var headers = {'Authorization': 'Bearer $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['tracks']['items'].isNotEmpty) {
        var trackIndex =
            Random().nextInt(jsonResponse['tracks']['items'].length);
        var trackName = jsonResponse['tracks']['items'][trackIndex]['name'];
        var artistName =
            jsonResponse['tracks']['items'][trackIndex]['artists'][0]['name'];
        var previewUrl =
            jsonResponse['tracks']['items'][trackIndex]['preview_url'];
        var imageUrl = jsonResponse['tracks']['items'][trackIndex]['album']
            ['images'][0]['url'];

        Song song = Song(
          trackName: trackName,
          artistName: artistName,
          genre: filter,
          previewUrl: previewUrl,
          imageUrl: imageUrl,
        );
        return song;
      }
    }
    return Song(
        trackName: '', artistName: '', genre: '', previewUrl: '', imageUrl: '');
  }

  Future<List<Song>> fetchSongs() async {
    if (chosenFilters.length == 1) {
      Song song = await searchSong(chosenFilters[0]);
      displaySongs.add(song);
    }
    for (String filter in chosenFilters) {
      Song song = await searchSong(filter);
      while (displaySongs.contains(song) || liked.contains(song) || disliked.contains(song)) {
        song = await searchSong(filter);
      }
      displaySongs.add(song);
    }
    return displaySongs;
  }