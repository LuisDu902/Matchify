import 'package:flutter/material.dart';
import 'package:matchify/pages/appBar/appBar.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/backend/library.dart';
import 'package:matchify/backend/playlist.dart';
import 'package:matchify/pages/song/playlistScreen.dart';
import '../../backend/variables.dart';


class LibraryScreen extends StatefulWidget {
  final String username;

  const LibraryScreen({super.key, required this.username});

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
          ? const Color.fromRGBO(59, 59, 59, 1)
          : const Color.fromRGBO(255, 255, 255, 1);
      textColor = DarkMode.isDarkModeEnabled
          ? const Color.fromRGBO(255, 255, 255, 1)
          : const Color.fromRGBO(48, 21, 81, 1);
    });
  }

  List<Playlist> library = [];

  Widget emptyLibrary() {
    return Text(
          "This library is empty",
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaylistScreen(user: widget.username,
                          playlist: playlist,
                        )),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.network(
                    key: Key(playlist.name),
                    playlist.imgUrl,
                    fit: BoxFit.contain,
                    width: 146,
                    height: 146,
                  ),
                  const SizedBox(height: 20),
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
      future: fetchLibrary(library, widget.username),
      builder: (BuildContext context, AsyncSnapshot<List<Playlist>> snapshot) {
        if (snapshot.hasData) {
            return Scaffold(
              key: const Key("library page"),
              drawer: const Info(),
              appBar: const appBar(),
              backgroundColor: bgColor,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      '${widget.username}\'s Library',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 64),
                    (library.isEmpty) ? emptyLibrary(): showPlaylists(),
                  ],
                ),
              ),
            );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching library'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
