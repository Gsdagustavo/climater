import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _url = 'https://api.openweathermap.org/data/2.5/weather/';
  static final String apiKey = dotenv.env['API_KEY']!;

  Future<Map<String, dynamic>?> fetchWeatherData({required String city}) async {
    final uri = Uri.parse('$_url?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(
        'Error while trying to fetch the weather data. Code: ${response.statusCode}',
      );
      return null;
    }
  }
}
