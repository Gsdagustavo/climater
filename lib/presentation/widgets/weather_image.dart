import 'package:flutter/material.dart';

/// This is a basic model [Image] to represent the current weather situation.
///
///  It is used in the [Home Page]
class WeatherImage extends StatelessWidget {
  const WeatherImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(imagePath, scale: 0.5));
  }
}
