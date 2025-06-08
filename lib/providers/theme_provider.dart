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

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedThemeKeys.isDarkModeKey, isDarkMode);
    notifyListeners();
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool? prefsDarkMode = prefs.getBool(SharedThemeKeys.isDarkModeKey);

    /// if is the first launch, sets the dark mode key to the default value
    /// (dark mode)
    if (prefsDarkMode == null) {
      prefs.setBool(SharedThemeKeys.isDarkModeKey, isDarkMode);
      notifyListeners();
      return;
    }

    prefs.setBool(SharedThemeKeys.isDarkModeKey, prefsDarkMode);
    notifyListeners();
  }
}
