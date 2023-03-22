import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appBar.dart';
import 'homeScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              "Login",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Roboto',
                letterSpacing: 0.10000000149011612,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(48, 21, 81, 1),
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
            SizedBox(height: 5),
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
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(48, 21, 81, 1)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(255, 242, 156, 1),
                  ),
                  fixedSize: MaterialStateProperty.resolveWith<Size?>(
                      (states) => Size(130, 45)),
                  textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                      (states) => TextStyle(
                            fontSize: 25,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.10000000149011612,
                            fontWeight: FontWeight.w400,
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
                child: Text('login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
