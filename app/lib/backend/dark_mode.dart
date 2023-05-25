import 'dart:io';

import 'package:matchify/backend/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadDarkModeState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  DarkMode.isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
}

void saveDarkModeState(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DarkMode.isDarkModeEnabled = value;
  prefs.setBool('isDarkModeEnabled', value); // Save the dark mode state to local storage
}

