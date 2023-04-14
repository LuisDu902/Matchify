import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/appBar/appBar.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'package:matchify/authentication/auth.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

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
              'Our app allows you to discover and curate your own perfect soundtrack with just a few swipes. Count also with the ability to export your playlists to Spotify and combine them with different users all around the world.',
              style: TextStyle(
                color: Color.fromRGBO(48, 21, 81, 1),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 16),
            Text(
              'Discover new music, create playlists that perfectly match your taste, and share your music journey with friends, all in one place',
              style: TextStyle(
                color: Color.fromRGBO(48, 21, 81, 1),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'You can filter by decade, choose your favorite genres, and set the mood for your playlist.',
              style: TextStyle(
                color: Color.fromRGBO(48, 21, 81, 1),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
           
            SizedBox(height: 16),
            Text(
              'Need help or have a question? Contact us anytime for assistance at matchifyesof@gmail.com',
              style: TextStyle(
                color: Color.fromRGBO(48, 21, 81, 1),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
