import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserPreferences {
  static late SharedPreferences _shredPref;
  static const _userKey = 'ndowa_user';

  static var myUser = UserModel(
    userId: '0',
    name: 'jhondoe',
    email: 'actif@email.com',
    phone: '+243',
    role: 'role',
    eventId: '0',
    isLogin: false,
    otpEntered: false,
    firstLaunchApp: true,
    appBlocked: false,
  );

  static Future init() async =>
      _shredPref = await SharedPreferences.getInstance();

  static Future<void> setUserInfo(UserModel user) async {
    final json = jsonEncode(user.toJson());
    await _shredPref.setString(_userKey, json);
  }

  static UserModel getUserInfo() {
    final json = _shredPref.getString(_userKey);

    return json == null ? myUser : UserModel.fromJson(jsonDecode(json));
  }
}
