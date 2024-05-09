import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenManeger {
  static const _accessTokenKey = 'access_token';
  static const _userDataKey = 'user_data';

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      return json.decode(userDataString);
    } else {
      return null;
    }
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userDataKey, json.encode(userData));
  }

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
