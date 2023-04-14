import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:matchify/song/song.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import '../filters.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<SwipePage> {
  List<Song> songs = [];

  List<String> liked = [];
  List<String> disliked = [];
  int index = 0;
  String songName = '';

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

  Future<void> _searchSong(String genre) async {
    var queryParameters = {
      'q': 'genre:"$genre"',
      'type': 'track',
      'limit': '50',
      'offset': '${Random().nextInt(100)}'
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
          genre: genre,
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

  void _showResults(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Results'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: liked.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(liked[index]),
                        leading: Icon(Icons.thumb_up),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: disliked.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(disliked[index]),
                        leading: Icon(Icons.thumb_down),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<List<Song>> fetchSongs(List<String> filters) async {
    for (int i = 0; i < filters.length; i++) {
      String filter = filters[i];
      //for (int j = 0; j < 50; j++) {
      await _searchSong(filter);
      await _searchSong(filter);
      //}
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
                      left: 100,
                      child: Text(
                        '${songs[index].trackName} - ${songs[index].genre}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(48, 21, 81, 1),
                          fontFamily: 'Istok Web',
                          fontSize: 25,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ),
                    Dismissible(
                      key: UniqueKey(),
                      direction:
                          DismissDirection.horizontal, 
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.startToEnd &&
                            !isDismissed) {
                          setState(() {
                            if (songs.length == index) {
                              _showResults(context);
                            } else {
                              songs[index].pause();
                              songName = songs[index++].trackName;

                              disliked.add(songName);
                              if (songs.length == index) {
                                _showResults(context);
                              }
                            }
                            isDismissed = true;
                          });
                        } else if (direction == DismissDirection.endToStart &&
                            !isDismissed)
                          setState(() {
                            if (songs.length == index) {
                              _showResults(context);
                            } else {
                              songs[index].pause();
                              songName = songs[index++].trackName;
                              liked.add(songName);
                              if (liked.length == 5 || index == songs.length) {
                                _showResults(context);
                              }
                            }
                            isDismissed = true;
                          });
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
                        key: Key("play"),
                        icon: Icon(Icons.play_arrow_rounded),
                        iconSize: 45,
                        onPressed: () {
                          songs[index].play();
                          // Handle replay button press
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
                      left: 235,
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
                      top: 480,
                      left: 250,
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