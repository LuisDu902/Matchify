import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class NewPlaylist extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    await Future.delayed(const Duration(seconds: 5));
    final page = find.byValueKey('final playlist');
    bool isSwipePage = await FlutterDriverUtils.isPresent(world.driver, page);
    expect(isSwipePage, true);
  }

  @override
  RegExp get pattern => RegExp(r'a new playlist has been created');
}
