import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_apps/data/model/user_model.dart';

class AuthController {
  static const String _userDataKey = "user-data";
  static const String _accessTokenKey = "token";

  static UserModel? userModel;
  static String? accessToken;

  static Future<void> saveUserData(UserModel userData, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      _userDataKey,
      jsonEncode(userData.toJson()),
    );
    await sharedPreferences.setString(_accessTokenKey, token);
    userModel = userData;
    accessToken = token;
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      String? userData = sharedPreferences.getString(_userDataKey);
      userModel = UserModel.fromJson(jsonDecode(userData!));
      accessToken = token;
    }
  }
}
