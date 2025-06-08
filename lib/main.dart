import 'package:climater/pages/home_page.dart';
import 'package:flutter/material.dart';

const String appTitle = 'Climater';
const bool showDebugBanner = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: showDebugBanner,

      routes: {
        '/homePage': (_) => const HomePage(),
      },

      initialRoute: '/homePage',
    );
  }
}