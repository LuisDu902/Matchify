import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class SelectFilters extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final size = find.byValueKey("playlist size");
    await FlutterDriverUtils.enterText(world.driver, size, "8");

    final genre = find.byValueKey("Genre");
    await FlutterDriverUtils.tap(world.driver, genre);

    final pop = find.byValueKey("Pop");
    final funk = find.byValueKey("Funk");

    await FlutterDriverUtils.tap(world.driver, pop);
    await FlutterDriverUtils.tap(world.driver, funk);

    final decade = find.byValueKey("Decade");
    await FlutterDriverUtils.tap(world.driver, decade);

    final seventies = find.byValueKey("1970's");
    final eighties = find.byValueKey("1980's");

    await FlutterDriverUtils.tap(world.driver, seventies);
    await FlutterDriverUtils.tap(world.driver, eighties);
  }

  @override
  RegExp get pattern => RegExp(r'I have chosen the filters to apply');
}

class ListenToShortClip extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    await Future.delayed(const Duration(seconds: 10));
  }

  @override
  RegExp get pattern => RegExp(r'I listen to a short clip of a song');
}

class SkipSong extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final page = find.byValueKey('swipe page');
    bool isSwipePage = await FlutterDriverUtils.isPresent(world.driver, page);
    expect(isSwipePage, true);
  }

  @override
  RegExp get pattern => RegExp(r'the song was skipped');
}
