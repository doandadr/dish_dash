import 'package:dish_dash/common/style.dart';
import 'package:flutter/foundation.dart';
import 'package:dish_dash/data/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
  }

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;
}
