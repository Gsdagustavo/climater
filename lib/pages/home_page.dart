import 'package:climater/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: Scaffold(
        body: Center(
          child: Consumer<WeatherProvider>(
            builder: (_, state, __) {
              final weatherData = state.weatherData;

              if (state.isLoading) {
                return CircularProgressIndicator();
              }

              if (weatherData == null) {
                return Text(
                  'An unknown error occurred',
                  style: TextStyle(color: Colors.red),
                );
              }

              if (state.hasError) {
                return Text(
                  'Error: ${state.errorMessage!}',
                  style: TextStyle(color: Colors.red),
                );
              }

              return WeatherWidget(weatherData: weatherData);
            },
          ),
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('${weatherData.city}: ${weatherData.temperature} C')],
    );
  }
}
