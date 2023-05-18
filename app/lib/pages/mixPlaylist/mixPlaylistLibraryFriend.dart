import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/pages/appBar/appBar.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/backend/auth.dart';
import 'package:matchify/backend/library.dart';
import 'package:matchify/pages/homeScreen.dart';
import 'package:matchify/backend/playlist.dart';
import 'package:matchify/pages/mixPlaylist/mixFromUserLibrary.dart';
import 'package:matchify/pages/song/playlistScreen.dart';
import '../../backend/variables.dart';

import '../../backend/song.dart';

class MixPlaylistLibraryFriendScreen extends StatefulWidget {
  final String username;

  MixPlaylistLibraryFriendScreen({required this.username});

  @override
  _MixPlaylistLibraryFriendScreenState createState() =>
      _MixPlaylistLibraryFriendScreenState();
}

class _MixPlaylistLibraryFriendScreenState
    extends State<MixPlaylistLibraryFriendScreen> {
  //darkmode
  late Color bgColor;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    updateColors();
  }

  void updateColors() {
    setState(() {
      bgColor = DarkMode.isDarkModeEnabled
          ? Color.fromRGBO(59, 59, 59, 1)
          : Color.fromRGBO(255, 255, 255, 1);
      textColor = DarkMode.isDarkModeEnabled
          ? Color.fromRGBO(255, 255, 255, 1)
          : Color.fromRGBO(48, 21, 81, 1);
    });
  }

  List<Playlist> library = [];

  Widget emptyLibrary() {
    return Text(
      "Looks like your friend does not have any playlists",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: 20,
      ),
    );
  }

  Widget showPlaylists() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        children: library.map((playlist) {
          return GestureDetector(
            onTap: () {
              firstPlaylist = playlist;
              isFirstPlaylist = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MixFromUserLibraryScreen(
                          
                        )),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.network(
                    key: Key(playlist.name),
                    playlist.imgUrl,
                    fit: BoxFit.contain,
                    width: 146,
                    height: 146,
                  ),
                  SizedBox(height: 20),
                  Text(
                    playlist.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchLibrary(library,widget.username),
      builder: (BuildContext context, AsyncSnapshot<List<Playlist>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: Key(""),
            drawer: Info(),
            appBar: appBar(),
            backgroundColor: bgColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Mix with ' + widget.username + '\'s Library',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 64),
                  (library.isEmpty) ? emptyLibrary() : showPlaylists(),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching library'),
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