import 'package:geocode/geocode.dart';

class WeatherData {
  final Address address;
  final double temperature;
  final double feelsLike;
  final int pressure;
  final int humidity;

  WeatherData({
    required this.address,
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
  });
}
