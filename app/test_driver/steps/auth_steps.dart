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
      final profile = find.byValueKey("profile");
      await FlutterDriverUtils.tap(world.driver, profile);
      final logout = find.byValueKey("log out");
      await FlutterDriverUtils.tap(world.driver, logout);
    }
  }

  @override
  RegExp get pattern => RegExp(r"I am on the login page");
}

class CheckRegisterPage extends GivenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final login = find.byValueKey("login page");
    bool isLoginPage = await FlutterDriverUtils.isPresent(world.driver, login);

    if (!isLoginPage) {
      final profile = find.byValueKey("profile");
      await FlutterDriverUtils.tap(world.driver, profile);
      final logout = find.byValueKey("log out");
      await FlutterDriverUtils.tap(world.driver, logout);
    }

    final button = find.byValueKey("change");

    await FlutterDriverUtils.tap(world.driver, button);

    final register = find.byValueKey("register page");
    bool isRegisterPage = await FlutterDriverUtils.isPresent(world.driver, register);

    expect(isRegisterPage, true);
  }

  @override
  RegExp get pattern => RegExp(r"I am on the register page");
}

class ErrorMessage extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final message = find.byValueKey("error message");

    bool isPresent = await FlutterDriverUtils.isPresent(world.driver, message);

    expect(isPresent, true);
  }

  @override
  RegExp get pattern => RegExp(r"an error message appears");
}

class RegisterSuccess extends AndWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final profile = find.byValueKey("profile");
      await FlutterDriverUtils.tap(world.driver, profile);
      final logout = find.byValueKey("delete account");
      await FlutterDriverUtils.tap(world.driver, logout);
      final confirm = find.byValueKey("confirm delete");
      await FlutterDriverUtils.tap(world.driver, confirm);
  }

  @override
  RegExp get pattern => RegExp(r"I have successfully registered");
}