import 'package:climater/util/temperature_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitService {
  static const unitKey = 'unit';

  /// Saves the given unit to [SharedPreferences]
  Future<void> saveUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(unitKey, unit);
  }

  /// Loads a saved unit system from shared preferences.
  ///
  /// If there is no unit stored (first launch of the app), saves the
  /// default theme to be metric
  Future<String> loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    String? prefsUnit = prefs.getString(unitKey);

    /// if is the first launch, sets the unit key to the default value
    /// (metric)
    if (prefsUnit == null) {
      final String defaultUnit = UnitSystem.metric.name;
      await prefs.setString(unitKey, defaultUnit);
      return defaultUnit;
    }

    return prefsUnit;
  }
}
