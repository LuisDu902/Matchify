import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String getUsername() {
    final RegExp regex = RegExp(r'^([^@]+)@');
    final usernameMatch = regex.firstMatch(currentUser?.email as String);
    final username = usernameMatch != null ? usernameMatch.group(1) : currentUser?.email as String;

    return username as String;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final RegExp regex = RegExp(r'^([^@]+)@');
    final usernameMatch = regex.firstMatch(email);
    final username = usernameMatch != null ? usernameMatch.group(1) : email;
  

    await _firebaseDatabase
        .reference()
        .child('users')
        .child(username as String)
        .set({"email": email,
        "requests": {},
        "friends" : {},
        "playlists" : {}});
  }


  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/widget_tree', (route) => false);
  }

  Future<void> deleteAccount(BuildContext context) async {
    await currentUser?.delete();
     Navigator.pushNamedAndRemoveUntil(context, '/widget_tree', (route) => false);
  }
}
