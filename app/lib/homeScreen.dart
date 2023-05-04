import 'package:flutter/material.dart';
import 'package:matchify/filters.dart';
import 'song/mixPlaylist.dart';

import 'appBar/appBar.dart';
import 'appBar/infoScreen.dart';
import 'constants.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

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
    return Scaffold(
      key: Key("home page"),
      drawer: Info(),
      appBar: appBar(),
      backgroundColor: bgColor,
      body: SizedBox(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 250,
              left: 36,
              child: GestureDetector(
                onTap: () {
                   clearFilters();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Filters()),
                  );
                },
                child: Container(
                  width: 154,
                  height: 147,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(246, 217, 18, 1),
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(154, 147),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 225,
              child: GestureDetector(
                onTap: () {
                   clearFilters();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Filters()),
                  );
                },
                child: Container(
                  width: 154,
                  height: 147,
                  decoration: BoxDecoration(
                    color: mixPlaylistColor,
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(154, 147),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              key: Key("create a new playlist"),
              top: 280,
              left: 75,
              child: GestureDetector(
                onTap: () {
                   clearFilters();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Filters()),
                  );
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/add.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 270,
              left: 250,
              child: GestureDetector(
                onTap: () {
                   clearFilters();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MixPlaylistScreen()),
                  );
                },
                child: Container(
                  width: 108,
                  height: 108,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/mix.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 420,
              left: 48,
              child: Text(
                'Add playlist',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'Istok Web',
                  fontSize: 25,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ),
            Positioned(
              top: 420,
              left: 236,
              child: Text(
                'Mix playlist',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontFamily: 'Istok Web',
                    fontSize: 25,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
