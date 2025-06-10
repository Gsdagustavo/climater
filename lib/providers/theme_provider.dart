import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Contains the [ThemeData] for both [Dark] and [Light] themes
abstract class AppThemes {
  /// Represents the [Light Theme]
  static final lightThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple,
  );

  /// Represents the [Dark Theme]
  static final darkThemeData = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
  );
}

/// This class contains the keys to [SharedPreferences]
///
/// Currently, there is only one key being used, but this class provides a
/// cleaner and concise way to retrieve it
abstract class SharedThemeKeys {
  static const isDarkModeKey = 'isDarkMode';
}

/// This is a provider to be used in the Home Page to toggle and retrieve the
/// current theme of the app
class ThemeProvider with ChangeNotifier {
  bool isDarkMode = true;

  ThemeProvider() {
    _init();
  }

  /// Returns a [ThemeData] based on the current state of the theme
  ThemeData get themeData =>
      isDarkMode ? AppThemes.darkThemeData : AppThemes.lightThemeData;

  /// Loads the theme from [SharedPreferences]
  Future<void> _init() async {
    await _loadTheme();
  }

  /// Toggles the current theme and saves it to [SharedPreferences]
  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedThemeKeys.isDarkModeKey, isDarkMode);
    notifyListeners();
  }

  /// Loads a saved theme from shared preferences.
  ///
  /// If there is no theme stored (first launch of the app), saves the
  /// default theme in [SharedPreferences] (dark theme)
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
