import 'package:climater/providers/theme_provider.dart';
import 'package:climater/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/weather_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text('Climater'), centerTitle: true),

        body: Consumer<WeatherProvider>(
          builder: (_, weatherState, __) {
            final weatherData = weatherState.weatherData;

            if (weatherState.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (weatherData == null) {
              return Center(
                child: Text(
                  'An unknown error occurred',
                  style: TextStyle(color: Colors.red.shade300),
                ),
              );
            }

            if (weatherState.hasError) {
              return Center(
                child: Text(
                  'Error: ${weatherState.errorMessage!}',
                  style: TextStyle(color: Colors.red.shade300),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: weatherState.getWeatherData,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 50,
                  ),
                  child: WeatherWidget(weatherData: weatherData),
                ),
              ),
            );
          },
        ),

        drawer: Consumer<ThemeProvider>(
          builder: (_, themeState, __) {
            return Drawer(
              child: Column(
                children: [
                  DrawerHeader(child: Icon(Icons.settings, size: 80)),
                  ListTile(
                    title: Text('Dark mode', style: TextStyle(fontSize: 18)),
                    trailing: Switch(
                      value: themeState.isDarkMode,
                      onChanged: (_) => themeState.toggleTheme(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
