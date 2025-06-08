import 'package:climater/services/weather_service.dart';
import 'package:flutter/widgets.dart';

class WeatherProvider with ChangeNotifier {
  final cityController = TextEditingController(text: 'London');

  bool hasError = false;
  String? errorMessage;

  Future<String?> getWeatherData() async {
    final String city = cityController.text;
    final data = await WeatherService().fetchWeatherData(city: city);

    if (data == null || data.isEmpty) {
      hasError = true;
      errorMessage = 'An error occurred while trying to fetch the weather data';
      return null;
    }

    return '${data['name']}: ${data['main']['temp']} C';
  }
}
