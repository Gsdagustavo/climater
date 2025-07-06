import 'package:climater/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext context)> appRoutes = {
    HomePage.route: (_) => const HomePage(),
  };

  static const String initialRoute = HomePage.route;
}
