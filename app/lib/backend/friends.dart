import 'package:firebase_database/firebase_database.dart';
import 'package:matchify/backend/requests.dart';
import 'package:matchify/backend/variables.dart';

import 'auth.dart';

Future<List<String>> fetchFriends() async {
  List<String> data = [];

  final database = FirebaseDatabase.instance;
  Query ref = database
      .ref()
      .child('users')
      .child(Auth().getUsername())
      .child('friends');
  final snapshot = await ref.get();
  friends.clear();
  if (snapshot.exists) {
    List<String> friendsList = snapshot.children.map((child) {
      return child.value as String;
    }).toList();
    data = List.from(data)..addAll(friendsList);
  }
  friends = data;
  return friends;
}

Future<List<List<String>>> getFriends() async {
  friends = await fetchFriends();
  requests = await fetchRequests();
  return [friends, requests];
}

void removeFriend(int index) {
  String friend = friends.elementAt(index);
  final userRef = FirebaseDatabase.instance
      .ref()
      .child('users')
      .child(Auth().getUsername());
  final friendRef =
      FirebaseDatabase.instance.ref().child('users').child(friend);

  userRef.child('friends').child(friend).remove();
  friendRef.child('friends').child(Auth().getUsername()).remove();
}
