import 'package:climater/widgets/weather_image.dart';
import 'package:flutter/material.dart';

import '../model/weather_data.dart';
import 'fab_container.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    final address = weatherData.address;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          address.city!,
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        Padding(padding: EdgeInsets.all(12)),

        Text(weatherData.formatDescription(), style: TextStyle(fontSize: 24)),

        _ImageBuilder(description: weatherData.description),

        Text(
          '${weatherData.temperature.toStringAsFixed(0)} °C',
          style: TextStyle(
            // color: Colors.deepPurple.shade400,
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
        ),

        Padding(padding: EdgeInsets.all(32)),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 15,
          children: [
            FabContainer(
              child: Text(
                'Min: ${weatherData.minTemperature.toStringAsFixed(1)} °C',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            FabContainer(
              child: Text(
                'Max: ${weatherData.maxTemperature.toStringAsFixed(1)} °C',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsetsGeometry.all(12)),

        FabContainer(
          child: Text(
            'Humidity: ${weatherData.humidity.toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _ImageBuilder extends StatelessWidget {
  const _ImageBuilder({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final weather = _parseWeather(description);

        switch (weather) {
          case _Weather.clearSky:
            return WeatherImage(imagePath: 'assets/images/01d@2x.png');
          case _Weather.fewClouds:
            return WeatherImage(imagePath: 'assets/images/02d@2x.png');
          case _Weather.scatteredClouds:
            return WeatherImage(imagePath: 'assets/images/03d@2x.png');
          case _Weather.brokenClouds:
            return WeatherImage(imagePath: 'assets/images/04d@2x.png');
          case _Weather.showerRain:
            return WeatherImage(imagePath: 'assets/images/09d@2x.png');
          case _Weather.rain:
            return WeatherImage(imagePath: 'assets/images/10d@2x.png');
          case _Weather.thunderstorm:
            return WeatherImage(imagePath: 'assets/images/11d@2x.png');
          case _Weather.snow:
            return WeatherImage(imagePath: 'assets/images/12d@2x.png');
          case _Weather.mist:
            return WeatherImage(imagePath: 'assets/images/13d@2x.png');
        }
      },
    );
  }
}

_Weather _parseWeather(String description) {
  switch (description.toLowerCase()) {
    case 'clear sky':
      return _Weather.clearSky;
    case 'few clouds':
      return _Weather.fewClouds;
    case 'scattered clouds':
      return _Weather.scatteredClouds;
    case 'broken clouds':
      return _Weather.brokenClouds;
    case 'shower rain':
      return _Weather.showerRain;
    case 'rain':
      return _Weather.rain;
    case 'thunderstorm':
      return _Weather.thunderstorm;
    case 'snow':
      return _Weather.snow;
    case 'mist':
      return _Weather.mist;
    default:
      return _Weather.clearSky;
  }
}

enum _Weather {
  clearSky,
  fewClouds,
  scatteredClouds,
  brokenClouds,
  showerRain,
  rain,
  thunderstorm,
  snow,
  mist,
}
