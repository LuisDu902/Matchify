import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:matchify/song/swipe.dart';

class CheckHomePage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final page = find.byValueKey("Loading Page");

    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);

    expect(pageExists, true);

    await Future.delayed(Duration(seconds: 3));

    final page2 = find.byValueKey("Home Page");

    bool page2Exists = await FlutterDriverUtils.isPresent(world.driver, page2);

    expect(page2Exists, true);
  }

  @override
  RegExp get pattern => RegExp(r"the user has logged in");
}

class CreatePlaylist extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final button = find.byValueKey("Create playlist");

    await FlutterDriverUtils.tap(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r"the user chooses to create a new playlist");
}

class CheckFiltersPage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final page = find.byValueKey("Filters Page");

    bool pageExists = await FlutterDriverUtils.isPresent(world.driver, page);

    expect(pageExists, true);
  }

  @override
  RegExp get pattern => RegExp(r"the user is in the filters page");
}

class ViewFilters extends WhenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final button = find.byValueKey("Genre");
    await FlutterDriverUtils.tap(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r'the user taps on "Genre"');
}

class ChooseFilters extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final filter1 = find.byValueKey('Funk');
    final filter2 = find.byValueKey('Pop');
    await FlutterDriverUtils.tap(world.driver, filter1);
    await FlutterDriverUtils.tap(world.driver, filter2);
  }

  @override
  RegExp get pattern => RegExp(r'the user chooses "Funk" and "Pop"');
}

class ViewFilters2 extends WhenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final button = find.byValueKey("Mood");
    await FlutterDriverUtils.tap(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r'the user taps on "Mood"');
}

class ChooseFilters2 extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final filter1 = find.byValueKey("Happy");
    final filter2 = find.byValueKey("Energetic");
    await FlutterDriverUtils.tap(world.driver, filter1);
    await FlutterDriverUtils.tap(world.driver, filter2);
  }

  @override
  RegExp get pattern => RegExp(r'the user chooses "Happy" and "Energetic"');
}

class ContinueButton extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final button = find.byValueKey("Continue");
    await FlutterDriverUtils.tap(world.driver, button);
    await FlutterDriverUtils.waitUntil(world.driver, () async {
      // your condition function here
      return await FlutterDriverUtils.isPresent(
          world.driver, find.byValueKey("Swipe page"));
    });
  }

  @override
  RegExp get pattern => RegExp(r'the user taps on "Continue"');
}

class CheckFilters extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    //...to be implemented
  }

  @override
  RegExp get pattern =>
      RegExp(r'only the songs that match those filters are displayed');
}
