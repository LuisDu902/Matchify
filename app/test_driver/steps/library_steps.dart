import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckPlaylist extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    await Future.delayed(const Duration(seconds: 3));
    final playlist = find.byValueKey("playlist songs");
    bool isPresent = await FlutterDriverUtils.isPresent(world.driver, playlist);
    expect(isPresent, true);
  }

  @override
  RegExp get pattern => RegExp(r'I can see my playlist');
}