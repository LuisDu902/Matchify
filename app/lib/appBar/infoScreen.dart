import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matchify/authentication/auth.dart';

import 'package:matchify/sidebar/about.dart';
import 'package:matchify/sidebar/addFriends.dart';
import 'package:matchify/sidebar/friends.dart';
import 'package:matchify/sidebar/library.dart';
import '../constants.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  //darkmode
  late Color bgColor;
  

  @override
  void initState() {
    super.initState();
    updateColors();
  }

  void updateColors() {
    setState(() {
      bgColor =
           DarkMode.isDarkModeEnabled ? Color.fromRGBO(28, 28, 28, 1): Color.fromRGBO(73, 43, 124, 1);

     
          
    });
  }

  
//rest of code
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 288,
        height: double.infinity,
        color: bgColor,
        child: SafeArea(
          child: Column(
            children: [
              LibraryCard(),
              FriendsCard(),
              AddFriendCard(),
              AboutCard(),
              
            ],
          ),
        ),
      ),
    );
  }
}

class FriendsCard extends StatelessWidget {
  const FriendsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 20, bottom: 16),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FriendsScreen(),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              key: Key("friends"),
              CupertinoIcons.person_3_fill,
              color: Colors.white,
            ),
          ),
          title: Text("Friends", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class AddFriendCard extends StatelessWidget {
  const AddFriendCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 20, bottom: 16),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        ListTile(
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFriendsScreen(),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              key: Key('add friend'),
              CupertinoIcons.person_add_solid,
              color: Colors.white,
            ),
          ),
          title: Text("Add friend", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class AboutCard extends StatelessWidget {
  const AboutCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 20, bottom: 16),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        ListTile(
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutScreen(),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              CupertinoIcons.info_circle_fill,
              color: Colors.white,
            ),
          ),
          title: Text("About", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class LibraryCard extends StatelessWidget {
  const LibraryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LibraryScreen(username: Auth().getUsername())),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              key: Key('library'),
              CupertinoIcons.music_albums_fill,
              color: Colors.white,
            ),
          ),
          title: Text("Library", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}