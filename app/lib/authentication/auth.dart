import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class Auth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

   FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  
  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

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
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final RegExp regex = RegExp(r'^([^@]+)@');
    final usernameMatch = regex.firstMatch(email);
    final username = usernameMatch != null ? usernameMatch.group(1) : email;
  

    await firebaseDatabase
        .reference()
        .child('users')
        .child(username as String)
        .set({"email": email,
        "requests": {},
        "friends" : {},
        "playlists" : {}});
  }


 

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> deleteAccount() async {
   if (currentUser != null) {
    await currentUser!.delete();
  }
  }
}
