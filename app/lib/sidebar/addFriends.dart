import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/appBar/appBar.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'package:matchify/authentication/auth.dart';

class AddFriendsScreen extends StatefulWidget {
  @override
  _AddFriendsPageScreen createState() => _AddFriendsPageScreen();
}

class _AddFriendsPageScreen extends State<AddFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Info(),
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Send a friend request!',
        style:
            TextStyle(fontSize: 24, color: Color.fromRGBO(48, 21, 81, 1)),
      ),
      SizedBox(height: 16),
      Stack(
        children: [
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(103, 80, 164, 1),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.left, // align the text to the left
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              10), // add padding to the left and right of the text
                      hintText: 'Enter your friend\'s username',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(
                              28, 27, 31, 1)), // set the hint text color
                      filled: true, // fill the background color of the TextField
                      fillColor: Color.fromRGBO(231, 224, 236,
                          1), // set the background color of the TextField
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: () {
                // add your button functionality here
              },
              child: Text(
                'Send',
                style: TextStyle(
                  color: Color.fromRGBO(48, 21, 81, 1),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(246, 217, 18, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  ),
)






    );
  }
}
