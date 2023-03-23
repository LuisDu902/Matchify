import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../appBar.dart';
import 'login.dart';
import 'register.dart';
import 'widget_tree.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

bool isLogin = true;

bool getLogin() {
  return isLogin;
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
                      builder: (context) => WidgetTree(),
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
                  isLogin = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WidgetTree(),
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
