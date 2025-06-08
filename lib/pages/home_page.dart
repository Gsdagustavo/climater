import 'package:climater/providers/theme_provider.dart';
import 'package:climater/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/weather_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: Consumer2<WeatherProvider, ThemeProvider>(
        builder: (_, weatherState, themeState, __) {
          return Scaffold(
            appBar: AppBar(title: Text('Climater'), centerTitle: true),

            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(child: Icon(Icons.settings, size: 80)),
                  ListTile(
                    title: Text('Switch Theme Mode'),
                    trailing: IconButton(
                      onPressed: themeState.toggleTheme,
                      icon: Icon(
                        themeState.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            body: Builder(
              builder: (context) {
                final weatherData = weatherState.weatherData;

                if (weatherState.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (weatherData == null) {
                  return Center(
                    child: Text(
                      'An unknown error occurred',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (weatherState.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${weatherState.errorMessage!}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45,
                    vertical: 75,
                  ),
                  child: WeatherWidget(weatherData: weatherData),
                );
              },
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await weatherState.getWeatherData();
              },
            ),
          );
        },
      ),
    );
  }
}

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

        ImageBuilder(description: weatherData.description),

        Text(
          '${weatherData.temperature.toStringAsFixed(0)} °C',
          style: TextStyle(
            // color: Colors.deepPurple.shade400,
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final weather = parseWeather(description);

        switch (weather) {
          case Weather.clearSky:
            return WeatherImage(imagePath: 'assets/images/01d@2x.png');
          case Weather.fewClouds:
            return WeatherImage(imagePath: 'assets/images/02d@2x.png');
          case Weather.scatteredClouds:
            return WeatherImage(imagePath: 'assets/images/03d@2x.png');
          case Weather.brokenClouds:
            return WeatherImage(imagePath: 'assets/images/04d@2x.png');
          case Weather.showerRain:
            return WeatherImage(imagePath: 'assets/images/09d@2x.png');
          case Weather.rain:
            return WeatherImage(imagePath: 'assets/images/10d@2x.png');
          case Weather.thunderstorm:
            return WeatherImage(imagePath: 'assets/images/11d@2x.png');
          case Weather.snow:
            return WeatherImage(imagePath: 'assets/images/12d@2x.png');
          case Weather.mist:
            return WeatherImage(imagePath: 'assets/images/13d@2x.png');
        }
      },
    );
  }
}

class WeatherImage extends StatelessWidget {
  const WeatherImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(imagePath, scale: 0.5));
  }
}

enum Weather {
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

Weather parseWeather(String description) {
  switch (description.toLowerCase()) {
    case 'clear sky':
      return Weather.clearSky;
    case 'few clouds':
      return Weather.fewClouds;
    case 'scattered clouds':
      return Weather.scatteredClouds;
    case 'broken clouds':
      return Weather.brokenClouds;
    case 'shower rain':
      return Weather.showerRain;
    case 'rain':
      return Weather.rain;
    case 'thunderstorm':
      return Weather.thunderstorm;
    case 'snow':
      return Weather.snow;
    case 'mist':
      return Weather.mist;
    default:
      return Weather.clearSky;
  }
}
