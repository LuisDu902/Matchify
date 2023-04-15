import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchify/authentication/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
     Navigator.pushNamedAndRemoveUntil(context, '/widget_tree', (route) => false);
  }

  Future<void> deleteAccount() async {
    await Auth().deleteAccount();
    Navigator.pushNamedAndRemoveUntil(context, '/widget_tree', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Auth().getUsername(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signOut,
              child: Text('Sign Out'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: deleteAccount,
              child: Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
