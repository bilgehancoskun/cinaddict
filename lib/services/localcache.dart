import 'dart:convert';

import 'package:cinaddict/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  static Future<void> saveJsonUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile', jsonEncode(user.toJson()));
  }

  static Future<User?> getLocalUser() async {
    User? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('profile');
    if (userString != null) {
      user = User.fromJson(jsonDecode(userString));
    }
    return user;
  }

}