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
  final user = Auth().currentUser;
  final username = Auth().getUsername();
  final TextEditingController friendRequest = TextEditingController();

  Future<bool> userExists() async {
    final database = FirebaseDatabase.instance;
    Query ref = database.ref().child('users').child(friendRequest.text);
    final snapshot = await ref.get();

    return snapshot.exists;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> message(
      String message, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<bool> isAlreadyFriend() async {
    final database = FirebaseDatabase.instance;
    Query ref = database
        .ref()
        .child('users')
        .child(username)
        .child('friends')
        .child(friendRequest.text);
    final snapshot = await ref.get();
    return snapshot.exists;
  }

  Future<void> sendRequest() async {
    final database = FirebaseDatabase.instance;
    final friendRef = database
        .ref()
        .child('users')
        .child(friendRequest.text)
        .child('requests');
    friendRef.update({username: username});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key("add friend page"),
        drawer: Info(),
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Send a friend request!',
                style: TextStyle(
                    fontSize: 24, color: Color.fromRGBO(48, 21, 81, 1)),
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
                            key: Key("friend's username"),
                            controller: friendRequest,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Enter your friend\'s username',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(28, 27, 31, 1)),
                              filled: true,
                              fillColor: Color.fromRGBO(231, 224, 236, 1),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: ElevatedButton(
                            key: Key("send request"),
                            onPressed: () async {
                              if (friendRequest.text.isEmpty) {
                                message("Please enter your friend's username",
                                    Colors.red);
                              } else {
                                if (!await userExists()) {
                                  message(
                                      "The user does not exist", Colors.red);
                                } else if (username == friendRequest.text) {
                                  message(
                                      "You can't send a request to yourself",
                                      Colors.red);
                                } else if (await isAlreadyFriend()) {
                                  message(
                                      friendRequest.text +
                                          " is already your friend",
                                      Colors.red);
                                } else {
                                  sendRequest();
                                  message("Friend request sent", Colors.green);
                                }
                              }
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
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
