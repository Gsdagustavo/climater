import 'dart:convert';

import 'package:climater/pages/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../util/temperature_util.dart';

class WeatherService {
  /// Contains the [OpenWeatherMap API Key] retrieved from the [.env] file
  static final String _apiKey = dotenv.env['OPENWEATHER_API_KEY']!;

  /// Defines what to exclude from the query
  static final String _exclude = 'minutely, hourly';

  /// Defines the basic unit system
  ///
  /// Actually, it is setted to be metric, but in the future will be added a
  /// feature to detect the system's default unit system and display it in the
  /// home page (instead of showing the temperature in Celsius, show it in
  /// Fahrenheit also)
  // static final String _units = 'metric';

  /// Returns a JSON fetched from the [OpenWeatherMap API]
  Future<Map<String, dynamic>?> fetchWeatherData({
    required double latitude,
    required double longitude,
    UnitSystem unit = UnitSystem.metric,
  }) async {
    final uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&units=${unit.name}',
    );

    final response = await http.get(uri);

    print('Response: ${response.toString()}');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;

      print('Result: $result');

      return result;
    } else {
      print(
        'Error while trying to fetch the weather data. Code: ${response.statusCode}',
      );
      return null;
    }
  }
}
