import 'package:climater/core/constants/version.dart';
import 'package:climater/providers/last_update_provider.dart';
import 'package:climater/providers/theme_provider.dart';
import 'package:climater/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/temperature_util.dart';
import '../widgets/weather_widget.dart';

/// This is the Home Page of the app.
///
/// Currently, it is the only page of the app, but in the future more pages
/// will be added
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (_, weatherState, __) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Climater'),
                Consumer<LastUpdateProvider>(
                  builder: (_, state, __) {
                    return Text(
                      'Last update: ${state.lastUpdateTime ?? 'Never updated'}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  },
                ),
              ],
            ),
            centerTitle: true,
          ),

          body: Builder(
            builder: (context) {
              final weatherData = weatherState.weatherData;

              if (weatherState.isLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
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
                      horizontal: 16,
                      vertical: 50,
                    ),
                    child: WeatherWidget(weatherData: weatherData),
                  ),
                ),
              );
            },
          ),

          drawer: const _HomePageDrawer(),
        );
      },
    );
  }
}

/// A Drawer designed for the Home Page
///
/// Contains the Switch for toggling the theme and a label that shows the
/// current version of the app
class _HomePageDrawer extends StatelessWidget {
  const _HomePageDrawer();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeState, __) {
        return Drawer(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              children: [
                DrawerHeader(child: Icon(Icons.settings, size: 80)),

                ListTile(
                  title: Text(
                    'Dark mode',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Switch(
                    value: themeState.isDarkMode,
                    onChanged: (_) => themeState.toggleTheme(),
                  ),
                ),

                ListTile(
                  title: Text(
                    'Temperature unit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: _TemperaturesDropDownButton(),
                ),

                Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ListTile(
                    title: Text(
                      'Version $appVersion',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TemperaturesDropDownButton extends StatelessWidget {
  const _TemperaturesDropDownButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (_, state, __) {
        return DropdownButton<UnitSystem>(
          value: state.unitSystem,
          icon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_downward, size: 24),
          ),

          underline: Container(color: Colors.transparent),

          items: [
            for (final value in UnitSystem.values)
              DropdownMenuItem(
                value: value,
                child: Text(
                  '° ${TemperatureUtil.getTemperatureInitial(value)}',
                ),
              ),
          ],

          onChanged: (value) {
            state.toggleTemperatureUnit();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
