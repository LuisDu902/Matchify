import 'package:flutter/material.dart';
import 'package:matchify/backend/song.dart';
import 'package:matchify/backend/variables.dart';

import 'authentication/widget_tree.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAccessToken();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WidgetTree()),
      );
    });
    return Scaffold(
      key: const Key('loading page'),
      backgroundColor: DarkMode.isDarkModeEnabled ? const Color.fromRGBO(59, 59, 59, 1) : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 244,
              height: 244,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Matchify',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(246, 217, 18, 1),
                fontFamily: 'Righteous',
                fontSize: 64,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
