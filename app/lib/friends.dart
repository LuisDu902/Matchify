import 'package:flutter/material.dart';
import 'package:prototype/appBar.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final List<String> friends = ['Madalene Ye', 'Luis Du'];

  void removeFriend(int index) {
    setState(() {
      friends.removeAt(index);
    });
  }

  Widget showFriends() {
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
                  Text(
                    friends[index],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      removeFriend(index);
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

  bool isResquest = false;

  final List<String> requests = ['Request 1', 'Request 2'];

  Color requestColor = Colors.white;
  Color friendColor = Color.fromRGBO(48, 21, 81, 1);
  Color requestText = Color.fromRGBO(48, 21, 81, 1);
  Color friendText = Colors.white;

  void removeRequest(int index) {
    setState(() {
      requests.removeAt(index);
    });
  }

  void acceptRequest(int index) {
    setState(() {
      friends.add(requests.elementAt(index) as String);
    });
  }

  Widget showRequests() {
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
                      removeRequest(index);
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
    return Scaffold(
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
  }
}
