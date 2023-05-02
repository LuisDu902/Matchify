import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class FriendRequest extends AndWithWorld<FlutterWorld> {
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

    final username = find.byValueKey("login username");
    final password = find.byValueKey("login password");

    await FlutterDriverUtils.enterText(
        world.driver, username, "user2@gmail.com");
    await FlutterDriverUtils.enterText(world.driver, password, "123456");

    final login = find.byValueKey("login");
    await FlutterDriverUtils.tap(world.driver, login);

    await Future.delayed(const Duration(seconds: 3));

    final sidebar = find.byValueKey("side bar");
    await FlutterDriverUtils.tap(world.driver, sidebar);

    final addFriend = find.byValueKey("add friend");
    await FlutterDriverUtils.tap(world.driver, addFriend);

    final user = find.byValueKey("friend's username");
    await FlutterDriverUtils.enterText(world.driver, user, "user1");

    final send = find.byValueKey("send request");
    await FlutterDriverUtils.tap(world.driver, send);
  }

  @override
  RegExp get pattern => RegExp(r'user2 has sent me a friend request');
}

class AcceptRequest extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {
    final friend = find.byValueKey("friends button");
    await FlutterDriverUtils.tap(world.driver, friend);

    final user2 = find.text("user2");
    bool isFriend = await FlutterDriverUtils.isPresent(world.driver, user2);

    expect(isFriend, true);

    final remove = find.byValueKey("X");
    await FlutterDriverUtils.tap(world.driver, remove);

    final confirm = find.byValueKey("remove friend");
    await FlutterDriverUtils.tap(world.driver, confirm);

  }

  @override
  RegExp get pattern => RegExp(r'I increased the number of friends I have');
}


class DeclineRequest extends ThenWithWorld<FlutterWorld> {
  @override
  Future<void> executeStep() async {

    final empty = find.text("Your friend request list is empty.\n Don't worry, you'll receive some soon!");
    bool noRequests = await FlutterDriverUtils.isPresent(world.driver, empty);

    expect(noRequests, true);
  }

  @override
  RegExp get pattern => RegExp(r'I declined a friend request');
}
