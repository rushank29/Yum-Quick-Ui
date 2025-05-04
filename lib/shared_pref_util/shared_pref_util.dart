import 'dart:convert';

import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

Future<void> initPreferences() async {
  prefs = await SharedPreferences.getInstance();
}

Future<void> setBool(String key, bool value) async {
  await prefs?.setBool(key, value);
}

bool getBool(String key, {bool defaultValue = false}) {
  return prefs?.getBool(key) ?? defaultValue;
}

Future<void> setString(String key, String value) async {
  await prefs?.setString(key, value);
}

String getString(String key, {String defaultValue = ''}) {
  return prefs?.getString(key) ?? defaultValue;
}

Future<void> setInt(String key, int value) async {
  await prefs?.setInt(key, value);
}

int getInt(String key, {int defaultValue = 0}) {
  return prefs?.getInt(key) ?? defaultValue;
}

Future<void> remove(String key) async {
  await prefs?.remove(key);
}

Future<void> clearPrefWithSomeRemainingData() async {
  await prefs?.clear();
  prefs?.setBool(prefIsOnBoardingVisited, true);
}

Future<void> setJsonString(String key, dynamic data) async {
  String jsonString = json.encode(data.toJson());
  await prefs?.setString(key, jsonString);
}

Future<T?> getObjectFromPrefs<T>(
  String key,
  T Function(Map<String, dynamic>) fromJson,
) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(key);

  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return fromJson(jsonMap);
  }

  return null;
}
