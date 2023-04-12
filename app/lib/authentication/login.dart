import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../appBar.dart';
import '../infoScreen.dart';
import 'auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hasChosen = false;
  bool _isChecked = false;
  String? errorMessage = '';

  bool isLogin = true;

  final TextEditingController _logUsername = TextEditingController();
  final TextEditingController _logPassword = TextEditingController();

  final TextEditingController _regUsername = TextEditingController();
  final TextEditingController _regPassword = TextEditingController();
  final TextEditingController _confPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _regUsername.text,
        password: _regPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _registerUsername() {
    return SizedBox(
      key: Key("emailfield"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _regUsername,
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
    );
  }

  Widget _registerPassword() {
    return SizedBox(
      key: Key("passwordfield"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _regPassword,
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
    );
  }

  Widget _confirmPassword() {
    return SizedBox(
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _confPassword,
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
        validator: (value) {
          if (value != _regPassword.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  Widget _termsAndConditions() {
    return Row(
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
    );
  }

  Widget _registerButton() {
    return Container(
      key: Key("registerbutton"),
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
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(246, 217, 18, 1)),
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
                    fontWeight: FontWeight.w400,
                  )),
        ),
        onPressed: createUserWithEmailAndPassword,
        child: Text('register'),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _logUsername.text,
        password: _logPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _loginTitle() {
    return Text(
      "Login",
      style: TextStyle(
        fontSize: 50,
        fontFamily: 'Roboto',
        letterSpacing: 0.10000000149011612,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(48, 21, 81, 1),
      ),
    );
  }

  Widget _registerTitle() {
    return Text(
      "Register",
      style: TextStyle(
        fontSize: 50,
        fontFamily: 'Roboto',
        letterSpacing: 0.10000000149011612,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(246, 217, 18, 1),
      ),
    );
  }

  Widget _loginUsername() {
    return SizedBox(
      key: Key("username"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _logUsername,
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
    );
  }

  Widget _loginPassword() {
    return SizedBox(
      key: Key("password"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _logPassword,
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
    );
  }

  Widget _loginButton() {
    return Container(
      key: Key("Log In"),
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
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(48, 21, 81, 1)),
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
        onPressed: signInWithEmailAndPassword,
        child: Text('login'),
      ),
    );
  }

  Widget change() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text("change"));
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return Scaffold(
        key: Key("Log In Page"),
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 110),
              _loginTitle(),
              SizedBox(height: 50),
              _loginUsername(),
              _loginPassword(),
              SizedBox(height: 30),
              _errorMessage(),
              SizedBox(height: 10),
              _loginButton(),
              change(),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        drawer: Info(),
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 110),
              _registerTitle(),
              SizedBox(height: 50),
              _registerUsername(),
              _registerPassword(),
              _confirmPassword(),
              _termsAndConditions(),
              SizedBox(height: 30),
              _errorMessage(),
              _registerButton(),
              change(),
            ],
          ),
        ),
      );
    }
  }
}
