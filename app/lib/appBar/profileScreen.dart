import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchify/appBar/appBar.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'package:matchify/authentication/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/widget_tree', (route) => false);
  }

  Future<void> deleteAccount() async {
    await Auth().deleteAccount();
    Navigator.pushNamedAndRemoveUntil(
        context, '/widget_tree', (route) => false);
  }

  Widget popUp() {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(252, 241, 183, 1),
      content: Text(
        textAlign: TextAlign.center,
        "Are you sure you want to delete your account?",
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
            deleteButton(),
            cancelButton(),
          ],
        ),
      ],
    );
  }

  Widget cancelButton() {
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

  Widget deleteButton() {
    return TextButton(
      onPressed: () {
        deleteAccount();
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
            'Delete',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Info(),
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'My profile',
              style: TextStyle(
                color: Color.fromRGBO(48, 21, 81, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/6522/6522516.png',
              fit: BoxFit.contain,
              width: 250,
              height: 260,
            ),
            Text(
              Auth().getUsername(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(224, 217, 228, 1)),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(48, 21, 81, 1),
                ),
                fixedSize: MaterialStateProperty.resolveWith<Size?>(
                    (states) => Size(240, 50)),
                textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                    (states) => TextStyle(
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.10000000149011612,
                        )),
              ),
              onPressed: signOut,
              child: Text('Log out'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(224, 217, 228, 1)),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(48, 21, 81, 1),
                ),
                fixedSize: MaterialStateProperty.resolveWith<Size?>(
                    (states) => Size(240, 50)),
                textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                    (states) => TextStyle(
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.10000000149011612,
                        )),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return popUp();
                  },
                );
              },
              child: Text('Delete account'),
            ),
          ],
        ),
      ),
    );
  }
}
