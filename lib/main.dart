import 'package:climater/providers/last_update_provider.dart';
import 'package:climater/providers/weather_provider.dart';
import 'package:climater/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

/// This is the entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Loads the environment variables (API Keys) from the .env file
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LastUpdateProvider()),

        ChangeNotifierProxyProvider<LastUpdateProvider, WeatherProvider>(
          create: (context) {
            return WeatherProvider(context.read<LastUpdateProvider>());
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
