import 'package:climater/services/weather_service.dart';
import 'package:flutter/widgets.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

import '../model/weather_data.dart';

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

  Future<void> getWeatherData() async {
    _isLoading = true;
    notifyListeners();

    final position = await _getPosition();

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

    final Address? address = await _getAddress(position: position);

    /// TODO: add proper error handling
    if (address == null) {
      return;
    }

    _weatherData = _formatWeatherData(
      main: data['main'],
      weather: data['weather'][0],
      address: address,
    );
    notifyListeners();
  }

  WeatherData _formatWeatherData({
    required Map<String, dynamic> main,
    required Map<String, dynamic> weather,
    required Address address,
  }) {
    return WeatherData(
      address: address,
      main: weather['main'],
      description: weather['description'],
      temperature: main['temp'],
      feelsLike: main['feels_like'],
      pressure: main['pressure'],
      humidity: main['humidity'],
      maxTemperature: main['temp_max'],
      minTemperature: main['temp_min'],
    );
  }

  /// Returns an [Address] based on the current [Position]
  Future<Address?> _getAddress({required Position position}) async {
    final address = await GeoCode().reverseGeocoding(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    return address;
  }

  /// Returns the current [Position]
  Future<Position?> _getPosition() async {
    await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(),
    );

    return position;
  }
}
