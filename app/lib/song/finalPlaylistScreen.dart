import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchify/song/song.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import 'swipe.dart';

class FinalPlaylistScreen extends StatefulWidget {
  const FinalPlaylistScreen({Key? key});

  @override
  _FinalPlaylistScreenState createState() => _FinalPlaylistScreenState();
}

class _FinalPlaylistScreenState extends State<FinalPlaylistScreen> {
  List<Song> songs = getLikedSongs();
  String playlistName = "New Playlist";

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
