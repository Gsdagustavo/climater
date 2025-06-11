import 'package:climater/widgets/weather_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/weather_data.dart';
import 'fab_container.dart';

/// This is the main widget that will be displayed in the [HomePage]
///
/// It contains the current city, the weather description, an image representing
/// the weather, the temperature (displayed in Celsisus), and many other infos
class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    final city = weatherData.city;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// City name
        Text(
          city,
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        Padding(padding: EdgeInsets.all(12)),

        /// Weather Description
        Text(weatherData.formatDescription(), style: TextStyle(fontSize: 24)),

        /// Weather image
        _ImageBuilder(description: weatherData.description),

        /// Temperature
        Text(
          '${weatherData.temperature.toStringAsFixed(0)} °C',
          style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        ),

        Padding(padding: EdgeInsets.all(32)),

        _FullWeatherInfos(weatherData: weatherData),
      ],
    );
  }
}

class _FullWeatherInfos extends StatelessWidget {
  const _FullWeatherInfos({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Temperature infos
        FabWeatherInfo(
          label: 'Temperature',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 15,
            children: [
              FabContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(FontAwesomeIcons.temperatureLow),

                    Padding(padding: EdgeInsets.all(5)),

                    Text(
                      'Min: ${weatherData.minTemp.toStringAsFixed(0)} °C',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

              FabContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(FontAwesomeIcons.temperatureHigh),

                    Padding(padding: EdgeInsets.all(5)),

                    Text(
                      'Max: ${weatherData.maxTemp.toStringAsFixed(0)} °C',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

              FabContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(FontAwesomeIcons.temperatureHalf),

                    Padding(padding: EdgeInsets.all(5)),

                    Text(
                      'Feels like: ${weatherData.feelsLike.toStringAsFixed(0)} °C',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(padding: EdgeInsets.all(12)),

        /// Wind infos
        FabWeatherInfo(
          label: 'Wind',
          child: Row(
            children: [
              FabContainer(
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.compass),

                    Padding(padding: EdgeInsets.all(5)),

                    Text(
                      'Wind direction: ${weatherData.windDirection} °',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),

              Padding(padding: EdgeInsets.all(12)),

              FabContainer(
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.wind),

                    Padding(padding: EdgeInsets.all(5)),

                    Text(
                      'Wind speed: ${weatherData.windSpeed} m/s',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(padding: EdgeInsets.all(12)),

        /// Rain infos
        FabWeatherInfo(
          label: 'Rain',
          child: FabContainer(
            child: Row(
              children: [
                Icon(Icons.cloudy_snowing),
                Padding(padding: EdgeInsets.all(5)),
                Text(
                  'Precipitation: ${weatherData.rain} mm/h',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ),

        Padding(padding: EdgeInsets.all(12)),

        /// Other infos (humidity and pressure)
        FabWeatherInfo(
          label: 'Other infos',
          child: Row(
            children: [
              FabContainer(
                child: Row(
                  children: [
                    Icon(Icons.water_drop_outlined),

                    Padding(padding: EdgeInsets.all(5)),

                    Text(
                      'Humidity: ${weatherData.humidity}%',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),

              Padding(padding: EdgeInsets.all(12)),

              FabContainer(
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.gaugeHigh),

                    Padding(padding: EdgeInsets.all(5)),

                    Text(
                      'Pressure: ${weatherData.pressure} hpa',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FabWeatherInfo extends StatelessWidget {
  const FabWeatherInfo({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),

        Padding(padding: EdgeInsets.all(8)),

        /// Rain infos
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: child,
        ),
      ],
    );
  }
}

/// Returns a [WeatherImage] from the given description
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

/// Returns a [_Weather] enum from the given [weather description]
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

/// Contains all the weather situations retrieved from the [OpenWeatherMap API]
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
