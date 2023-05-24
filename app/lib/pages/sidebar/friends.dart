import 'package:flutter/material.dart';
import 'package:matchify/pages/appBar/appBar.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/backend/auth.dart';
import 'package:matchify/backend/friends.dart';
import 'package:matchify/backend/requests.dart';
import '../../backend/variables.dart';
import 'package:matchify/pages/sidebar/library.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
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

  final user = Auth().currentUser;
  final username = Auth().getUsername();
  bool isResquest = false;

  late Color requestColor = bgColor;
  late Color friendColor = textColor;
  late Color requestText = textColor;
  late Color friendText = bgColor;

  Widget popUp(int index) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(252, 241, 183, 1),
      content: Text(
        textAlign: TextAlign.center,
        "Are you sure you want to remove ${friends[index]}?",
        style: const TextStyle(
            color: Color(0xFF301551),
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontSize: 28),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            removeButton(index),
            cancelButton(index),
          ],
        ),
      ],
    );
  }

  Widget cancelButton(int index) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(193, 182, 202, 1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromRGBO(193, 182, 202, 1),
          ),
        ),
        child: const Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFF301551),
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget removeButton(int index) {
    return TextButton(
      onPressed: () {
        removeFriend(index);
        setState(() {
          friends.removeAt(index);
        });
        Navigator.of(context).pop();
      },
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(193, 182, 202, 1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromRGBO(193, 182, 202, 1),
          ),
        ),
        child: const Center(
          key: Key("remove friend"),
          child: Text(
            'Remove',
            style: TextStyle(
              color: Color(0xFF301551),
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }

 Widget showFriends() {
    if (friends.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Text(
          "Looks like you haven't added any friends yet. Why not add some?",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8.0),
            shrinkWrap: true,
            itemCount: friends.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LibraryScreen(username: friends[index]),
                          ),
                        );
                      },
                      child: Text(
                        friends[index],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: textColor, // Set the color to textColor
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return popUp(index);
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },

          ),
        ),
      );
    }
  }
  
  Widget showRequests() {
    if (requests.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Text(
          "Your friend request list is empty.\n Don't worry, you'll receive some soon!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      );
    } else {
      return Expanded(
        key: const Key("requests page"),
        child: Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8.0),
            shrinkWrap: true,
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      requests[index],
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        key: const Key("accept request"),
                        Icons.check,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        acceptRequest(index);
                        setState(() {
                          requests.removeAt(index);
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        key: const Key("decline request"),
                        Icons.clear,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        removeRequest(index);
                        setState(() {
                          requests.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }

  Widget buttons() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: friendColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isResquest = false;
                  if (!DarkMode.isDarkModeEnabled) {
                    requestColor = Colors.white;
                    requestText = const Color.fromRGBO(48, 21, 81, 1);
                    friendColor = const Color.fromRGBO(48, 21, 81, 1);
                    friendText = Colors.white;
                  } else {
                    requestColor = const Color.fromRGBO(59, 59, 59, 1);
                    requestText = Colors.white;
                    friendColor = Colors.white;
                    friendText = const Color.fromRGBO(48, 21, 81, 1);
                  }
                });
              },
              child: Text(
                key: const Key("friends button"),
                "Friends",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 32.0,
                  color: friendText,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: requestColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isResquest = true;
                  if (!DarkMode.isDarkModeEnabled) {
                    requestColor = const Color.fromRGBO(246, 217, 18, 1);
                    requestText = const Color.fromRGBO(48, 21, 81, 1);
                    friendColor = Colors.white;
                    friendText = const Color.fromRGBO(48, 21, 81, 1);
                  } else {
                    requestColor = const Color.fromRGBO(246, 217, 18, 1);
                    requestText = const Color.fromRGBO(48, 21, 81, 1);
                    friendColor = const Color.fromRGBO(59, 59, 59, 1);
                    friendText = Colors.white;
                  }
                });
              },
              child: Text(
                key: const Key("requests"),
                "Requests",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 32.0,
                  color: requestText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFriends(),
      builder:
          (BuildContext context, AsyncSnapshot<List<List<String>>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: const Key("friends page"),
            drawer: const Info(),
            appBar: const appBar(),
            backgroundColor: bgColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttons(),
                isResquest ? showRequests() : showFriends(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching friends'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
