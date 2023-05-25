import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchify/backend/dark_mode.dart';

import 'package:matchify/pages/appBar/appBar.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'package:matchify/backend/auth.dart';
import '../../backend/variables.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final appBarState appBarC = new appBarState();
  late Color bgColor;
  late Color textColor;
  late Color boxTextColor;
  late Color boxColor;

  @override
  void initState() {
    super.initState();
    updateColors();
  }

  void updateColors() {
    setState(() {
      bgColor = DarkMode.isDarkModeEnabled
          ? const Color.fromRGBO(59, 59, 59, 1)
          : Colors.white;
      textColor = DarkMode.isDarkModeEnabled ? Colors.white : Colors.black;
      boxTextColor = DarkMode.isDarkModeEnabled
          ? const Color.fromRGBO(20, 6, 74, 1)
          : const Color.fromRGBO(224, 217, 228, 1);
      boxColor = DarkMode.isDarkModeEnabled
          ? Colors.white
          : const Color.fromRGBO(48, 21, 81, 1);
    });
  }

  void toggleDarkMode() {
    setState(() {
      DarkMode.isDarkModeEnabled = !DarkMode.isDarkModeEnabled;
      saveDarkModeState(DarkMode.isDarkModeEnabled);
      updateColors();
    });
  }

  final User? user = Auth().currentUser;

  Widget popUp() {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(252, 241, 183, 1),
      content: const Text(
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
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(193, 182, 202, 1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromRGBO(193, 182, 202, 1),
          ),
        ),
        child: const Center(
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
      key: const Key('confirm delete'),
      onPressed: () {
        Auth().deleteAccount(context);
        Navigator.of(context).pop();
      },
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(193, 182, 202, 1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromRGBO(193, 182, 202, 1),
          ),
        ),
        child: const Center(
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
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              'My profile',
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Icon(
              Icons.person,
              size: 250,
              color: textColor,
            ),
            Text(
              Auth().getUsername(),
              style: TextStyle(fontSize: 20, color: textColor),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              key: const Key('log out'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(boxTextColor),
                foregroundColor: MaterialStateProperty.all<Color>(boxColor),
                fixedSize: MaterialStateProperty.resolveWith<Size?>(
                    (states) => const Size(240, 50)),
                textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                    (states) => const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.10000000149011612,
                        )),
              ),
              onPressed: () => {Auth().signOut(context)},
              child: const Text('Log out'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('delete account'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(boxTextColor),
                foregroundColor: MaterialStateProperty.all<Color>(boxColor),
                fixedSize: MaterialStateProperty.resolveWith<Size?>(
                    (states) => const Size(240, 50)),
                textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                    (states) => const TextStyle(
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
              child: const Text('Delete account'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(boxTextColor),
                foregroundColor: MaterialStateProperty.all<Color>(boxColor),
                fixedSize: MaterialStateProperty.resolveWith<Size?>(
                    (states) => const Size(240, 50)),
              ),
              onPressed: () {
                toggleDarkMode(); // call the toggleDarkMode function
                if (appBarC.mounted) {
                  appBarC.updateColors(); // call the updateColors function
                } // call the updateColors function
              },
              child: ListTile(
                leading: Icon(
                  DarkMode.isDarkModeEnabled
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  color: textColor,
                ),
                title: Center(
                  child: Text(
                      DarkMode.isDarkModeEnabled ? 'Light mode' : 'Dark mode',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.10000000149011612,
                          color: boxColor)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
