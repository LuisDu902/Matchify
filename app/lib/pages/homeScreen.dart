import 'package:flutter/material.dart';
import 'package:matchify/pages/filters.dart';
import 'package:matchify/pages/mixPlaylist/firstMixPlaylist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appBar/appBar.dart';
import 'appBar/infoScreen.dart';
import '../backend/variables.dart';

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
      bgColor = DarkMode.isDarkModeEnabled
          ? const Color.fromRGBO(59, 59, 59, 1)
          : Colors.white;
      textColor = DarkMode.isDarkModeEnabled ? Colors.white : Colors.black;
      mixPlaylistColor = DarkMode.isDarkModeEnabled
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color.fromRGBO(73, 43, 124, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("home page"),
      drawer: const Info(),
      appBar: const appBar(),
      backgroundColor: bgColor,
      body: SizedBox(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 250,
              left: 36,
              child: GestureDetector(
                onTap: () {
                  chosenFilters.clear();
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirstMixPlaylistScreen()),
                  );
                },
                child: Container(
                  width: 154,
                  height: 147,
                  decoration: BoxDecoration(
                    color: mixPlaylistColor,
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(154, 147),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              key: const Key("create a new playlist"),
              top: 280,
              left: 75,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Filters()),
                  );
                },
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    width: 80,
                    height: 85,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/add.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              key: const Key("mix playlist"),
              top: 270,
              left: 250,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirstMixPlaylistScreen()),
                  );
                },
                child: Opacity(
                  opacity:
                      0.7, // Adjust the opacity value as needed (0.0 - 1.0)
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
                    letterSpacing: 0,
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
