import 'package:climater/services/location_service.dart';
import 'package:climater/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocode/geocode.dart';

import '../model/weather_data.dart';

/// This is a provider to be used in the Home Page to display the current weather
/// situation
///
/// It uses the [WeatherService] and [LocationService] to fetch data from the
/// APIs and organizes it on the [_weatherData] variable
class WeatherProvider with ChangeNotifier {
  WeatherData? _weatherData;

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

  _init() async {
    await getWeatherData();
  }

  /// Fetches the current weather data from the API
  Future<void> getWeatherData() async {
    _isLoading = true;
    notifyListeners();

    final position = await LocationService.getPosition();

    /// TODO: add proper error handling
    if (position == null) {
      return;
    }

    final data = await WeatherService().fetchWeatherData(
      latitude: position.latitude,
      longitude: position.latitude,
    );

    if (data == null || data.isEmpty) {
      _hasError = true;
      _errorMessage =
          'An error occurred while trying to fetch the weather data';
      _isLoading = false;
      return;
    }

    _hasError = false;
    _errorMessage = null;
    _isLoading = false;

    final Address? address = await LocationService.getAddress(
      position: position,
    );

    /// TODO: add proper error handling
    if (address == null) {
      return;
    }

    _weatherData = WeatherData.fromJsonAndAddress(
      main: data['main'],
      weather: data['weather'][0],
      address: address,
    );

    notifyListeners();
  }
}
