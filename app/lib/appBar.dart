import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'homeScreen.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  const appBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
