import 'package:geocode/geocode.dart';

class WeatherData {
  final Address address;
  final double temperature;
  final String main;
  final String description;

  final double maxTemperature;
  final double minTemperature;
  final double feelsLike;
  final int pressure;
  final int humidity;

  WeatherData({
    required this.address,
    required this.temperature,
    required this.main,
    required this.description,
    required this.maxTemperature,
    required this.minTemperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
  });

  /// Returns a capitalized version of the [description]
  String formatDescription() {
    var desc = '';

    for (final word in description.split(' ')) {
      desc += word[0].toUpperCase();
      desc += word.substring(1);
      desc += ' ';
    }

    return desc;
  }
}
