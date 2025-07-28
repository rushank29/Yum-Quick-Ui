import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'shared_pref_constants.dart';

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
  setBool(prefIsOnBoardingVisited, true);
}

Future<void> setJsonString(String key, dynamic data) async {
  String jsonString = jsonEncode(data.toJson());
  await setString(key, jsonString);
}

Future<T?> getObjectFromPrefs<T>(
  String key,
  T Function(Map<String, dynamic>) fromJson,
) async {
  final jsonString = prefs?.getString(key);

  if (jsonString != null) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return fromJson(jsonMap);
  }

  return null;
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty ? Locale(languageCode, '') : const Locale('en', '');
}

Future<Locale> setLocale(String languageCode) async {
  await setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Locale getLocale() {
  String languageCode = getString(prefSelectedLanguageCode);
  return _locale(languageCode);
}
