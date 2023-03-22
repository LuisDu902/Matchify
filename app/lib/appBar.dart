import 'package:flutter/material.dart';

import 'homeScreen.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  const appBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(48, 21, 81, 1),
                width: 2.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '   Matchify   ',
              style: TextStyle(
                color: Color.fromRGBO(48, 21, 81, 1),
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
            icon: const Icon(
              Icons.menu,
              color: Color.fromRGBO(48, 21, 81, 1),
              size: 30,
            )),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            color: Color.fromRGBO(48, 21, 81, 1),
            size: 30,
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
