import 'dart:io';

import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchify/backend/playlist.dart';
import 'package:matchify/backend/song.dart';
import '../../backend/export.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import '../../backend/auth.dart';
import 'swipe.dart';
import '../../backend/variables.dart';

class FinalPlaylistScreen extends StatefulWidget {
  const FinalPlaylistScreen({Key? key});

  @override
  _FinalPlaylistScreenState createState() => _FinalPlaylistScreenState();
}

class _FinalPlaylistScreenState extends State<FinalPlaylistScreen> {
//darkmode
  late Color bgColor;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    updateColors();
    _loadPlaylist();
  }

  void updateColors() {
    setState(() {
      bgColor = DarkMode.isDarkModeEnabled
          ? Color.fromRGBO(59, 59, 59, 1)
          : Colors.white;

      textColor = DarkMode.isDarkModeEnabled
          ? Colors.white
          : Color.fromRGBO(48, 21, 81, 1);
    });
  }
 
  List<Song> songs = [];
  String playlistName = "New Playlist";

  Future<List<Song>> _loadPlaylist() async {
    List<Song> newSongs = await fillPlaylist();

    setState(() {
      songs = newSongs;
    });
    return songs;
  }

  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: _loadPlaylist(),
    builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
      if (snapshot.hasData) {
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
                              onTap: () => savePlaylist(playlistName, songs),
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
                                export(songs,playlistName);
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
          ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 330,
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
        ],
      ),
    );
      } else {
        // Show a loading indicator while waiting for the _loadPlaylist() method to complete.
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
    
}


