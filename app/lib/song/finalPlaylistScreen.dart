import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchify/song/song.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import '../authentication/auth.dart';
import 'swipe.dart';

class FinalPlaylistScreen extends StatefulWidget {
  const FinalPlaylistScreen({Key? key});

  @override
  _FinalPlaylistScreenState createState() => _FinalPlaylistScreenState();
}

class _FinalPlaylistScreenState extends State<FinalPlaylistScreen> {
  List<Song> songs = [];
  String playlistName = "New Playlist";

  @override
  void initState() {
    super.initState();
    _loadPlaylist();
  }

  void savePlaylist() async {
    
    final database = FirebaseDatabase.instance;
    
    final playlistsRef = database
        .ref()
        .child('users')
        .child(Auth().getUsername())
        .child('playlists')
        .child(playlistName);
    
    for (Song song in songs){
      String trackName = song.trackName.replaceAll(RegExp(r'[.#$\[\]]'), '');

     playlistsRef.update({trackName: {
      'artistName' : song.artistName,
      'genre' : song.genre,
      'image' : song.imageUrl,
      'preview' : song.previewUrl
     }});
    }
   

  }

  void _loadPlaylist() async {
    List<Song> newSongs = await fillPlaylist();

    setState(() {
      songs = newSongs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("final playlist"),
      drawer: Info(),
      appBar: appBar(),
      backgroundColor: Colors.white,
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
                          color: Color.fromRGBO(73, 43, 124, 1),
                          fontFamily: 'Roboto',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: Color.fromRGBO(48, 21, 81, 1),
                        ),
                      ),
                      style: TextStyle(
                        color: Color.fromRGBO(73, 43, 124, 1),
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
          ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(224, 217, 228, 1)),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(48, 21, 81, 1),
                ),
                fixedSize: MaterialStateProperty.resolveWith<Size?>(
                    (states) => Size(240, 50)),
                textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                    (states) => TextStyle(
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.10000000149011612,
                        )),
              ),
              onPressed: savePlaylist,
              child: Text('Save'),
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
