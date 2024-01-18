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

  bool _isDailyReminderOn = false;
  bool get isDailyReminderOn => _isDailyReminderOn;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void _getDailyReminderPreferences() async {
    _isDailyReminderOn = await preferencesHelper.isDailyReminderOn;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderPreferences();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;
}
