import 'dart:convert';

import 'package:cinaddict/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setFirstLaunch(bool isFirstLaunch) async =>
      await _preferences.setBool('isFirstLaunch', isFirstLaunch);

  static bool getIsFirstLaunch() => _preferences.getBool('isFirstLaunch') ?? true;

  static Future setLoggedIn(bool loggedIn) async =>
      await _preferences.setBool('loggedIn', loggedIn);

  static bool getLoggedIn() => _preferences.getBool('loggedIn') ?? false;

  static Future saveJsonUser(User user) async =>
    await _preferences.setString('profile', jsonEncode(user.toJson()));

  static User? getLocalUser() {
    User? user;
    String? userString = _preferences.getString('profile');
    if (userString != null) {
      user = User.fromJson(jsonDecode(userString));
    }
    return user;
  }

}