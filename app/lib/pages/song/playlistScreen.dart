import 'package:flutter/material.dart';
import 'package:matchify/backend/auth.dart';
import 'package:matchify/pages/appBar/appBar.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/backend/playlist.dart';
import 'package:matchify/pages/homeScreen.dart';
import '../../backend/export.dart';
import '../../backend/variables.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;
  final String user;
  const PlaylistScreen({required this.user, required this.playlist});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
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
          : Colors.white;

      textColor = DarkMode.isDarkModeEnabled
          ? Colors.white
          : const Color.fromRGBO(48, 21, 81, 1);
    });
  }

  Widget showSongs() {
    return ListView(
      key: const Key("playlist songs"),
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 600,
          child: ListView.builder(
            itemCount: widget.playlist.songs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Image.network(
                        widget.playlist.songs[index].imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.playlist.songs[index].trackName,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.playlist.songs[index].artistName,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      color: textColor,
                      onPressed: () {
                        setState(() {
                          if (widget.playlist.songs[index].isPlaying) {
                            widget.playlist.songs[index].pause();
                          } else {
                            widget.playlist.songs[index].play();
                          }
                        });
                      },
                      icon: Icon(widget.playlist.songs[index].isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key("playlist page"),
        drawer: const Info(),
        appBar: const appBar(),
        body: Container(
          color: bgColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.playlist.name,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        export(widget.playlist.songs, widget.playlist.name);
                      },
                      icon: Icon(Icons.file_download, color: textColor),
                    ),
                    if (widget.user == Auth().getUsername())
                    IconButton(
                      onPressed: () async {
                        removePlaylist(widget.playlist.name);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      icon: Icon(Icons.delete, color: textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                showSongs(),
              ],
            ),
          ),
        ));
  }
}
