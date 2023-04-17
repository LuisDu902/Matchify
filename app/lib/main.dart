import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:matchify/authentication/login.dart';
import 'package:matchify/homeScreen.dart';
import 'authentication/widget_tree.dart';
import 'loadingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matchify',
      
      home: LoadingScreen(),
      routes: {
        '/widget_tree' : (context) => WidgetTree(),
      },
      
    );
  }
}
