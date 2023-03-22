import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appBar.dart';
import 'homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBar(),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 110),
            Text(
              "Register",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Roboto',
                letterSpacing: 0.10000000149011612,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(246, 217, 18, 1),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 260,
              height: 80,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.10000000149011612,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'username',
                  hintStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 260,
              height: 80,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.10000000149011612,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'password',
                  hintStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(
              width: 260,
              height: 80,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.10000000149011612,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'confirm password',
                  hintStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                obscureText: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                Text(
                  "I Accept Terms & Conditions of Matchify",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(246, 217, 18, 1)),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(48, 21, 81, 1),
                ),
                fixedSize: MaterialStateProperty.resolveWith<Size?>(
                    (states) => Size(130, 45)),
                textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                    (states) => TextStyle(
                          fontSize: 25,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.10000000149011612,
                          fontWeight: FontWeight.w500,
                        )),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Text('register'),
            ),
          ],
        ),
      ),
    );
  }
}
