import 'package:flutter/material.dart';
import 'package:matchify/filters.dart';

import 'appBar.dart';
import 'infoScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("Home Page"),
      drawer: Info(),
      appBar: appBar(),
      backgroundColor: Colors.white, // Set the body background color to white

      body: SizedBox(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 250,
              left: 36,
              child: GestureDetector(
                onTap: () {
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
                    MaterialPageRoute(builder: (context) => Filters()),
                  );
                },
                child: Container(
                  width: 154,
                  height: 147,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(73, 43, 124, 1),
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(154, 147),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 280,
              left: 75,
              child: GestureDetector(
                onTap: () {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Filters()),
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
            const Positioned(
              top: 420,
              left: 48,
              child: Text(
                'Add playlist',
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
            const Positioned(
              top: 420,
              left: 236,
              child: Text(
                'Mix playlist',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(48, 21, 81, 1),
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
