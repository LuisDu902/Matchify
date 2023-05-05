import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/backend/auth.dart';
import 'package:matchify/backend/friends.dart';
import 'package:matchify/backend/variables.dart';
import 'package:matchify/pages/appBar/appBar.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/pages/sidebar/library.dart';

import 'mixPlaylistLibraryFriend.dart';

class MixPlaylistScreen extends StatefulWidget {
  @override
  _MixPlaylistScreenState createState() => _MixPlaylistScreenState();
}

class _MixPlaylistScreenState extends State<MixPlaylistScreen> {
  //darkmode
  late Color bgColor;
  late Color textColor;
  Color buttonColor = Color.fromRGBO(103, 61, 155, 1);
  Color buttonTextColor = Color.fromRGBO(255, 255, 255, 1);

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
                  Icon(Icons.person, color: Colors.grey), // add the person icon
                  SizedBox(width: 8.0), // add padding between the icon and the name
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MixPlaylistLibraryFriendScreen(
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
                        color: textColor,
                      ),
                    ),
                  ),
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
              color: buttonColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              key: Key(""),
              "Which friend do you want to mix your playlist with?",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.0,
                color: buttonTextColor,
              ),
            ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchFriends(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: Key(""),
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
