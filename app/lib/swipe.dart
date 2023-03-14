import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'filters.dart';
import 'infoScreen.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<SwipePage> {
  List<String> songs = [];

  List<String> liked = [];
  List<String> disliked = [];
  int index = 0;
  String songName = '';
  void _showResults(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Results'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: liked.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(liked[index]),
                        leading: Icon(Icons.thumb_up),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: disliked.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(disliked[index]),
                        leading: Icon(Icons.thumb_down),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<List<String>> fetchSongs(List<String> filters) async {
    for (int i = 0; i < filters.length; i++) {
      String filter = filters[i];
      Query ref = FirebaseDatabase.instance.ref().child(filter);
      final snapshot = await ref.get();
      if (snapshot.exists) {
        List<String> songsList = snapshot.children.map((child) {
          return child.value as String;
        }).toList();
        if (songs.length < 15) songs = List.from(songs)..addAll(songsList);
      } else {
        return [];
      }
    }

    return songs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSongs(filters),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          bool isDismissed = false;
          return Scaffold(
            drawer: Info(),
            appBar: AppBar(
              toolbarHeight: 80,
              centerTitle: true,
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text(
                  'Matchify',
                  style: TextStyle(
                    color: Color.fromRGBO(48, 21, 81, 1),
                    fontFamily: 'Italiana',
                    fontSize: 30,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const ImageIcon(
                    AssetImage('images/settings.png'),
                    color: Colors.black,
                    size: 100,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const ImageIcon(
                    AssetImage('images/user.png'),
                    color: Colors.black,
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 452,
                height: 918,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 360,
                      left: 100,
                      child: Text(
                        '${songs[index]}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(48, 21, 81, 1),
                          fontFamily: 'Istok Web',
                          fontSize: 25,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ),
                    Dismissible(
                      key: UniqueKey(),
                      direction:
                          DismissDirection.horizontal, // Swipe left to dismiss
                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.startToEnd &&
                            !isDismissed) {
                          setState(() {
                            if (songs.length == index) {
                              _showResults(context);
                            } else {

                              songName = songs[index++];

                              disliked.add(songName);
                               if (songs.length == index) {
                                 _showResults(context);
                               }
                            }
                            isDismissed = true;
                          });
                        } else if (direction == DismissDirection.endToStart &&
                            !isDismissed)
                          setState(() {
                            if (songs.length == index) {
                              _showResults(context);
                            } else {
                              songName = songs[index++];
                              liked.add(songName);
                              if (liked.length == 5 || index == songs.length) {
                                _showResults(context);
                              }
                            }
                            isDismissed = true;
                          });
                      },
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 300),
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/musicSymbol.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 400,
                      left: 170,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/replay.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 600,
                      left: 44,
                      child: Divider(
                        color: Color.fromRGBO(48, 21, 81, 1),
                        thickness: 1,
                      ),
                    ),
                    Positioned(
                      top: 500,
                      left: 284,
                      child: Divider(
                        color: Color.fromRGBO(48, 21, 81, 1),
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
                      ),
                    ),
                    Positioned(
                      top: 460,
                      left: 235,
                      child: Container(
                        width: 90,
                        height: 85,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(237, 138, 10, 1),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(90, 85),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 480,
                      left: 70,
                      child: Container(
                        width: 61,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/like.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 480,
                      left: 250,
                      child: Container(
                        width: 61,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/dislike.png'),
                            fit: BoxFit.fitWidth,
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
