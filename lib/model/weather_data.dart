import 'package:geocode/geocode.dart';

class WeatherData {
  final Address address;
  final double temperature;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final String main;
  final String description;

  WeatherData({
    required this.address,
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.main,
    required this.description,
  });

  String formatDescription() {
    return description
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(0, word.length);
        })
        .join(' ');
  }
}
