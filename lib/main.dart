import 'package:climater/database/database.dart';
import 'package:flutter/material.dart';

/// This is the entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBConnection().getDatabase();
  await WeatherController().insert();
  await WeatherController().select();

  /// Loads the environment variables (API Keys) from the .env file
  // await dotenv.load();
  // runApp(const MyApp());
}
