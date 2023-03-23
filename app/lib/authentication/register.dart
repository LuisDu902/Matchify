import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../homeScreen.dart';
import 'auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isChecked = false;
  String? errorMessage = '';

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirm = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerUsername.text,
        password: _controllerPassword.text,
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

  Widget _title() {
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

  Widget _typeUsername() {
    return SizedBox(
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _controllerUsername,
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

  Widget _typePassword() {
    return SizedBox(
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _controllerPassword,
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
        controller: _controllerConfirm,
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

   Widget _submitButton() {
    return Container(
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
        onPressed: 
          createUserWithEmailAndPassword,
        child: Text('login'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 110),
            _title(),
            SizedBox(height: 50),
            _typeUsername(),
            _typePassword(),
            _confirmPassword(),
            _termsAndConditions(),
            SizedBox(height: 30),
            _errorMessage(),
            _submitButton(),
          ],
        ),
      ),
    );
  }
}
