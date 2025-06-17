import 'package:climater/database/database.dart';
import 'package:climater/services/last_update_service.dart';
import 'package:climater/services/location_service.dart';
import 'package:climater/services/unit_service.dart';
import 'package:climater/services/weather_service.dart';
import 'package:climater/util/temperature_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/weather_data.dart';
import '../util/temperature_util.dart';

/// This is a provider to be used in the Home Page to display the current weather
/// situation
///
/// It uses the [WeatherService] and [LocationService] to fetch data from the
/// APIs and organizes it on the [_weatherData] variable
class WeatherProvider with ChangeNotifier {
  final WeatherController _weatherController = WeatherController();

  WeatherData? _weatherData;

  UnitSystem unitSystem = UnitSystem.metric;

  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;

  WeatherData? get weatherData => _weatherData;

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  String? get errorMessage => _errorMessage;

  WeatherProvider() {
    _init();
  }

  /// Initilizes the state by loading all data
  _init() async {
    await _loadTemperatureUnit();
    await _getCachedWeatherData();
    await getWeatherData();
  }

  /// Fetches the current weather data from the API
  Future<void> getWeatherData() async {
    if (_weatherData == null) {
      _isLoading = true;
      notifyListeners();
    }

    final position = await LocationService.getPosition();

    /// TODO: add proper error handling
    if (position == null) {
      return;
    }

    final data = await WeatherService().fetchWeatherData(
      latitude: position.latitude!,
      longitude: position.longitude!,
      unit: unitSystem,
    );

    if (data == null || data.isEmpty) {
      _hasError = true;
      _errorMessage =
          'An error occurred while trying to fetch the weather data';
      _isLoading = false;
      return;
    }

    _weatherData = WeatherData.fromJson(json: data);
    await _weatherController.insert(weatherData: _weatherData!);

    _hasError = false;
    _errorMessage = null;
    _isLoading = false;

    await _saveLastUpdate();

    notifyListeners();
  }

  /// Gets the [WeatherData] stored in the database
  Future<void> _getCachedWeatherData() async {
    _isLoading = true;
    notifyListeners();

    final result = await _weatherController.select();

    if (result == null) {
      return;
    }

    _weatherData = WeatherData.fromCachedJson(json: result);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveLastUpdate() async {
    await LastUpdateService().saveUpdateTime();
  }

  /// Toggles the current temperature unit and saves it to [SharedPreferences]
  Future<void> toggleTemperatureUnit() async {
    final double Function(double) callbackFunction;

    if (unitSystem == UnitSystem.imperial) {
      callbackFunction = TemperatureConverter.fahrenheitToCelsius;
    } else {
      callbackFunction = TemperatureConverter.celsiusToFahrenheit;
    }

    await weatherData!.toggleTemperatureUnit(calculate: callbackFunction);

    unitSystem =
        unitSystem == UnitSystem.metric
            ? UnitSystem.imperial
            : UnitSystem.metric;

    await UnitService().saveUnit(unitSystem.name);

    notifyListeners();
  }

  /// Gets the current temperature unit stored in [SharedPreferences]
  /// from the [UnitService] class
  Future<void> _loadTemperatureUnit() async {
    final stringUnit = await UnitService().loadUnit();

    unitSystem = UnitSystem.values.firstWhere(
      (element) => element.name == stringUnit,
      orElse: () => UnitSystem.metric,
    );

    notifyListeners();
  }
}
