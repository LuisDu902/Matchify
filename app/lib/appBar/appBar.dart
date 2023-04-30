import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matchify/appBar/profileScreen.dart';
import '../authentication/auth.dart';
import '../homeScreen.dart';
import '../constants.dart';

class appBar extends StatefulWidget implements PreferredSizeWidget {
  const appBar({Key? key}) : super(key: key);

  @override
  _appBarState createState() => _appBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _appBarState extends State<appBar> {
  late Color bgColor;
  late Color textColor;
  late Color mixPlaylistColor;

  @override
  void initState() {
    super.initState();
    updateColors();
  }

  void updateColors() {
    setState(() {
      bgColor =
          DarkMode.isDarkModeEnabled ? Color.fromRGBO(59, 59, 59, 1) : Colors.white;
      textColor =  DarkMode.isDarkModeEnabled ? Colors.white : Colors.black;
      mixPlaylistColor =  DarkMode.isDarkModeEnabled
          ? Color.fromARGB(255, 255, 255, 255)
          : Color.fromRGBO(73, 43, 124, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: textColor,
                width: 2.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '   Matchify   ',
              style: TextStyle(
                color: textColor,
                fontFamily: 'Italiana',
                fontSize: 30,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              key : Key("side bar"),
              Icons.menu,
              color: textColor,
              size: 30,
            )),
      ),
      actions: [
        IconButton(
          key: Key('profile'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          },
          icon:  Icon(
            Icons.person,
            color: textColor,
            size: 30,
          ),
        ),
      ],
      backgroundColor: bgColor,
      elevation: 0,
    );
  }
}
