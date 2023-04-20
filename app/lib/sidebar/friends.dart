import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchify/appBar/appBar.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'package:matchify/authentication/auth.dart';
import 'package:matchify/sidebar/library.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final user = Auth().currentUser;
  final username = Auth().getUsername();
  bool isResquest = false;

  Color requestColor = Colors.white;
  Color friendColor = Color.fromRGBO(48, 21, 81, 1);
  Color requestText = Color.fromRGBO(48, 21, 81, 1);
  Color friendText = Colors.white;

  List<String> friends = [];
  List<String> requests = [];

  Future<List<String>> fetchFriends() async {
    final database = FirebaseDatabase.instance;
    Query ref = database.ref().child('users').child(username).child('friends');
    final snapshot = await ref.get();
    friends.clear();
    if (snapshot.exists) {
      List<String> friendsList = snapshot.children.map((child) {
        return child.value as String;
      }).toList();
      friends = List.from(friends)..addAll(friendsList);
    }
    return friends;
  }

  Future<List<String>> fetchRequests() async {
    final database = FirebaseDatabase.instance;
    Query ref =
        database.reference().child('users').child(username).child('requests');
    final snapshot = await ref.get();
    requests.clear();

    if (snapshot.exists) {
      List<String> requestsList = snapshot.children.map((child) {
        return child.value as String;
      }).toList();
      requests = List.from(requests)..addAll(requestsList);
    }
    return requests;
  }

  Future<List<List<String>>> getFriends() async {
    friends = await fetchFriends();
    requests = await fetchRequests();
    return [friends, requests];
  }

  void removeFriend(int index) {
    String friend = friends.elementAt(index);
    final userRef =
        FirebaseDatabase.instance.reference().child('users').child(username);
    final friendRef =
        FirebaseDatabase.instance.reference().child('users').child(friend);

    userRef.child('friends').child(friend).remove();
    friendRef.child('friends').child(username).remove();

    setState(() {
      friends.removeAt(index);
    });
  }

  Widget popUp(int index) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(252, 241, 183, 1),
      content: Text(
        textAlign: TextAlign.center,
        "Are you sure you want to remove ${friends[index]}?",
        style: TextStyle(
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
        padding: EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 182, 202, 1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color.fromRGBO(193, 182, 202, 1),
          ),
        ),
        child: Center(
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
        Navigator.of(context).pop();
      },
      child: Container(
        height: 60.0,
        padding: EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 182, 202, 1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color.fromRGBO(193, 182, 202, 1),
          ),
        ),
        child: Center(
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
          ),
        ),
      );
    } else
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 16.0),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 8.0),
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
                              builder: (context) =>
                                  LibraryScreen(username: friends[index])),
                        );
                      },
                      child: Text(
                        friends[index],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
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

  void removeRequest(int index) {
    String request = requests.elementAt(index);
    DatabaseReference requestRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(username)
        .child('requests');

    requestRef.child(request).remove();

    setState(() {
      requests.removeAt(index);
    });
  }

  void acceptRequest(int index) {
    final acceptedRequest = requests.elementAt(index);
    removeRequest(index);
    final userRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(username)
        .child('friends');

    final friendRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(acceptedRequest)
        .child('friends');

    friendRef.update({username: username});
    userRef.update({acceptedRequest: acceptedRequest});
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
          ),
        ),
      );
    } else
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 16.0),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 8.0),
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
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        acceptRequest(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        removeRequest(index);
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

  Widget buttons() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
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
                  requestColor = Colors.white;
                  requestText = Color.fromRGBO(48, 21, 81, 1);
                  friendColor = Color.fromRGBO(48, 21, 81, 1);
                  friendText = Colors.white;
                });
              },
              child: Text(
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
            padding: EdgeInsets.symmetric(
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
                  requestColor = Color.fromRGBO(246, 217, 18, 1);
                  requestText = Color.fromRGBO(48, 21, 81, 1);
                  friendColor = Colors.white;
                  friendText = Color.fromRGBO(48, 21, 81, 1);
                });
              },
              child: Text(
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
            drawer: Info(),
            appBar: appBar(),
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttons(),
                isResquest ? showRequests() : showFriends(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching friends'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}