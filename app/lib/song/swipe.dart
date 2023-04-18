import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:matchify/song/finalPlaylistScreen.dart';
import 'package:matchify/song/song.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import '../filters.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  _SwipeState createState() => _SwipeState();
}

Map<String, String> queries = {
  'Pop': 'genre:pop',
  'Funk': 'genre:funk',
  'Rock': 'genre:rock',
  'Heavy metal': 'genre:metal',
  'Classical': 'genre:classical',
  'Happy': 'genre:happy',
  'Sad': 'genre:sad',
  'Jazz': 'genre:jazz',
  'Rap': 'genre:rap',
  'EDM': 'genre:electronic',
  '70\'s': 'year:1970-1979',
  '80\'s': 'year:1980-1989',
  '90\'s': 'year:1990-1999',
  'Lonely': 'energy:0.1',
  'Calm': 'energy:0.4',
  'Energetic': 'energy:1.0'
};

List<Song> liked = [];

List<Song> getLikedSongs() {
  return liked;
}

List<Song> disliked = [];

List<Song> getDislikedSongs() {
  return disliked;
}

void clearLikedSongs() {
  liked.clear();
}

void clearDislikedSongs() {
  disliked.clear();
}

class _SwipeState extends State<SwipePage> {
  List<Song> songs = [];

  Random random = Random();
  bool play = true;
  int index = 0;

  late Song currentSong;

  Future<String> _getAccessToken() async {
    var clientId = '8427839fc6f24145ba2a8f64fb7f2b70';
    var clientSecret = '2ca2a40a1ca24b878f213108e730cfc7';

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

      return accessToken;
    } else {
      throw Exception('Failed to generate access token.');
    }
  }

  Future<void> _searchSong(String filter) async {
    var queryParameters = {
      'q': queries[filter],
      'type': 'track',
      'limit': '50',
      'offset': '${random.nextInt(100)}'
    };
    var uri = Uri.https('api.spotify.com', '/v1/search', queryParameters);
    var accessToken = await _getAccessToken();
    var headers = {'Authorization': 'Bearer $accessToken'};
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
        songs.add(song);
      } else {
        print('No songs found for the given genre.');
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<List<Song>> fetchSongs(List<String> filters) async {
    if (filters.length == 1) {
      await _searchSong(filters[0]);
    }
    for (String filter in filters) {
      await _searchSong(filter);
    }
    return songs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSongs(getFilters()),
      builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
        if (snapshot.hasData) {
          bool isDismissed = false;
          return Scaffold(
            key: Key('swipe page'),
            drawer: Info(),
            appBar: appBar(),
            backgroundColor: Colors.white,
            body: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 452,
                height: 918,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 360,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 30,
                        child: ScrollLoopAutoScroll(
                          scrollDirection: Axis.horizontal,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Color.fromRGBO(48, 21, 81, 1),
                                fontFamily: 'Istok Web',
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${songs[index].trackName}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: ' - '),
                                TextSpan(
                                  text: '${songs[index].artistName}',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.startToEnd &&
                            !isDismissed) {
                          setState(() {
                            songs[index].pause();
                            currentSong = songs[index++];
                            disliked.add(currentSong);
                            isDismissed = true;
                            play = true;
                          });
                        } else if (direction == DismissDirection.endToStart &&
                            !isDismissed) {
                          setState(() {
                            songs[index].pause();
                            currentSong = songs[index++];
                            liked.add(currentSong);
                            play = true;
                            if (liked.length == 5) {
                              clearFilters();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FinalPlaylistScreen(),
                                ),
                              );
                            }
                            isDismissed = true;
                          });
                        }
                      },
                      child: Center(
                        key: Key("song image"),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 300),
                          child: Image.network(
                            songs[index].imageUrl,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 400,
                      left: 170,
                      child: IconButton(
                        icon: play ? Icon(Icons.play_arrow_rounded) : Icon(Icons.pause_rounded),
                        iconSize: 45,
                        onPressed: () {
                          if (play) {
                            songs[index].play();
                            play = false;
                          }
                          else {
                            songs[index].pause();
                            play = true;
                          }
                          // Handle replay button press
                          setState((){});
                        },
                      ),
                    ),
                    Positioned(
                      top: 600,
                      left: 44,
                      child: Divider(
                        color: Color.fromRGBO(48, 21, 81, 1),
                        thickness: 1,
                      ),
                    ),
                    Positioned(
                      top: 500,
                      left: 284,
                      child: Divider(
                        color: Color.fromRGBO(48, 21, 81, 1),
                        thickness: 1,
                      ),
                    ),
                    Positioned(
                      top: 460,
                      left: 55,
                      child: Container(
                        width: 90,
                        height: 85,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(246, 217, 18, 1),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(90, 85),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 460,
                      left: 260,
                      child: Container(
                        width: 90,
                        height: 85,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(237, 138, 10, 1),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(90, 85),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 480,
                      left: 70,
                      child: Container(
                        width: 61,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/like.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 478,
                      left: 275,
                      child: Container(
                        width: 61,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/dislike.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching songs'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
