import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class FillField extends And2WithWorld<String, String, FlutterWorld>{

   @override
  Future<void> executeStep(String field, String input) async {
    final form = find.byValueKey(field);

    await FlutterDriverUtils.enterText(world.driver, form, input);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} field with {string}");
}
