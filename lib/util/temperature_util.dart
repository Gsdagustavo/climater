enum UnitSystem { metric, imperial }

abstract class TemperatureUtil {
  static String unitToString(UnitSystem unit) {
    switch (unit) {
      case UnitSystem.metric:
        return 'Celsius';
      case UnitSystem.imperial:
        return 'Fahrenheit';
    }
  }

  static String getTemperatureInitial(UnitSystem unit) {
    return unitToString(unit)[0];
  }
}

abstract class TemperatureConverter {
  static double celsiusToFahrenheit({required double celsius}) {
    return (9 / 5) * celsius + 32;
  }

  static double fahrenheitToCelsius({required double fahrenheit}) {
    return (fahrenheit - 32) * 5 / 9;
  }
}
