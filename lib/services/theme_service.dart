import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const isDarkModeKey = 'isDarkMode';

  /// Toggles the current theme and saves it to [SharedPreferences]
  Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isDarkModeKey, isDarkMode);
  }

  /// Loads a saved theme from shared preferences.
  ///
  /// If there is no theme stored (first launch of the app), saves the
  /// default theme in [SharedPreferences] (dark theme)
  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool? prefsDarkMode = prefs.getBool(isDarkModeKey);

    /// if is the first launch, sets the dark mode key to the default value
    /// (dark mode)
    if (prefsDarkMode == null) {
      await prefs.setBool(isDarkModeKey, true);
      return true;
    }

    return prefsDarkMode;
  }
}
