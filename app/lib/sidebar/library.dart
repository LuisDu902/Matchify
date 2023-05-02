import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/appBar/appBar.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'package:matchify/authentication/auth.dart';
import 'package:matchify/homeScreen.dart';
import 'package:matchify/song/playlist.dart';
import 'package:matchify/song/playlistScreen.dart';
import '../constants.dart';

import '../song/song.dart';

class LibraryScreen extends StatefulWidget {
  final String username;

  LibraryScreen({required this.username});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
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

  final user = Auth().currentUser;
  final username = Auth().getUsername();

  List<Playlist> library = [];
  Future<List<Playlist>> fetchLibrary() async {
    final database = FirebaseDatabase.instance;
    final playlistRef =
        database.ref().child('users').child(widget.username).child('playlists');

    final snapshot = await playlistRef.get();
    if (snapshot.value != null) {
      final map = snapshot.value as Map;
      for (final entry in map.entries) {
        String playlist_name = entry.key;
        Map songs = entry.value;
        List<Song> listSongs = [];
        for (final song in songs.entries) {
          Map songFields = song.value;
          Song _song = Song(
            trackName: song.key,
            artistName: songFields['artistName'],
            genre: songFields['genre'],
            previewUrl: songFields['preview'],
            imageUrl: songFields['image'],
          );

          listSongs.add(_song);
        }
        Playlist _playlist = Playlist(
            name: playlist_name,
            imgUrl: listSongs[0].imageUrl,
            songs: listSongs);
        library.add(_playlist);
      }
    }
    return library;
  }

  Widget emptyLibrary() {
    return Column(
      children: [
        Text(
          "Looks like you haven't created any playlists yet.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 16),
        Text(
          "But don't miss out on the fun! Start creating your own personalized playlists and discover new music that you'll love.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ],
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaylistScreen(
                          playlist: playlist,
                        )),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.network(
                    key: Key( playlist.name),
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
      future: fetchLibrary(),
      builder: (BuildContext context, AsyncSnapshot<List<Playlist>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: Key("library page"),
            drawer: Info(),
            appBar: appBar(),
            backgroundColor: bgColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    widget.username + '\'s Library',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 64),
                  showPlaylists(),
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
