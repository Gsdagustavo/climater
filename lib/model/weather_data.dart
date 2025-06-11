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

    debugPrint('coords: $coord \n\n\n');
    debugPrint('main: $main \n\n\n');
    debugPrint('weather: $weather \n\n\n');
    debugPrint('wind: $wind \n\n\n');

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
