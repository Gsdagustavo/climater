import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,
);

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
);

abstract class SharedThemeKeys {
  static const isDarkModeKey = 'isDarkMode';
}

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = true;

  ThemeProvider() {
    _init();
  }

  ThemeData get themeData => isDarkMode ? darkThemeData : lightThemeData;

  Future<void> _init() async {
    await _loadTheme();
  }

  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedThemeKeys.isDarkModeKey, isDarkMode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool? prefsDarkMode = prefs.getBool(SharedThemeKeys.isDarkModeKey);

    /// if is the first launch, sets the dark mode key to the default value
    /// (dark mode)
    if (prefsDarkMode == null) {
      prefs.setBool(SharedThemeKeys.isDarkModeKey, isDarkMode);
      return;
    }

    isDarkMode = prefsDarkMode;
    notifyListeners();
  }
}
