import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class LaunchApp extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final loadingPage = find.byValueKey("loading page");
    bool pageExists =
        await FlutterDriverUtils.isPresent(world.driver, loadingPage);
    expect(pageExists, true);

    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  RegExp get pattern => RegExp(r"the user has launched the app");
}

class CheckPage extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String key) async {
    final page = find.byValueKey(key);
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);
    expect(pageExists, true);
  }

  @override
  RegExp get pattern => RegExp(r"the user is in the {string}");
}

class TapButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String key) async {
    final button = find.byValueKey(key);

    await FlutterDriverUtils.tap(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r"the user taps {string}");
}

class CheckHomePage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final home = find.byValueKey("home page");

    bool isHomePage = await FlutterDriverUtils.isPresent(world.driver, home);

    if (!isHomePage) {
      final username = find.byValueKey("login username");
      final password = find.byValueKey("login password");
      final login = find.byValueKey("login");

      await FlutterDriverUtils.enterText(
          world.driver, username, "user1@gmail.com");
      await FlutterDriverUtils.enterText(world.driver, password, "123456");
      await FlutterDriverUtils.tap(world.driver, login);
    }
    
     while (!isHomePage) {
      await Future.delayed(Duration(milliseconds: 100)); // Sleep for 100ms
      isHomePage = await FlutterDriverUtils.isPresent(world.driver, home);
    }
    expect(isHomePage, true);
  }

  @override
  RegExp get pattern => RegExp(r"the user is in the home page");
}
