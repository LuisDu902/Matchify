import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:matchify/pages/song/finalPlaylistScreen.dart';
import 'package:matchify/backend/song.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import '../../backend/variables.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<SwipePage> {
  bool play = true;
  int index = 0;

  late Color bgColor;
  late Color textColor;
  late Color mixPlaylistColor;

  @override
  void initState() {
    super.initState();
    updateColors();
    displaySongs.clear();
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

  late Song currentSong;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: const Key('swipe page'),
      future: fetchSongs(),
      builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
        if (snapshot.hasData) {
          bool isDismissed = false;
          return Scaffold(
            drawer: const Info(),
            appBar: const appBar(),
            backgroundColor: bgColor,
            body: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 452,
                height: 918,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 360,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              displaySongs[index].trackName,
                              style: TextStyle(
                                fontSize: 25.0,
                                color: textColor,
                                fontFamily: 'Istok Web',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                            Text(
                              displaySongs[index].artistName,
                              style: TextStyle(
                                fontSize: 25.0,
                                color: textColor,
                                fontFamily: 'Istok Web',
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.startToEnd &&
                            !isDismissed) {
                          setState(() {
                            displaySongs[index].pause();
                            currentSong = displaySongs[index++];
                            disliked.add(currentSong);
                            isDismissed = true;
                            play = true;
                          });
                        } else if (direction == DismissDirection.endToStart &&
                            !isDismissed) {
                          setState(() {
                            displaySongs[index].pause();
                            currentSong = displaySongs[index++];
                            liked.add(currentSong);
                            play = true;
                            if (liked.length == 5) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FinalPlaylistScreen(),
                                ),
                              );
                            }
                            isDismissed = true;
                          });
                        }
                      },
                      child: Center(
                        key: const Key("song image"),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 300),
                          child: Image.network(
                            displaySongs[index].imageUrl,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 420,
                      left: 60,
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 10), // Add padding to the top of the play button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120,
                                  height: 3,
                                  color: Colors.black,
                                ),
                                IconButton(
                                  key: const Key('play'),
                                  icon: play
                                      ? Icon(Icons.play_arrow_rounded, color: textColor)
                                      : Icon(Icons.pause_rounded, color: textColor),
                                  iconSize: 45,
                                  onPressed: () {
                                    if (play) {
                                      displaySongs[index].play();
                                      play = false;
                                    } else {
                                      displaySongs[index].pause();
                                      play = true;
                                    }
                                    // Handle replay button press
                                    setState(() {});
                                  },
                                ),
                                Container(
                                  width: 120,
                                  height: 3,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 480,
                      left: 70,
                      child: Container(
                        width: 90,
                        height: 85,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(246, 217, 18, 1),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(90, 85),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.favorite,
                            color: textColor,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 480,
                      left: 260,
                      child: Container(
                        width: 90,
                        height: 85,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(237, 138, 10, 1),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(90, 85),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'X',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching songs'),
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
