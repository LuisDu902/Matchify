import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ChooseFilters extends And2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2) async {
    final filter1 = find.byValueKey(input1);
    final filter2 = find.byValueKey(input2);
    await FlutterDriverUtils.tap(world.driver, filter1);
    await FlutterDriverUtils.tap(world.driver, filter2);
  }

  @override
  RegExp get pattern => RegExp(r'I choose {string} and {string}');
}

