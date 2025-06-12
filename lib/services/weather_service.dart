import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../util/temperature_util.dart';

class WeatherService {
  /// Contains the [OpenWeatherMap API Key] retrieved from the [.env] file
  static final String _apiKey = dotenv.env['OPENWEATHER_API_KEY']!;

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

    debugPrint('Response: ${response.toString()}');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;

      debugPrint('Result: $result');

      return result;
    } else {
      debugPrint(
        'Error while trying to fetch the weather data. Code: ${response.statusCode}',
      );

      return null;
    }
  }
}
