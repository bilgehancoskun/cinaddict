import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setFirstLaunch(bool isFirstLaunch) async =>
      await _preferences.setBool('isFirstLaunch', isFirstLaunch);

  static bool getIsFirstLaunch() => _preferences.getBool('isFirstLaunch') ?? true;

}