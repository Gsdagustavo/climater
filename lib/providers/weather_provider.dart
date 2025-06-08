import 'package:climater/services/weather_service.dart';
import 'package:flutter/widgets.dart';

class WeatherProvider with ChangeNotifier {
  final cityController = TextEditingController(text: 'London');
  WeatherData? weatherData;

  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  WeatherProvider() {
    _init();
  }

  _init() async {
    await getWeatherData();
  }

  Future<void> getWeatherData() async {
    isLoading = true;
    notifyListeners();

    final String city = cityController.text;
    final data = await WeatherService().fetchWeatherData(city: city);

    if (data == null || data.isEmpty) {
      hasError = true;
      errorMessage = 'An error occurred while trying to fetch the weather data';
      return;
    }

    hasError = false;
    errorMessage = null;

    isLoading = false;

    weatherData = WeatherData(city, data['main']['temp']);
    notifyListeners();
  }
}

class WeatherData {
  final String city;
  final double temperature;

  WeatherData(this.city, this.temperature);
}
