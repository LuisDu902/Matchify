import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appBar.dart';
import 'homeScreen.dart';
import 'login.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBar(),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 200),
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
                      Color.fromRGBO(246, 217, 18, 1)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(48, 21, 81, 1),
                  ),
                  fixedSize: MaterialStateProperty.resolveWith<Size?>(
                      (states) => Size(200, 65)),
                  textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                      (states) => TextStyle(
                            fontSize: 30,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.10000000149011612,
                            fontWeight: FontWeight.w500,
                          )),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 80),
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
                    Colors.white,
                  ),
                  fixedSize: MaterialStateProperty.resolveWith<Size?>(
                      (states) => Size(200, 65)),
                  textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                      (states) => TextStyle(
                            fontSize: 30,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.10000000149011612,
                            fontWeight: FontWeight.w400,
                          )),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
