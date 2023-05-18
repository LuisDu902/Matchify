import 'package:firebase_database/firebase_database.dart';
import 'package:matchify/backend/variables.dart';

import 'auth.dart';

Future<bool> isAlreadyFriend(String friend) async {
  final database = FirebaseDatabase.instance;
  Query ref = database
      .ref()
      .child('users')
      .child(Auth().getUsername())
      .child('friends')
      .child(friend);
  final snapshot = await ref.get();
  return snapshot.exists;
}

Future<bool> userExists(String user) async {
  final database = FirebaseDatabase.instance;
  Query ref = database.ref().child('users').child(user);
  final snapshot = await ref.get();

  return snapshot.exists;
}

Future<void> sendRequest(String friend) async {
  final database = FirebaseDatabase.instance;
  final friendRef =
      database.ref().child('users').child(friend).child('requests');
  friendRef.update({Auth().getUsername(): Auth().getUsername()});
}

Future<List<String>> fetchRequests() async {
  List<String> data = [];
  final database = FirebaseDatabase.instance;
  Query ref = database
      .reference()
      .child('users')
      .child(Auth().getUsername())
      .child('requests');
  final snapshot = await ref.get();
  requests.clear();
  if (snapshot.exists) {
    List<String> requestsList = snapshot.children.map((child) {
      return child.value as String;
    }).toList();
    data = List.from(requests)..addAll(requestsList);
  }
  requests = data;
  return requests;
}

void removeRequest(int index) {
  String request = requests.elementAt(index);
  DatabaseReference requestRef = FirebaseDatabase.instance
      .reference()
      .child('users')
      .child(Auth().getUsername())
      .child('requests');

  requestRef.child(request).remove();
}

void acceptRequest(int index) {
  final acceptedRequest = requests.elementAt(index);
  removeRequest(index);
  final userRef = FirebaseDatabase.instance
      .reference()
      .child('users')
      .child(Auth().getUsername())
      .child('friends');

  final friendRef = FirebaseDatabase.instance
      .reference()
      .child('users')
      .child(acceptedRequest)
      .child('friends');

  friendRef.update({Auth().getUsername(): Auth().getUsername()});
  userRef.update({acceptedRequest: acceptedRequest});
}
