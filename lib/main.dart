import 'package:climater/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// This is the entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Loads the environment variables (API Keys) from the .env file
  await dotenv.load();
  runApp(const MyApp());
}
