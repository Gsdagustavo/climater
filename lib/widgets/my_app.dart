import 'package:climater/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';

/// Represents the name of the app
const String appTitle = 'Climater';

/// Sets the [debugCheckedModeBanner] param in the [MaterialApp] to be false
const bool showDebugBanner = false;

/// This is the main app [MaterialApp]
///
/// The default route is the [HomePage], but in the future more routes and pages
/// will be added
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
            theme: state.themeData,
          );
        },
      ),
    );
  }
}
