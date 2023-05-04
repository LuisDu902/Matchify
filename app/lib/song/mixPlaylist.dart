import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/appBar/appBar.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'package:matchify/authentication/auth.dart';
import '../constants.dart';
import 'package:matchify/sidebar/library.dart';

class MixPlaylistScreen extends StatefulWidget {
  @override
  _MixPlaylistScreenState createState() => _MixPlaylistScreenState();
}

class _MixPlaylistScreenState extends State<MixPlaylistScreen> {
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

  late Color friendColor = textColor;

  late Color friendText = bgColor;

  List<String> friends = [];

  Future<List<String>> fetchFriends() async {
    final database = FirebaseDatabase.instance;
    Query ref = database.ref().child('users').child(username).child('friends');
    final snapshot = await ref.get();
    friends.clear();
    if (snapshot.exists) {
      List<String> friendsList = snapshot.children.map((child) {
        return child.value as String;
      }).toList();
      friends = List.from(friends)..addAll(friendsList);
    }
    return friends;
  }

  Future<List<String>> getFriends() async {
    friends = await fetchFriends();

    return friends;
  }

  Widget showFriends() {
    if (friends.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Text(
          "Looks like you haven't added any friends yet. Why not add some?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 16.0),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 8.0),
            shrinkWrap: true,
            itemCount: friends.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LibraryScreen(
                              username: friends[index],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        friends[index],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 8.0), // add padding between each friend's name
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }

  Widget buttons() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: friendColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              key: Key("friends button"),
              "Friends",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 32.0,
                color: friendText,
              ),
            ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFriends(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: Key("friends page"),
            drawer: Info(),
            appBar: appBar(),
            backgroundColor: bgColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttons(),
                showFriends(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching friends'),
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
