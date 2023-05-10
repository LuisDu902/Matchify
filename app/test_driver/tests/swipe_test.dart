import 'dart:async';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import '../steps/filters_steps.dart';
import '../steps/common_steps.dart';
import '../steps/swipe_steps.dart';

Future<void> main() async {
  final config = FlutterTestConfiguration()
    ..features = ['test_driver/features/swipe.feature']
    ..reporters = [ProgressReporter()]
    ..stepDefinitions = [
      LaunchApp(),
      CheckHomePage(),
      SelectFilters(),
      CheckSwipePage(),
      ListenToShortClip(),
      SkipSong()
    ]
    ..targetAppPath = "test_driver/app.dart"
    ..defaultTimeout = Duration(seconds: 30);

  GherkinRunner().execute(config);
}