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
      child: Consumer<WeatherProvider>(
        builder: (_, state, __) {
          return Scaffold(
            appBar: AppBar(title: Text('Climater'), centerTitle: true),

            body: Builder(
              builder: (context) {
                final weatherData = state.weatherData;

                if (state.isLoading) {
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

                if (state.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${state.errorMessage!}',
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
                await state.getWeatherData();
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
            color: Colors.deepPurple.shade200,
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(address.region!, style: TextStyle(fontSize: 32)),
      ],
    );
  }
}
