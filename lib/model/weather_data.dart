import 'package:flutter/material.dart';

/// Represents weather data collected from the [OpenWeatherMap] API
class WeatherData {
  final String _city;
  final double _latitude;
  final double _longitude;
  final String _main;
  final String _description;
  final double _temperature;
  final double _maxTemp;
  final double _minTemp;
  final double _feelsLike;
  final int _humidity;
  final int _pressure;
  final double _rain;
  final int _windDirection;
  final double _windSpeed;

  WeatherData({
    required String city,
    required double latitude,
    required double longitude,
    required double temperature,
    required double maxTemp,
    required double minTemp,
    required double feelsLike,
    required String main,
    required String description,
    required int pressure,
    required int humidity,
    required double rain,
    required double windSpeed,
    required int windDirection,
  }) : _city = city,
       _latitude = latitude,
       _longitude = longitude,
       _main = main,
       _description = description,
       _temperature = temperature,
       _minTemp = minTemp,
       _maxTemp = maxTemp,
       _feelsLike = feelsLike,
       _pressure = pressure,
       _humidity = humidity,
       _rain = rain,
       _windSpeed = windSpeed,
       _windDirection = windDirection;

  /// Returns a [WeatherData] from the given [main] (json), [weather] (json) and [address]
  factory WeatherData.fromJson({required Map<String, dynamic> json}) {
    final Map<String, dynamic> coord = json['coord'];
    final Map<String, dynamic> main = json['main'];
    final Map<String, dynamic> weather = json['weather'][0];
    final Map<String, dynamic> wind = json['wind'];

    debugPrint('WeatherData from json::\n');
    debugPrint('coords: $coord');
    debugPrint('main: $main');
    debugPrint('weather: $weather');
    debugPrint('wind: $wind');

    final rainData = json['rain'] as Map<String, dynamic>?;
    final rainLastHour =
        rainData != null && rainData.containsKey('1h') ? rainData['1h'] : 0.0;

    return WeatherData(
      // location
      city: json['name'],
      latitude: (coord['lat'] as num).toDouble(),
      longitude: (coord['lon'] as num).toDouble(),

      main: weather['main'],
      description: weather['description'],

      // temperature
      temperature: (main['temp'] as num).toDouble(),
      maxTemp: (main['temp_max'] as num).toDouble(),
      minTemp: (main['temp_min'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),

      // pressure and humidity
      humidity: (main['humidity'] as num).toInt(),
      pressure: (main['pressure'] as num).toInt(),

      // rain
      rain: (rainLastHour as num).toDouble(),

      // wind
      windDirection: (wind['deg'] as num).toInt(),
      windSpeed: (wind['speed'] as num).toDouble(),
    );
  }

  factory WeatherData.fromCachedJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['city'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),

      main: json['main'],
      description: json['description'],

      temperature: (json['temperature'] as num).toDouble(),
      maxTemp: (json['maxTemp'] as num).toDouble(),
      minTemp: (json['minTemp'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),

      humidity: json['humidity'],
      pressure: json['pressure'],

      rain: (json['rain'] as num).toDouble(),

      windDirection: (json['windDirection'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': _city,
      'latitude': _latitude,
      'longitude': _longitude,
      'main': _main,
      'description': _description,
      'temperature': _temperature,
      'minTemp': _minTemp,
      'maxTemp': _maxTemp,
      'feelsLike': _feelsLike,
      'pressure': _pressure,
      'humidity': _humidity,
      'rain': _rain,
      'windSpeed': _windSpeed,
      'windDirection': _windDirection,
    };
  }

  /// Returns a capitalized version of the [description]
  String formatDescription() {
    var desc = '';

    for (final word in _description.split(' ')) {
      desc += word[0].toUpperCase();
      desc += word.substring(1);
      desc += ' ';
    }

    return desc;
  }

  int get windDirection => _windDirection;

  double get windSpeed => _windSpeed;

  double get rain => _rain;

  int get humidity => _humidity;

  int get pressure => _pressure;

  double get feelsLike => _feelsLike;

  double get maxTemp => _maxTemp;

  double get minTemp => _minTemp;

  double get temperature => _temperature;

  String get description => _description;

  String get main => _main;

  double get longitude => _longitude;

  double get latitude => _latitude;

  String get city => _city;
}
