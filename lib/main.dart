import 'package:climater/modules/weather_data/weather_data_repository.dart';
import 'package:climater/modules/weather_data/weather_data_usecase.dart';
import 'package:climater/presentation/states/last_update_provider.dart';
import 'package:climater/presentation/states/weather_provider.dart';
import 'package:climater/presentation/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

/// This is the entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final weatherDataRepository = WeatherDataRepositoryImpl();
  final weatherDataUseCase = WeatherDataUseCaseImpl(weatherDataRepository);

  /// Loads the environment variables (API Keys) from the .env file
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LastUpdateProvider()),

        ChangeNotifierProxyProvider<LastUpdateProvider, WeatherProvider>(
          create: (context) {
            return WeatherProvider(
              context.read<LastUpdateProvider>(),
              weatherDataUseCase,
            );
          },

          update: (context, lastUpdateProvider, previous) {
            return previous!..updateLastUpdateProvider(lastUpdateProvider);
          },
        ),
      ],

      child: const MyApp(),
    ),
  );
}
