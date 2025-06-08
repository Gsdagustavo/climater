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
