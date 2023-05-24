import 'package:flutter/material.dart';
import 'package:matchify/pages/appBar/appBar.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/backend/auth.dart';
import 'package:matchify/backend/requests.dart';
import '../../backend/variables.dart';

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({super.key});

  @override
  _AddFriendsPageScreen createState() => _AddFriendsPageScreen();
}

class _AddFriendsPageScreen extends State<AddFriendsScreen> {
  //darkmode
  late Color bgColor;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    updateColors();
  }

  void updateColors() {
    setState(() {
      bgColor = DarkMode.isDarkModeEnabled
          ? const Color.fromRGBO(59, 59, 59, 1)
          : const Color.fromRGBO(255, 255, 255, 1);
      textColor = DarkMode.isDarkModeEnabled
          ? const Color.fromRGBO(255, 255, 255, 1)
          : const Color.fromRGBO(48, 21, 81, 1);
    });
  }

  final TextEditingController friendRequest = TextEditingController();


  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> message(
      String message, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("add friend page"),
      drawer: const Info(),
      appBar: const appBar(),
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Send a friend request!',
              style: TextStyle(fontSize: 24, color: textColor),
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                Container(
                  width: 300,
                  height: 40,
                  decoration: const BoxDecoration(
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
                          key: const Key("friend's username"),
                          controller: friendRequest,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Enter your friend\'s username',
                            hintStyle:
                                TextStyle(color: Color.fromRGBO(28, 27, 31, 1)),
                            filled: true,
                            fillColor: Color.fromRGBO(231, 224, 236, 1),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ElevatedButton(
                          key: const Key("send request"),
                          onPressed: () async {
                            if (friendRequest.text.isEmpty) {
                              message("Please enter your friend's username",
                                  Colors.red);
                            } else {
                              if (!await userExists(friendRequest.text)) {
                                message("The user does not exist", Colors.red);
                              } else if (Auth().getUsername() == friendRequest.text) {
                               message("You can't send a request to yourself", Colors.red);
                              } else if (await isAlreadyFriend(friendRequest.text)) {
                                message("${friendRequest.text} is already your friend", Colors.red);
                              } else {
                                sendRequest(friendRequest.text);
                                message("Friend request sent", Colors.green);
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(246, 217, 18, 1),
                            ),
                          ),
                          child: const Text(
                            'Send',
                            style: TextStyle(
                              color: Color.fromRGBO(48, 21, 81, 1),
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
      ),
    );
  }
}
