/// Represents a unit system for making operations with the API and database
///
/// Metric represents the temperature in [Celsius] and Imperial in [Fahrenheit]
///
/// It was preferred to name [metric] and [imperial] instead of Celsius and Fahrenheit
/// because the [OpenWeatherMapAPI] works with Unit System nomenclature, so it would
/// be harder to work with the temperature names directly
enum UnitSystem { metric, imperial }

/// This is a util class to be used when working with temperatures
abstract class TemperatureUtil {
  /// Returns the temperature name from the given [UnitSystem]
  ///
  /// [metric] returns [Celsius] and [imperial] returns [Fahrenheit]
  static String unitToString(UnitSystem unit) {
    switch (unit) {
      case UnitSystem.metric:
        return 'Celsius';
      case UnitSystem.imperial:
        return 'Fahrenheit';
    }
  }

  /// Returns the first letter [initial] of the temperature name
  static String getTemperatureInitial(UnitSystem unit) {
    return unitToString(unit)[0];
  }
}
