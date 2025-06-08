import 'package:climater/services/weather_service.dart';
import 'package:flutter/widgets.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

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

  Future<void> getCityName() async {
    print('called get city nameawdouhawudiowhduowahiuodwhiudwo');

    final LocationPermission locationPermission;
    locationPermission = await Geolocator.requestPermission();

    print('ASKED PERMISSION RESULT: $locationPermission');

    switch (locationPermission) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
      case LocationPermission.unableToDetermine:
        return;
      case LocationPermission.always:
      case LocationPermission.whileInUse:
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.medium),
    );

    final lat = position.latitude;
    final long = position.longitude;

    final address = await GeoCode().reverseGeocoding(
      latitude: lat,
      longitude: long,
    );
    print(address);
  }
}

class WeatherData {
  final String city;
  final double temperature;

  WeatherData(this.city, this.temperature);
}
