import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/appBar/appBar.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'package:matchify/authentication/auth.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<String> playlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Info(),
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'My Playlists',
              style: TextStyle(
                color: Color.fromRGBO(48, 21, 81, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 64),
            playlist.isEmpty
                ? Column(
                    children: [
                      Text(
                        "Looks like you haven't created any playlists yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(28, 27, 31, 1),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "But don't miss out on the fun! Start creating your own personalized playlists and discover new music that you'll love.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(28, 27, 31, 1),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      // Add your playlist content here
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
