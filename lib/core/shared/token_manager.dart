import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPreferences {
  static const _accessTokenKey = 'access_token';

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_accessTokenKey);
  }
}
