import 'dart:async';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import '../steps/login_steps.dart';

Future<void> main() async {
  final config = FlutterTestConfiguration()
    ..features = ['test_driver/features/login.feature']
    ..reporters = [ProgressReporter()]
    ..stepDefinitions = [
      CheckLoginPage(),
      WriteUsername(),
      WritePassword(),
      TapLogInButton(),
      CheckHomePage(),
    ]
    ..targetAppPath = "test_driver/app.dart"
    ..restartAppBetweenScenarios = true;

  GherkinRunner().execute(config);

}
