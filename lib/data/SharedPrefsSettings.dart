import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPrefsSettings {
  final String fontSizeKey = 'font_size';
  final String colorKey = 'color';
  static SharedPreferences _sharedPreferences;
  static SharedPrefsSettings _instance;

  SharedPrefsSettings._internal();

  factory SharedPrefsSettings() {
    if (_instance == null) {
      _instance = SharedPrefsSettings._internal();
    }
    return _instance;
  }

  Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future setColor(int color) async {
    return await _sharedPreferences.setInt(colorKey, color);
  }

  int getColor() {
    return _sharedPreferences.getInt(colorKey) ?? 0xff1976d2;
  }
}
