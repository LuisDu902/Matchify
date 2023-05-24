import 'package:flutter/material.dart';
import 'package:matchify/backend/playlist.dart';
import 'package:matchify/backend/song.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import '../../backend/variables.dart';

class FinalMixPlaylistScreen extends StatefulWidget {
  const FinalMixPlaylistScreen({Key? key});

  @override
  _FinalMixPlaylistScreenState createState() => _FinalMixPlaylistScreenState();
}

class _FinalMixPlaylistScreenState extends State<FinalMixPlaylistScreen> {
//darkmode
  late Color bgColor;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    updateColors();
    createMixPlaylist();
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

  List<Song> songs = [];
  String playlistName = "Mixed Playlist";

  void createMixPlaylist() async {
    mixedPlaylist = mixPlaylist(firstPlaylist, secondPlaylist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("final mixed playlist page"),
      drawer: const Info(),
      appBar: const appBar(),
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30.0),
                if (songs.isNotEmpty)
                  Center(
                    child: Image.network(
                      songs[0].imageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 30.0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
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
                        hintText: "Mixed Playlist",
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
                            const SizedBox(width: 16.0),
                            GestureDetector(
                              onTap: () => savePlaylist(playlistName, mixedPlaylist.songs),
                              child: Material(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  side: BorderSide(color: textColor),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.save,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
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
                height: 500,
                child: ListView.builder(
                  itemCount: mixedPlaylist.songs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(60.0, 8.0, 16.0, 8.0),
                      child: Text(
                        '${index + 1}. ${mixedPlaylist.songs[index].trackName} by ${mixedPlaylist.songs[index].artistName}',
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
  }
}
