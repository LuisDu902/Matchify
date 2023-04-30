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

    final mood = find.byValueKey("Mood");
    await FlutterDriverUtils.tap(world.driver, mood);

    final happy = find.byValueKey("Happy");
    final energetic = find.byValueKey("Energetic");

    await FlutterDriverUtils.tap(world.driver, happy);
    await FlutterDriverUtils.tap(world.driver, energetic);
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
