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
                    vertical: 150,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${weatherData.temperature.toStringAsFixed(0)} °C',
          style: TextStyle(
            color: Colors.deepPurple.shade400,
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(address.region!, style: TextStyle(fontSize: 32)),
      ],
    );
  }
}
