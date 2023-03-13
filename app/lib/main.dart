import 'package:flutter/material.dart';

import 'homeScreen.dart';
import 'loadingScreen.dart';

void main() {
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
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}