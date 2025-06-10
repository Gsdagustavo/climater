import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  /// Contains the [OpenWeatherMap API Key] retrieved from the [.env] file
  static final String _apiKey = dotenv.env['OPENWEATHER_API_KEY']!;

  /// Defines what to exclude from the query
  static final String _exclude = 'minutely,hourly,daily,alerts';

  /// Defines the basic unit system
  ///
  /// Actually, it is setted to be metric, but in the future will be added a
  /// feature to detect the system's default unit system and display it in the
  /// home page (instead of showing the temperature in Celsius, show it in
  /// Fahrenheit also)
  static final String _units = 'metric';

  /// Returns a JSON fetched from the [OpenWeatherMap API]
  Future<Map<String, dynamic>?> fetchWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&exclude=$_exclude&appid=$_apiKey&units=$_units',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'Error while trying to fetch the weather data. Code: ${response.statusCode}',
      );
      return null;
    }
  }
}
