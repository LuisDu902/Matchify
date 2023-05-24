import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matchify/backend/auth.dart';

import 'package:matchify/pages/sidebar/about.dart';
import 'package:matchify/pages/sidebar/addFriends.dart';
import 'package:matchify/pages/sidebar/friends.dart';
import 'package:matchify/pages/sidebar/library.dart';
import '../../backend/variables.dart';

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
           DarkMode.isDarkModeEnabled ? const Color.fromRGBO(28, 28, 28, 1): const Color.fromRGBO(73, 43, 124, 1);

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
            children: const [
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
        const Padding(
          padding: EdgeInsets.only(left: 24, top: 20, bottom: 16),
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
                builder: (context) => const FriendsScreen(),
              ),
            );
          },
          leading: const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              key: Key("friends"),
              CupertinoIcons.person_3_fill,
              color: Colors.white,
            ),
          ),
          title: const Text("Friends", style: TextStyle(color: Colors.white)),
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
        const Padding(
          padding: EdgeInsets.only(left: 24, top: 20, bottom: 16),
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
                builder: (context) => const AddFriendsScreen(),
              ),
            );
          },
          leading: const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              key: Key('add friend'),
              CupertinoIcons.person_add_solid,
              color: Colors.white,
            ),
          ),
          title: const Text("Add friend", style: TextStyle(color: Colors.white)),
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
        const Padding(
          padding: EdgeInsets.only(left: 24, top: 20, bottom: 16),
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
                builder: (context) => const AboutScreen(),
              ),
            );
          },
          leading: const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              CupertinoIcons.info_circle_fill,
              color: Colors.white,
            ),
          ),
          title: const Text("About", style: TextStyle(color: Colors.white)),
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
        child: const ListTile(
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