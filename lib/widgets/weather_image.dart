import 'package:flutter/material.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(imagePath, scale: 0.5));
  }
}
