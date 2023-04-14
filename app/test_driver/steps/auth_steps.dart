import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckLoginPage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final loginPage = find.byValueKey("login page");

    bool isLoginPage =
        await FlutterDriverUtils.isPresent(world.driver, loginPage);

    if (!isLoginPage) {
      final logout = find.byValueKey("log out");
      await FlutterDriverUtils.tap(world.driver, logout);
    }
  }

  @override
  RegExp get pattern => RegExp(r"the user is in the login page");
}

class CheckRegisterPage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final login = find.byValueKey("login page");
    bool isLoginPage = await FlutterDriverUtils.isPresent(world.driver, login);

    if (!isLoginPage) {
      final logout = find.byValueKey("log out");
      await FlutterDriverUtils.tap(world.driver, logout);
    }
    expect(isLoginPage, true);

    final button = find.text('Sign up now!');

    await FlutterDriverUtils.tap(world.driver, button);

    final register = find.byValueKey("register page");
    bool isRegisterPage = await FlutterDriverUtils.isPresent(world.driver, register);

    expect(isRegisterPage, true);
  }

  @override
  RegExp get pattern => RegExp(r"the user is in the register page");
}

class FillField extends And2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field, String input) async {
    final form = find.byValueKey(field);

    await FlutterDriverUtils.enterText(world.driver, form, input);
  }

  @override
  RegExp get pattern =>
      RegExp(r"the user fills the {string} field with {string}");
}

class ErrorMessage extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final message = find.byValueKey("error message");

    bool isPresent = await FlutterDriverUtils.isPresent(world.driver, message);

    expect(isPresent, true);
  }

  @override
  RegExp get pattern =>
      RegExp(r"an error message appears");
}
