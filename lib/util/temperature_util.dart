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
