/// This is a simple static abstract class that is used for converting
/// temperatures
///
/// Currently, only [Celsius] and [Fahrenheit] are valid temperatures
abstract class TemperatureConverter {
  /// Returns the value of the temperature in [Fahrenheit]
  static double celsiusToFahrenheit({required double celsius}) {
    return (9 / 5) * celsius + 32;
  }

  /// Returns the value of the temperature in [Celsius]
  static double fahrenheitToCelsius({required double fahrenheit}) {
    return (fahrenheit - 32) * 5 / 9;
  }
}
