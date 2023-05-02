import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class UserAccount extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final loginPage = find.byValueKey("login page");

    bool isLoginPage =
        await FlutterDriverUtils.isPresent(world.driver, loginPage);

    if (!isLoginPage) {
      final profile = find.byValueKey("profile");
      await FlutterDriverUtils.tap(world.driver, profile);
      final logout = find.byValueKey("log out");
      await FlutterDriverUtils.tap(world.driver, logout);
    }

    final username = find.byValueKey("login username");
    final password = find.byValueKey("login password");

    await FlutterDriverUtils.enterText(world.driver, username, input1);
    await FlutterDriverUtils.enterText(world.driver, password, "123456");

    final login = find.byValueKey("login");
    await FlutterDriverUtils.tap(world.driver, login);
  }

  @override
  RegExp get pattern => RegExp(r'I have logged in using the account {string}');
}

class SucessfulRequest extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
     await Future.delayed(const Duration(seconds: 3));
    final message = find.text("Friend request sent");
    bool isPresent = await FlutterDriverUtils.isPresent(world.driver, message);
    expect(isPresent, true);
  }
  @override
  RegExp get pattern => RegExp(r'a friend request is sent');
}

class UnsucessfulRequest extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    await Future.delayed(const Duration(seconds: 3));
    final message = find.text("You can't send a request to yourself");
    bool isPresent = await FlutterDriverUtils.isPresent(world.driver, message);
    expect(isPresent, true);
  }

  @override
  RegExp get pattern => RegExp(r'a friend request is not sent');
}