import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:matchify/pages/song/finalPlaylistScreen.dart';
import 'package:matchify/backend/song.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import '../appBar/appBar.dart';
import '../appBar/infoScreen.dart';
import '../filters.dart';
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
          ? Color.fromRGBO(59, 59, 59, 1)
          : Colors.white;

      textColor = DarkMode.isDarkModeEnabled
          ? Colors.white
          : Color.fromRGBO(48, 21, 81, 1);
    });
  }

  late Song currentSong;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: Key('swipe page'), 
      future: fetchSongs(),
      builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
        if (snapshot.hasData) {
          bool isDismissed = false;
          return Scaffold(
            drawer: Info(),
            appBar: appBar(),
            backgroundColor: bgColor,
            body: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 452,
                height: 918,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 360,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 30,
                        child: ScrollLoopAutoScroll(
                          scrollDirection: Axis.horizontal,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 25.0,
                                color: textColor,
                                fontFamily: 'Istok Web',
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${displaySongs[index].trackName}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: ' - '),
                                TextSpan(
                                  text: '${displaySongs[index].artistName}',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
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
                                  builder: (context) => FinalPlaylistScreen(),
                                ),
                              );
                            }
                            isDismissed = true;
                          });
                        }
                      },
                      child: Center(
                        key: Key("song image"),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 300),
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
                      top: 400,
                      left: 170,
                      child: IconButton(
                        key: Key('play'), 
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
                    ),
                    Positioned(
                      top: 600,
                      left: 44,
                      child: Divider(
                        color: textColor,
                        thickness: 1,
                      ),
                    ),
                    Positioned(
                      top: 500,
                      left: 284,
                      child: Divider(
                        color: textColor,
                        thickness: 1,
                      ),
                    ),
                    Positioned(
                      top: 460,
                      left: 55,
                      child: Container(
                        width: 90,
                        height: 85,
                        decoration: BoxDecoration(
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
                      top: 460,
                      left: 260,
                      child: Container(
                        width: 90,
                        height: 85,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(237, 138, 10, 1),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(90, 85),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: textColor,
                            size: 60,
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
          return Center(
            child: Text('Error fetching songs'),
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