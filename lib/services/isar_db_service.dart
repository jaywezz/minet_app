import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// import '../features/authentication/models/user_model.dart';

class SharedPrefsService {
  static SharedPrefsService? _instance;
  static SharedPreferences? _prefs;

  SharedPrefsService._();

  static Future<SharedPrefsService> getInstance() async {
    if (_instance == null) {
      _prefs = await SharedPreferences.getInstance();
      _instance = SharedPrefsService._();
    }
    return _instance!;
  }

  // Token management
  Future<void> saveToken(String token) async {
    await _prefs!.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    return _prefs!.getString('auth_token');
  }

  Future<void> removeToken() async {
    await _prefs!.remove('auth_token');
  }

  // User data management
  // Future<void> saveUser(User user) async {
  //   final userJson = jsonEncode(user.toJson());
  //   await _prefs!.setString('user_data', userJson);
  // }

  // Future<User?> getUser() async {
  //   final userJson = _prefs!.getString('user_data');
  //   if (userJson != null) {
  //     try {
  //       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
  //       return User.fromJson(userMap);
  //     } catch (e) {
  //       print('Error parsing user data: $e');
  //       return null;
  //     }
  //   }
  //   return null;
  // }

  Future<void> removeUser() async {
    await _prefs!.remove('user_data');
  }

  // General data storage
  Future<void> saveData(String key, String value) async {
    await _prefs!.setString(key, value);
  }

  Future<String?> getData(String key) async {
    return _prefs!.getString(key);
  }

  Future<void> removeData(String key) async {
    await _prefs!.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs!.clear();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Save boolean values
  Future<void> saveBool(String key, bool value) async {
    await _prefs!.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return _prefs!.getBool(key);
  }

  // Save integer values
  Future<void> saveInt(String key, int value) async {
    await _prefs!.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return _prefs!.getInt(key);
  }

  // Save double values
  Future<void> saveDouble(String key, double value) async {
    await _prefs!.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    return _prefs!.getDouble(key);
  }

  // Save string list
  Future<void> saveStringList(String key, List<String> value) async {
    await _prefs!.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    return _prefs!.getStringList(key);
  }
}
