import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static Future<void> storingIsLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", value);
  }

  static Future<bool> getIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  static Future<void> storingUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", name);
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username") ?? "";
  }
}
