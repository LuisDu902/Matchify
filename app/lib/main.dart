import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:matchify/backend/dark_mode.dart';
import 'pages/authentication/widget_tree.dart';
import 'pages/loadingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await loadDarkModeState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matchify',
      home: const LoadingScreen(),
      routes: {
        '/widget_tree': (context) => const WidgetTree(),
      },
    );
  }
}
