import 'package:flutter/material.dart';
import 'authScreen.dart';
import '../homeScreen.dart';

import 'auth.dart';
import 'login.dart';


class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        print("StreamBuilder rebuilt with data: ${snapshot.hasData}");
        if (snapshot.hasData) {
          print(snapshot.data!.email);
          return HomeScreen();
        } else {
          return const Login();
        }
      },
    );
  }
}
