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
              return FutureBuilder(
                future: state.getWeatherData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final String? data = snapshot.data;

                  if (data == null) {
                    return Text(snapshot.error.toString());
                  }

                  return Text(snapshot.data!);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
