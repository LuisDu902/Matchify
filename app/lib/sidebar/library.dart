import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/appBar/appBar.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'package:matchify/authentication/auth.dart';
import 'package:matchify/song/playlist.dart';
import '../constants.dart';

import '../song/song.dart';

class LibraryScreen extends StatefulWidget {
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
      bgColor =  DarkMode.isDarkModeEnabled
          ? Color.fromRGBO(59, 59, 59, 1)
          : Color.fromRGBO(255, 255, 255, 1);
      textColor =  DarkMode.isDarkModeEnabled
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
        database.ref().child('users').child(username).child('playlists');

    final snapshot = await playlistRef.get();
    if (snapshot.value != null) {
      final map = snapshot.value as Map;
      for (final entry in map.entries) {
        String playlist_name = entry.key;
        Map songs = entry.value;
        List<Song> listSongs = [];
        for (final song in songs.entries) {
          List<String> fields = [];
          fields.add(song.key);
          Map songFields = song.value;
          for (final field in songFields.values) {
            fields.add(field);
          }
          Song _song = Song(
              trackName: fields[0],
              artistName: fields[3],
              genre: fields[4],
              previewUrl: fields[2],
              imageUrl: fields[1]);
          listSongs.add(_song);
        }
        Playlist _playlist = Playlist(name: playlist_name, songs: listSongs);
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
    List<String> images = [];
    int i = 0;
    for (final playlist in library) {
      images.add(playlist.songs[i].imageUrl);
    }
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        children: images.map((image) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.contain,
                  width: 146,
                  height: 146,
                ),
                SizedBox(height: 20),
                Text(
                  library[i++].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
            drawer: Info(),
            appBar: appBar(),
            backgroundColor: bgColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'My Playlists',
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
