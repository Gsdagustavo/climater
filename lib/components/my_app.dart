import 'package:flutter/material.dart';

import '../pages/home_page.dart';

const String appTitle = 'Climater';
const bool showDebugBanner = false;

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