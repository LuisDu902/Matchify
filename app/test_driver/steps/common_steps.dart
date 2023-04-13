import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class LaunchApp extends GivenWithWorld<FlutterWorld> {

  @override
  Future<void> executeStep() async {
    
    final loadingPage = find.byValueKey("Loading page");
    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, loadingPage);
    expect(pageExists, true);

    await Future.delayed(const Duration(seconds: 3));

  }

  @override
  RegExp get pattern => RegExp(r"the user has launched the app");

}

class CheckPage extends And1WithWorld<String,FlutterWorld> {

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