import 'package:climater/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';

const String appTitle = 'Climater';
const bool showDebugBanner = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_, state, __) {
          return MaterialApp(
            title: appTitle,
            debugShowCheckedModeBanner: showDebugBanner,
            routes: {'/homePage': (_) => const HomePage()},
            initialRoute: '/homePage',
            theme: state.isDarkMode ? darkThemeData : lightThemeData,
          );
        },
      ),
    );
  }
}
