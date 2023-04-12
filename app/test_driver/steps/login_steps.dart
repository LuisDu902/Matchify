import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckLoginPage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final page = find.byValueKey("Loading Page");

    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);

    expect(pageExists, true);

    await Future.delayed(Duration(seconds: 3));

    final page2 = find.byValueKey("Log In Page");

    bool page2Exists = await FlutterDriverUtils.isPresent(world.driver, page2);

    expect(page2Exists, true);
    
   
  }

  @override
  RegExp get pattern => RegExp(r"the user is in the login page");
}

class WriteUsername extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String username) async {
    final field = find.byValueKey("username");

    await FlutterDriverUtils.enterText(world.driver, field, username);
  }

  @override
  RegExp get pattern =>
      RegExp(r"the user fills the username field with {string}");
}

class WritePassword extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String password) async {
    final field = find.byValueKey("password");

    await FlutterDriverUtils.enterText(world.driver, field, password);
  }

  @override
  RegExp get pattern =>
      RegExp(r"the user fills the password field with {string}");
}

class TapLogInButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String key) async {
    final button = find.byValueKey(key);

    await FlutterDriverUtils.tap(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r"the user taps {string}");
}

class CheckHomePage extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final page = find.byValueKey("Home Page");
    await FlutterDriverUtils.waitUntil(world.driver, () async {
          return FlutterDriverUtils.isPresent(world.driver, page);
        });

    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);

    expect(pageExists, true);
  }

  @override
  RegExp get pattern => RegExp(r"the user logs in");
}
