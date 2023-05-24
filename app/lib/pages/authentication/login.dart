import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../backend/auth.dart';

class MyTermsAndConditionsDialog extends StatelessWidget {
  const MyTermsAndConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Terms & Conditions'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'In order to use Matchify, you must create an account. You are responsible for maintaining the confidentiality of your account information and password. You are also responsible for all activities that occur under your account.',
          ),
          SizedBox(height: 16),
          Text(
            'Matchify is provided "as is" and without warranty of any kind. We do not warrant that the application will be uninterrupted or error-free.',
          ),
          SizedBox(height: 16),
          Text(
              'Matchify and all of its content, including but not limited to text, graphics, logos, images, and software, are the property of Matchify and are protected by copyright and other intellectual property laws.'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hasChosen = false;
  bool _isChecked = false;
  String? errorMessage;
  bool _obscureTextFirst = true;
  bool _obscureTextConfirm = true;
  bool _obscureTextLogin = true;
  bool isLogin = true;
  String? getMessage(){
    return errorMessage;
  }
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

  Widget _registerUsername() {
    return SizedBox(
      key: const Key("register username"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _regUsername,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          letterSpacing: 0.10000000149011612,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'username',
          hintStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
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
      key: const Key("register password"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _regPassword,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          letterSpacing: 0.10000000149011612,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'password',
          hintStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureTextFirst = !_obscureTextFirst;
              });
            },
            child: Icon(
              _obscureTextFirst ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
        obscureText: _obscureTextFirst,
      ),
    );
  }

  Widget _confirmPassword() {
    return SizedBox(
      key: const Key("confirm password"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _confPassword,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          letterSpacing: 0.10000000149011612,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'confirm password',
          hintStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureTextConfirm = !_obscureTextConfirm;
              });
            },
            child: Icon(
              _obscureTextConfirm ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
        obscureText: _obscureTextConfirm,
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
          key: const Key("accept terms and conditions"),
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
        ),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Colors.black,
            ),
            children: [
              const TextSpan(
                text: 'I Accept ',
              ),
              TextSpan(
                text: 'Terms & Conditions',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.lightBlue,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const MyTermsAndConditionsDialog();
                      },
                    );
                  },
              ),
              const TextSpan(
                text: ' of Matchify',
              ),
            ],
          ),
        )
      ],
    );
  }

  SnackBar _errorMessage() {
    return const SnackBar(
      key: Key("error message"),
      content: Text("Please fill out the required fields correctly"),
      backgroundColor: Colors.red,
    );
  }

  Widget _registerButton() {
    return Builder(
      builder: (context) => Container(
        key: const Key("register"),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
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
                const Color.fromRGBO(246, 217, 18, 1)),
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(48, 21, 81, 1),
            ),
            fixedSize: MaterialStateProperty.resolveWith<Size?>(
                (states) => const Size(130, 45)),
            textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                (states) => const TextStyle(
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.10000000149011612,
                      fontWeight: FontWeight.w400,
                    )),
          ),
          onPressed: () async {
            if (_regPassword.text != _confPassword.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Passwords do not match"),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (!_isChecked) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "You must accept the Terms & Conditions of Matchify"),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              await createUserWithEmailAndPassword();
              if (errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  _errorMessage(),
                );
              }
            }
          },
          child: const Text('register'),
        ),
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
    return const Text(
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
    return const Text(
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
      key: const Key("login username"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _logUsername,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          letterSpacing: 0.10000000149011612,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'username',
          hintStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
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
      key: const Key("login password"),
      width: 260,
      height: 80,
      child: TextFormField(
        controller: _logPassword,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          letterSpacing: 0.10000000149011612,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'password',
          hintStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureTextLogin = !_obscureTextLogin;
              });
            },
            child: Icon(
              _obscureTextLogin ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
        obscureText: _obscureTextLogin,
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      key: const Key("login"),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
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
              MaterialStateProperty.all<Color>(const Color.fromRGBO(48, 21, 81, 1)),
          foregroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(255, 242, 156, 1),
          ),
          fixedSize: MaterialStateProperty.resolveWith<Size?>(
              (states) => const Size(130, 45)),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) => const TextStyle(
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.10000000149011612,
                    fontWeight: FontWeight.w400,
                  )),
        ),
        onPressed: () async {
          await signInWithEmailAndPassword();
          if (errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              _errorMessage(),
            );
          }
        },
        child: const Text('login'),
      ),
    );
  }

  Widget change() {
    String message =
        isLogin ? "Don't have an account? " : "Already have an account? ";
    String actionText = isLogin ? "Sign up now!" : "Log in now!";
    return GestureDetector(
      key: const Key("change"),
      onTap: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text.rich(
          TextSpan(
            text: message,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: actionText,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.lightBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return Scaffold(
        key: const Key("login page"),
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 110),
              _loginTitle(),
              const SizedBox(height: 50),
              _loginUsername(),
              _loginPassword(),
              const SizedBox(height: 30),
              const SizedBox(height: 10),
              _loginButton(),
              const SizedBox(height: 30),
              change(),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        key: const Key("register page"),
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 110),
              _registerTitle(),
              const SizedBox(height: 50),
              _registerUsername(),
              _registerPassword(),
              _confirmPassword(),
              _termsAndConditions(),
              const SizedBox(height: 20),
              _registerButton(),
              const SizedBox(height: 20),
              change(),
            ],
          ),
        ),
      );
    }
  }
}
