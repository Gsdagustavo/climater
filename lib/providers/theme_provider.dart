import 'package:climater/services/theme_service.dart';
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
    notifyListeners();
  }

  /// Toggles the current theme and saves to [SharedPreferences] using [ThemeService].
  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;
    await ThemeService().saveTheme(isDarkMode);
    notifyListeners();
  }

  /// Loads a saved theme from [SharedPreferences] using [ThemeService].
  Future<void> _loadTheme() async {
    isDarkMode = await ThemeService().loadTheme();
    notifyListeners();
  }
}
