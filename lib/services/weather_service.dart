import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static final String _apiKey = dotenv.env['API_KEY']!;
  static final String _exclude = 'minutely,hourly,daily,alerts';
  static final String _units = 'metric';

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
