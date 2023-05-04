import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchify/song/song.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import '../authentication/auth.dart';
import 'swipe.dart';
import '../constants.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;


const String CLIENT_ID = '8427839fc6f24145ba2a8f64fb7f2b70';
const String CLIENT_SECRET = '2ca2a40a1ca24b878f213108e730cfc7';
const String REDIRECT_URI = 'https://matchify.com/callback';
const String SCOPE =
    'user-read-private user-read-email playlist-modify-public playlist-modify-private';



class FinalPlaylistScreen extends StatefulWidget {
  const FinalPlaylistScreen({Key? key});

  @override
  _FinalPlaylistScreenState createState() => _FinalPlaylistScreenState();
}

class _FinalPlaylistScreenState extends State<FinalPlaylistScreen> {
//darkmode
  late Color bgColor;
  late Color textColor;
  List<String> songsUri=[];
  String exportText='';
  String exportString='';
  @override
  void initState() {
    super.initState();
    updateColors();
    _loadPlaylist();
  }
   List<String> _accessToken=[];

  Future<void> _authorize() async {
    final String authEndpoint = 'https://accounts.spotify.com/authorize';
    final String params =
        '?response_type=code&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI&scope=$SCOPE';

    final String url = authEndpoint + params;

    final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: REDIRECT_URI);
    final RegExp regExp = RegExp(r'(?<=code=)[^&]*');
    final String? code = regExp.stringMatch(result);

    await _getToken(code!);
  }
  

  Future<void> _getToken(String code) async {
    final String tokenEndpoint = 'https://accounts.spotify.com/api/token';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$CLIENT_ID:$CLIENT_SECRET'));

    final http.Response response = await http.post(
      Uri.parse(tokenEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': basicAuth,
      },
      body: <String, String>{
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': REDIRECT_URI,
      },
    );

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String accessToken = responseData['access_token'];
    setState(() {
      _accessToken.add(accessToken);
    });
  }
  void updateColors() {
    setState(() {
      bgColor = DarkMode.isDarkModeEnabled
          ? Color.fromRGBO(59, 59, 59, 1)
          : Colors.white;

      textColor = DarkMode.isDarkModeEnabled
          ? //Color.fromRGBO(68, 47, 100, 1)
          Colors.white
          :Color.fromRGBO(48, 21, 81, 1) ;
    });
  }

  List<Song> songs = [];
  String playlistName = "New Playlist";

  void _loadPlaylist() async {
    List<Song> newSongs = await fillPlaylist();

    setState(() {
      songs = newSongs;
    });
  }

  void savePlaylist() async {
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

  void createPlaylist(String spotifyId) async {
    String token= _accessToken[0];
    var url = Uri.parse('https://api.spotify.com/v1/users/$spotifyId/playlists');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var body = {
      'name': '$playlistName',
      'description': 'New playlist description',
      'public': false,
    };
 
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 201) {
      final dynamic responseData = jsonDecode(response.body);
      final String playlistId = responseData["id"];
      url=Uri.parse('htps://api.spotify.com/v1/playlists/$playlistId/tracks');
       headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
      };
      var body = {
      'uris': songsUri,
      'position':0,
      };
      response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
      );
      if(response.statusCode==201){
        print("Success");
      }
  } else {
    throw Exception("Failed to create playlist: ${response.body}");
  }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("final playlist"),
      drawer: Info(),
      appBar: appBar(),
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.0),
                if (songs.isNotEmpty)
                  Center(
                    child: Image.network(
                      songs[0].imageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(height: 30.0),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: TextField(
                      maxLength: 15,
                      onChanged: (value) {
                        if (value.length > 15) {
                          value = value.substring(0, 20);
                        }
                        setState(() {
                          playlistName = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "New Playlist",
                        hintStyle: TextStyle(
                          color: textColor,
                          fontFamily: 'Roboto',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit,
                              color: textColor,
                            ),
                            SizedBox(width: 16.0),
                            GestureDetector(
  onTap: savePlaylist,
  child: Material(
    color: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
      side: BorderSide(color: textColor),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.save,
        color: textColor,
      ),
    ),
  ),
),

                            SizedBox(width: 16.0),
                            IconButton(
                              onPressed: () async {
                                if(_accessToken.isNotEmpty){
                                  exportText = ( await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Export Playlist'),
                                        content: TextFormField(
                                          onChanged: (value) {
                                            exportString = value;
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Enter export text',
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              createPlaylist(exportString);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Export'),
                                          ),
                                        ],
                                      );
                                    },
                                  ))!;
                                }
                                else {
                                  _authorize();
                                }
                              },
                              icon: Icon(Icons.file_download),
                            ),
                          ],
                        ),
                      ),
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'Roboto',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        Container(
  height: 400,
  child: ListView.builder(
    itemCount: songs.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(60.0, 8.0, 16.0, 8.0),
        child: Text(
          '${index + 1}. ${songs[index].trackName} by ${songs[index].artistName}',
          style: TextStyle(
            fontSize: 16.0,
            color: textColor,
          ),
        ),
      );
    },
  ),
),ListView(
  shrinkWrap: true,
  children: [
    SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(60.0, 8.0, 16.0, 8.0),
            child: Text(
              '${index + 1}. ${songs[index].trackName} by ${songs[index].artistName}',
              style: TextStyle(
                fontSize: 16.0,
                color: textColor,
              ),
            ),
          );
        },
      ),
    ),
  ],
),

          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(60.0, 8.0, 16.0, 8.0),
                  child: Text(
                    '${index + 1}. ${songs[index].trackName} by ${songs[index].artistName}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(48, 21, 81, 1),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
