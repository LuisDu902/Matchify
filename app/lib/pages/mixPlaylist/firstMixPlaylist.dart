import 'package:flutter/material.dart';
import 'package:matchify/pages/appBar/appBar.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/pages/mixPlaylist/mixPlaylist.dart';
import '../../backend/variables.dart';
import 'mixFromUserLibrary.dart';

class FirstMixPlaylistScreen extends StatefulWidget {
  const FirstMixPlaylistScreen({super.key});

  @override
  FirstMixPlaylistScreenState createState() => FirstMixPlaylistScreenState();
}

class FirstMixPlaylistScreenState extends State<FirstMixPlaylistScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('mix playlist page'),
      drawer: const Info(),
      appBar: const appBar(),
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250.0,
              height: 130.0,
              child: ElevatedButton(
                key: const Key('mix my own playlist'),
                onPressed: () {
                  isFirstPlaylist = true;
                  // Navigate to screen where user can mix their own playlist
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MixFromUserLibraryScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(246, 217, 18, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Mix my own playlist',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(48, 21, 81, 1),
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: 250.0,
              height: 130.0,
              child: ElevatedButton(
                key: const Key('mix playlists with friend'),
                onPressed: () {
                  // Navigate to screen where user can mix playlists with friends
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MixPlaylistScreen()),
                );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(48, 21, 81, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Mix playlists with friend',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
