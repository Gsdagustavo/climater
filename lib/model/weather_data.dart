/// Represents weather data collected from the [OpenWeatherMap] API
class WeatherData {
  final String city;
  final double latitude;
  final double longitude;

  final String main;
  final String description;

  final double temperature;
  final double minTemp;
  final double maxTemp;
  final double feelsLike;

  final int pressure;
  final int humidity;

  final double rain;

  final double windSpeed;
  final int windDirection;

  WeatherData({
    required this.city,
    required this.maxTemp,
    required this.feelsLike,
    required this.minTemp,
    required this.latitude,
    required this.longitude,
    required this.main,
    required this.description,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.rain,
    required this.windSpeed,
    required this.windDirection,
  });

  /// Returns a [WeatherData] from the given [main] (json), [weather] (json) and [address]
  factory WeatherData.fromJson({required Map<String, dynamic> json}) {
    final Map<String, dynamic> main = json['main'];
    final Map<String, dynamic> wind = json['wind'];

    final rainData = json['rain'] as Map<String, dynamic>?;
    final rainLastHour =
        rainData != null && rainData.containsKey('1h') ? rainData['1h'] : 0.0;

    return WeatherData(
      // location
      city: json['name'],
      latitude: json['coord']['lat'] as double,
      longitude: json['coord']['lon'] as double,

      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],

      // temperature
      temperature: main['temp'] as double,
      maxTemp: main['temp_max'] as double,
      minTemp: main['temp_min'] as double,
      feelsLike: main['feels_like'] as double,

      // pressure and humidity
      humidity: main['humidity'] as int,
      pressure: main['pressure'] as int,

      // rain
      rain: rainLastHour as double,

      // wind
      windDirection: wind['deg'] as int,
      windSpeed: wind['speed'] as double,
    );
  }

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

  @override
  String toString() {
    return 'WeatherData{city: $city, latitude: $latitude, longitude: $longitude, main: $main, description: $description, temperature: $temperature, minTemp: $minTemp, maxTemp: $maxTemp, feelsLike: $feelsLike, pressure: $pressure, humidity: $humidity}';
  }
}
